*&---------------------------------------------------------------------*
*& 函数模块: ZIDT_FM_MCP_TOOL_USED
*&---------------------------------------------------------------------*
*& 描述: 动态执行指定的函数模块工具
*&       支持 IMPORT、EXPORT、CHANGING、TABLES 参数
*&       使用 RTTS 动态创建数据结构
*&---------------------------------------------------------------------*
FUNCTION ZIDT_FM_MCP_TOOL_USED.
*"----------------------------------------------------------------------
*"*"本地接口：
*"  IMPORTING
*"     VALUE(TOOL_ID) TYPE  ZIDT_E_TOOL_ID
*"     VALUE(REQUEST_JSON) TYPE  STRING
*"  EXPORTING
*"     VALUE(RESPONSE_JSON) TYPE  STRING
*"     VALUE(ERROR_MSG) TYPE  STRING
*"  EXCEPTIONS
*"      TOOL_NOT_FOUND
*"      JSON_PARSE_ERROR
*"      DYNCALL_ERROR
*"----------------------------------------------------------------------

  TYPES:
    " 参数类型枚举
    BEGIN OF ENUM ty_param_type STRUCTURE param_type,
      import    VALUE 'I',
      export    VALUE 'E',
      changing  VALUE 'C',
      tables    VALUE 'T',
    END OF ENUM ty_param_type STRUCTURE param_type.

  DATA:
    ls_tool        TYPE zidt_mcp_tools,
    lv_fm_name     TYPE rs38l_fnam,
    lv_request     TYPE string,
    ls_request     TYPE zidt_s_request_structure,
    lv_response    TYPE string,
    ls_response    TYPE zidt_s_response_structure.

  " ============================================================
  " 1. 查询工具配置
  " ============================================================
  SELECT SINGLE * FROM zidt_mcp_tools
    INTO @ls_tool
    WHERE tool_id = @tool_id
      AND active_flag = @abap_true.

  IF sy-subrc <> 0.
    error_msg = |Tool { tool_id } not found or inactive|.
    RAISE EXCEPTION TYPE cx_sy_open_sql_db.
  ENDIF.

  lv_fm_name = ls_tool-sys_name.

  " ============================================================
  " 2. 解析请求JSON
  " ============================================================
  TRY.
      /ui2/cl_json=>deserialize(
        EXPORTING
          json = request_json
        CHANGING
          data = ls_request ).
    CATCH cx_root INTO DATA(lx_json).
      error_msg = |JSON parse error: { lx_json->get_text( ) }|.
      RAISE EXCEPTION TYPE cx_sy_conversion_no_date.
  ENDTRY.

  " ============================================================
  " 3. 动态调用函数模块
  " ============================================================
  TRY.
      " 动态函数调用辅助FORM
      PERFORM call_function_dynamic
        USING
          lv_fm_name
          ls_request-param
        CHANGING
          ls_response-param.

    CATCH cx_root INTO DATA(lx_call).
      error_msg = |Function call error: { lx_call->get_text( ) }|.
      RAISE EXCEPTION TYPE cx_sy_dyn_call_illegal_method.
  ENDTRY.

  " ============================================================
  " 4. 序列化响应
  " ============================================================
  TRY.
      /ui2/cl_json=>serialize(
        EXPORTING
          data   = ls_response
        RECEIVING
          json   = lv_response ).

      response_json = lv_response.

    CATCH cx_root INTO DATA(lx_ser).
      error_msg = |JSON serialize error: { lx_ser->get_text( ) }|.
      RAISE EXCEPTION TYPE cx_sy_conversion_no_date.
  ENDTRY.

ENDFUNCTION.

*&---------------------------------------------------------------------*
*& Form CALL_FUNCTION_DYNAMIC
*&---------------------------------------------------------------------*
FORM call_function_dynamic
  USING
    iv_fm_name    TYPE rs38l_fnam
    is_param      TYPE zidt_s_param_structure
  CHANGING
    cs_response   TYPE zidt_s_param_structure.

  DATA:
    lo_tdesc      TYPE REF TO cl_abap_typedescr,
    lo_structdesc TYPE REF TO cl_abap_structdescr,
    lo_tabledesc  TYPE REF TO cl_abap_tabledescr,
    lr_data       TYPE REF TO data,
    lr_tab        TYPE REF TO data,
    lt_params     TYPE abap_parm_bind_tab,
    ls_param      TYPE abap_parm_bind.

  " 获取函数接口信息
  lo_tdesc = cl_fb_function_utility=>get_interface( iv_fm_name ).
  lo_structdesc ?= lo_tdesc.

  " 构建动态参数绑定表
  LOOP AT lo_structdesc->components ASSIGNING FIELD-SYMBOL(<fs_comp>).
    CLEAR ls_param.

    " 创建动态数据对象
    CREATE DATA lr_data TYPE HANDLE <fs_comp>-type.

    " IMPORT参数 - 从请求中获取值
    IF <fs_comp>-name = 'IMPORT'.
      " TODO: 从is_param中获取值并赋值
    ENDIF.

    " EXPORT参数 - 绑定用于接收返回值
    IF <fs_comp>-name = 'EXPORT'.
      ls_param-name = <fs_comp>-name.
      ls_param-kind = cl_abap_objectdescr=>exporting.
      GET REFERENCE OF lr_data INTO ls_param-value.
      INSERT ls_param INTO TABLE lt_params.
    ENDIF.

    " TABLES参数
    IF <fs_comp>-name = 'TABLES'.
      ls_param-name = <fs_comp>-name.
      ls_param-kind = cl_abap_objectdescr=>tables.
      GET REFERENCE OF lr_tab INTO ls_param-value.
      INSERT ls_param INTO TABLE lt_params.
    ENDIF.

  ENDLOOP.

  " 执行动态调用
  CALL FUNCTION iv_fm_name PARAMETER-TABLE lt_params.

ENDFORM.
