*&---------------------------------------------------------------------*
*& 类测试: ZCL_SAP_MCP_HANDLER
*&---------------------------------------------------------------------*
CLASS ltcl_test_mcp_handler DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO zcl_sap_mcp_handler. " Class Under Test

    METHODS:
      setup,
      " 测试工具ID提取
      test_extract_tool_id FOR TESTING,
      " 测试请求大小验证
      test_validate_request_size FOR TESTING,
      " 测试错误响应设置
      test_set_error_response FOR TESTING.

ENDCLASS.

CLASS ltcl_test_mcp_handler IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW zcl_sap_mcp_handler( ).
  ENDMETHOD.

  METHOD test_extract_tool_id.
    " 测试从查询字符串中正确提取工具ID
    DATA(lv_query) = |id=TOOL_DETAIL&tool_id=GET_FUNC|.
    DATA(lv_tool_id) = mo_cut->extract_tool_id( lv_query ).
    cl_abap_unit_assert=>assert_equals( act = lv_tool_id exp = 'TOOL_DETAIL' ).
  ENDMETHOD.

  METHOD test_validate_request_size.
    " 测试请求大小验证
    DATA(lv_valid_data) = |{"test": "data"}|.
    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->validate_request_size( lv_valid_data )
      exp = abap_true ).
  ENDMETHOD.

  METHOD test_set_error_response.
    " 测试错误响应格式
    DATA(lv_response) = mo_cut->set_error_response(
      iv_http_status = 400
      iv_error_msg   = 'Test error' ).
    cl_abap_unit_assert=>assert_char_cp( val = lv_response sub = '*error*' ).
  ENDMETHOD.

ENDCLASS.
