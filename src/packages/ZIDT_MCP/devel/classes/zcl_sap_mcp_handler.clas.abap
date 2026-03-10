*&---------------------------------------------------------------------*
*& 类定义: ZCL_SAP_MCP_HANDLER
*&---------------------------------------------------------------------*
*& 描述: HTTP请求处理类，实现 IF_HTTP_EXTENSION 接口
*&       处理MCP工具调用的核心逻辑
*&---------------------------------------------------------------------*
CLASS zcl_sap_mcp_handler DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_http_extension.

    CONSTANTS:
      " HTTP状态码
      gc_http_200        TYPE i VALUE 200,
      gc_http_400        TYPE i VALUE 400,
      gc_http_404        TYPE i VALUE 404,
      gc_http_500        TYPE i VALUE 500,
      gc_http_503        TYPE i VALUE 503,

      " 最大请求大小 (1MB)
      gc_max_request_size TYPE i VALUE 1048576,

      " 错误消息
      gc_err_invalid_json TYPE string VALUE 'Invalid JSON format',
      gc_err_tool_not_found TYPE string VALUE 'Tool not found',
      gc_err_tool_inactive TYPE string VALUE 'Tool is inactive',
      gc_err_request_too_large TYPE string VALUE 'Request size exceeds limit',
      gc_err_fm_not_found TYPE string VALUE 'Function module not found',
      gc_err_call_failed TYPE string VALUE 'Function call failed'.

    " 方法: 处理HTTP请求
    METHODS:
      handle_request_mcp
        IMPORTING
          iv_tool_id     TYPE string
          iv_request_data TYPE string
        RETURNING
          VALUE(rv_response) TYPE string,

      " 记录请求日志
      request_mcp_log
        IMPORTING
          iv_tool_id       TYPE string
          iv_request_data  TYPE string
        RETURNING
          VALUE(rv_log_guid) TYPE guid_16,

      " 更新响应日志
      response_mcp_log
        IMPORTING
          iv_log_guid      TYPE guid_16
          iv_response_data TYPE string,

      " 从查询字符串提取工具ID
      extract_tool_id
        IMPORTING
          iv_query_string TYPE string
        RETURNING
          VALUE(rv_tool_id) TYPE string,

      " 验证函数模块是否存在
      validate_function_module
        IMPORTING
          iv_fm_name TYPE string
        RETURNING
          VALUE(rv_exists) TYPE abap_bool,

      " 调用MCP函数
      call_mcp_function
        IMPORTING
          iv_tool_id     TYPE string
          iv_request_data TYPE string
        RETURNING
          VALUE(rv_response) TYPE string,

      " 验证请求大小
      validate_request_size
        IMPORTING
          iv_request_data TYPE string
        RETURNING
          VALUE(rv_valid) TYPE abap_bool,

      " 设置错误响应
      set_error_response
        IMPORTING
          iv_http_status TYPE i
          iv_error_msg   TYPE string
        RETURNING
          VALUE(rv_response) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.
