*&---------------------------------------------------------------------*
*& 函数模块: ZIDT_FM_MCP_TOOL_LIST
*&---------------------------------------------------------------------*
*& 描述: 获取可用工具列表，支持按分类过滤
*&---------------------------------------------------------------------*
FUNCTION ZIDT_FM_MCP_TOOL_LIST.
*"----------------------------------------------------------------------
*"*"本地接口：
*"  IMPORTING
*"     VALUE(CATEGORY) TYPE  ZIDT_E_CATEGORY OPTIONAL
*"  EXPORTING
*"     VALUE(TOOL_LIST) TYPE  STRING
*"     VALUE(ERROR_MSG) TYPE  STRING
*"  EXCEPTIONS
*"      DATABASE_ERROR
*"      JSON_SERIALIZE_ERROR
*"----------------------------------------------------------------------

  DATA:
    lt_tools   TYPE STANDARD TABLE OF zidt_mcp_tools WITH EMPTY KEY,
    lv_filter  TYPE zidt_e_category,
    lv_json    TYPE string.

  " ============================================================
  " 1. 查询工具列表
  " ============================================================
  IF category IS NOT INITIAL.
    lv_filter = category.
    SELECT * FROM zidt_mcp_tools
      INTO TABLE @lt_tools
      WHERE category = @lv_filter
        AND active_flag = @abap_true.
  ELSE.
    SELECT * FROM zidt_mcp_tools
      INTO TABLE @lt_tools
      WHERE active_flag = @abap_true.
  ENDIF.

  IF sy-subrc <> 0.
    error_msg = 'No active tools found'.
    RAISE EXCEPTION TYPE cx_sy_open_sql_db.
  ENDIF.

  " ============================================================
  " 2. 序列化为JSON
  " ============================================================
  TRY.
      /ui2/cl_json=>serialize(
        EXPORTING
          data   = lt_tools
        RECEIVING
          json   = lv_json ).

      tool_list = lv_json.

    CATCH cx_root INTO DATA(lx_exc).
      error_msg = lx_exc->get_text( ).
      RAISE EXCEPTION TYPE cx_sy_dynamic_osql_error.
  ENDTRY.

ENDFUNCTION.
