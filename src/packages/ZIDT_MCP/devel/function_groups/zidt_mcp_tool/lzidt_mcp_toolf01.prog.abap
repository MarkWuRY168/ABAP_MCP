*&---------------------------------------------------------------------*
*& Include: LZIDT_MCP_TOOLF01
*&---------------------------------------------------------------------*
*& 描述: 工具函数INCLUDE（JSON Schema生成、类型映射等辅助功能）
*&---------------------------------------------------------------------*

**********************************************************************
*** 局部类定义: LCL_MCP_JSON_UTIL
**********************************************************************
CLASS lcl_mcp_json_util DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      " 获取类型的JSON Schema描述
      get_json_schema_for_type
        IMPORTING
          io_type_desc  TYPE REF TO cl_abap_typedescr
        RETURNING
          VALUE(rv_schema) TYPE string,

      " 获取DDIC字段描述
      get_ddic_field_text
        IMPORTING
          iv_tabname   TYPE tabname
          iv_fieldname TYPE fieldname
        RETURNING
          VALUE(rv_text) TYPE text,

      " 构建工具详情JSON
      build_tool_detail_json
        IMPORTING
          iv_tool_id    TYPE zidt_e_tool_id
          it_params     TYPE rsimp_tab
          iv_param_type TYPE char10 OPTIONAL
        RETURNING
          VALUE(rv_json) TYPE string.

  PRIVATE SECTION.
    CLASS-DATA:
      " DDIC字段描述缓存
      gt_ddic_cache TYPE HASHED TABLE OF text
        WITH UNIQUE KEY table_line.
ENDCLASS.

**********************************************************************
*** 局部类实现: LCL_MCP_JSON_UTIL
**********************************************************************
CLASS lcl_mcp_json_util IMPLEMENTATION.

  METHOD get_json_schema_for_type.
    DATA:
      lv_type_kind TYPE abap_typekind,
      lv_length    TYPE i,
      lv_decimals  TYPE i,
      lo_elem_type TYPE REF TO cl_abap_typedescr,
      lo_struct    TYPE REF TO cl_abap_structdescr,
      lo_table     TYPE REF TO cl_abap_tabledescr,
      lv_schema    TYPE string.

    lv_type_kind = io_type_desc->type_kind.

    " 基本类型映射
    CASE lv_type_kind.
      WHEN cl_abap_typedescr=>typekind_char.
        lv_length = io_type_desc->length.
        rv_schema = |"type": "char({ lv_length })"|.

      WHEN cl_abap_typedescr=>typekind_string.
        rv_schema = |"type": "string"|.

      WHEN cl_abap_typedescr=>typekind_date.
        rv_schema = |"type": "data"|.

      WHEN cl_abap_typedescr=>typekind_time.
        rv_schema = |"type": "time"|.

      WHEN cl_abap_typedescr=>typekind_int
           OR cl_abap_typedescr=>typekind_int1
           OR cl_abap_typedescr=>typekind_int2.
        rv_schema = |"type": "integer"|.

      WHEN cl_abap_typedescr=>typekind_packed
           OR cl_abap_typedescr=>typekind_float
           OR cl_abap_typedescr=>typekind_num.
        rv_length = io_type_desc->length.
        lv_decimals = io_type_desc->decimals.
        rv_schema = |"type": "number({ lv_length }{ lv_decimals })"|.

      WHEN cl_abap_typedescr=>typekind_table.
        " 表类型 - 递归获取行类型
        lo_table ?= io_type_desc.
        lo_elem_type = lo_table->get_table_line_type( ).
        lv_schema = get_json_schema_for_type( lo_elem_type ).
        rv_schema = |"type": "array", "items": {{ { lv_schema} }}|.

      WHEN cl_abap_typedescr=>typekind_struct1
           OR cl_abap_typedescr=>typekind_struct2.
        " 结构类型 - 展开所有字段
        lo_struct ?= io_type_desc.
        rv_schema = |"type": "object"|.
        " TODO: 展开结构字段

      WHEN OTHERS.
        rv_schema = |"type": "unknown"|.
    ENDCASE.

  ENDMETHOD.

  METHOD get_ddic_field_text.
    DATA:
      lv_cache_key TYPE string,
      ls_dd03p     TYPE dd03p,
      lv_text      TYPE text.

    " 检查缓存
    lv_cache_key = |{ iv_tabname }-{ iv_fieldname }|.
    READ TABLE gt_ddic_cache INTO lv_text WITH TABLE KEY table_line = lv_cache_key.
    IF sy-subrc = 0.
      rv_text = lv_text.
      RETURN.
    ENDIF.

    " 查询DDIC
    SELECT SINGLE scrtext_m
      FROM dd03p
      INTO @rv_text
      WHERE tabname   = @iv_tabname
        AND fieldname = @iv_fieldname
        AND as4local  = 'A'
        AND as4vers   = '0000'.

    IF rv_text IS INITIAL.
      rv_text = iv_fieldname.
    ENDIF.

    " 写入缓存
    INSERT lv_text INTO TABLE gt_ddic_cache.

  ENDMETHOD.

  METHOD build_tool_detail_json.
    DATA:
      lv_json_part TYPE string,
      lv_result    TYPE string.

    " 根据参数类型构建JSON
    LOOP AT it_params ASSIGNING FIELD-SYMBOL(<fs_param>)
      WHERE paramtype = iv_param_type OR iv_param_type IS INITIAL.

      CASE <fs_param>-paramtype.
        WHEN 'I'. " IMPORT
        WHEN 'E'. " EXPORT
        WHEN 'C'. " CHANGING
        WHEN 'T'. " TABLES
      ENDCASE.

    ENDLOOP.

    rv_json = |{{ "tool_id": "{ iv_tool_id }", "param": {{ { lv_result} }} }}|.

  ENDMETHOD.

ENDCLASS.
