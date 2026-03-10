*&---------------------------------------------------------------------*
*& 函数模块: ZIDT_FM_MCP_TOOL_DETAIL
*&---------------------------------------------------------------------*
*& 描述: 获取指定工具的详细信息（参数定义、类型等）
*&---------------------------------------------------------------------*
FUNCTION ZIDT_FM_MCP_TOOL_DETAIL.
*"----------------------------------------------------------------------
*"*"本地接口：
*"  IMPORTING
*"     VALUE(TOOL_ID) TYPE  ZIDT_E_TOOL_ID
*"     VALUE(PARAM_TYPE) TYPE  CHAR10 OPTIONAL
*"  EXPORTING
*"     VALUE(TOOL_DETAIL) TYPE  STRING
*"     VALUE(ERROR_MSG) TYPE  STRING
*"  EXCEPTIONS
*"      TOOL_NOT_FOUND
*"      PARAMETER_ERROR
*"      JSON_SERIALIZE_ERROR
*"----------------------------------------------------------------------

  DATA:
    ls_tool      TYPE zidt_mcp_tools,
    lv_fm_name   TYPE rs38l_fnam,
    lt_params    TYPE STANDARD TABLE OF rsimp WITH EMPTY KEY,
    lv_json      TYPE string,
    lv_result    TYPE string.

  " ============================================================
  " 1. 查询工具配置
  " ============================================================
  SELECT SINGLE * FROM zidt_mcp_tools
    INTO @ls_tool
    WHERE tool_id = @tool_id.

  IF sy-subrc <> 0.
    error_msg = |Tool { tool_id } not found|.
    RAISE EXCEPTION TYPE cx_sy_open_sql_db.
  ENDIF.

  " ============================================================
  " 2. 获取函数模块参数接口
  " ============================================================
  lv_fm_name = ls_tool-sys_name.

  CALL FUNCTION 'FUNCTION_IMPORT_INTERFACE'
    EXPORTING
      funcname           = lv_fm_name
    TABLES
      parameter_list     = lt_params
    EXCEPTIONS
      error_message      = 1
      function_not_found = 2
      invalid_name       = 3
      OTHERS             = 4.

  IF sy-subrc <> 0.
    error_msg = |Function module { lv_fm_name } not found or invalid|.
    RAISE EXCEPTION TYPE cx_sy_dynamic_osql_error.
  ENDIF.

  " ============================================================
  " 3. 构建JSON Schema响应
  " ============================================================
  TRY.
      " 使用工具类生成JSON Schema
      lv_result = lcl_mcp_json_util=>build_tool_detail_json(
        iv_tool_id    = tool_id
        it_params     = lt_params
        iv_param_type = param_type ).

      tool_detail = lv_result.

    CATCH cx_root INTO DATA(lx_exc).
      error_msg = lx_exc->get_text( ).
      RAISE EXCEPTION TYPE cx_sy_dynamic_osql_error.
  ENDTRY.

ENDFUNCTION.
