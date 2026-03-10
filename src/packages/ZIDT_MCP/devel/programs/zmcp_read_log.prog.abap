*&---------------------------------------------------------------------*
*& 程序: ZMCP_READ_LOG
*&---------------------------------------------------------------------*
*& 描述: MCP工具调用日志查看报表（ALV展示）
*&       支持按工具ID、日期、时间筛选
*&       双击查看JSON详情（支持格式化显示）
*&---------------------------------------------------------------------*
REPORT zmcp_read_log.

TABLES: zidt_mcp_log.

" 选择屏幕
SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-s01.
  SELECT-OPTIONS:
    s_toolid FOR zidt_mcp_log-tool_id,
    s_date   FOR zidt_mcp_log-request_datum,
    s_time   FOR zidt_mcp_log-request_uzeit.
SELECTION-SCREEN END OF BLOCK blk1.

" 工具栏按钮
SELECTION-SCREEN FUNCTION KEY 1. " 刷新按钮

INITIALIZATION.
  " 初始化工具栏
  sscrfields-functxt_01 = '@2P@ 刷新'.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM display_alv.

*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
FORM get_data.

  DATA:
    lt_log TYPE STANDARD TABLE OF zidt_mcp_log WITH EMPTY KEY.

  " 查询日志数据
  SELECT *
    FROM zidt_mcp_log
    INTO TABLE @lt_log
    WHERE tool_id        IN @s_toolid
      AND request_datum  IN @s_date
      AND request_uzeit  IN @s_time
    ORDER BY request_datum DESCENDING
             request_uzeit DESCENDING.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
FORM display_alv.

  DATA:
    lo_alv       TYPE REF TO cl_salv_table,
    lo_functions TYPE REF TO cl_salv_functions_list,
    lo_columns   TYPE REF TO cl_salv_columns_table,
    lo_column    TYPE REF TO cl_salv_column_table,
    lo_events    TYPE REF TO cl_salv_events_table,
    lo_display   TYPE REF TO cl_salv_display_settings.

  TRY.
      " 创建ALV
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = gt_log ).

      " 设置工具栏功能
      lo_functions = lo_alv->get_functions( ).
      lo_functions->set_all( abap_true ).

      " 设置列属性
      lo_columns = lo_alv->get_columns( ).
      lo_columns->set_optimize( abap_true ).

      " 隐藏技术字段
      lo_column ?= lo_columns->get_column( 'MANDT' ).
      lo_column->set_visible( abap_false ).

      " 设置显示优化
      lo_display = lo_alv->get_display_settings( ).
      lo_display->set_striped_pattern( abap_true ).
      lo_display->set_list_header( 'MCP工具调用日志' ).

      " 注册事件
      lo_events = lo_alv->get_event( ).
      SET HANDLER lcl_event_handler=>on_double_click FOR lo_events.

      " 显示ALV
      lo_alv->display( ).

    CATCH cx_salv_error INTO DATA(lx_exc).
      MESSAGE lx_exc->get_text( ) TYPE 'E'.
  ENDTRY.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form SHOW_JSON_DETAIL
*&---------------------------------------------------------------------*
FORM show_json_detail USING iv_log_guid TYPE guid_16.

  DATA:
    ls_log     TYPE zidt_mcp_log,
    lv_html    TYPE string,
    lo_browser TYPE REF TO cl_abap_browser.

  " 获取日志详情
  SELECT SINGLE * FROM zidt_mcp_log
    INTO @ls_log
    WHERE log_guid = @iv_log_guid.

  " 生成HTML内容
  lv_html = |<html><head><title>JSON详情</title>| &&
            |<style>| &&
            |body { font-family: monospace; padding: 10px; }| &&
            |.title { color: #0066cc; font-weight: bold; }| &&
            |.json { white-space: pre-wrap; background: #f5f5f5; padding: 10px; }| &&
            |</style></head><body>| &&
            |<div class="title">请求数据</div>| &&
            |<div class="json">{ ls_log-request_data }</div>| &&
            |<br/>| &&
            |<div class="title">响应数据</div>| &&
            |<div class="json">{ ls_log-response_data }</div>| &&
            |</body></html>|.

  " 显示HTML
  CREATE OBJECT lo_browser
    EXPORTING
      parent        = cl_gui_container=>default_screen.
  lo_browser->show_html( html_string = lv_html ).

ENDFORM.

*&---------------------------------------------------------------------*
*& 局部类: 事件处理器
*&---------------------------------------------------------------------*
CLASS lcl_event_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      on_double_click
        FOR EVENT double_click OF cl_salv_events_table
        IMPORTING
          row
          column.
ENDCLASS.

CLASS lcl_event_handler IMPLEMENTATION.
  METHOD on_double_click.
    READ TABLE gt_log INTO DATA(ls_log) INDEX row.
    IF sy-subrc = 0.
      PERFORM show_json_detail USING ls_log-log_guid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

AT SELECTION-SCREEN.
  " 处理工具栏按钮点击
  IF sy-ucomm = 'FC01'.
    rs_selfresh-refresh = abap_true.
  ENDIF.
