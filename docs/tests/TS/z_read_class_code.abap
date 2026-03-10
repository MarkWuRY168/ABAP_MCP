REPORT z_read_class_code.

DATA: lv_classname TYPE seoclsname VALUE 'CL_GUI_FRONTEND_SERVICES',
      lv_include   TYPE progname,
      lt_source    TYPE TABLE OF abaptxt255.

START-OF-SELECTION.

  " ============================================================
  " 1. 读取类的定义部分
  " ============================================================
  " 获取存放定义代码的Include名 (通常对应 'CCDEF')
  lv_include = cl_oo_classname_service=>get_ccdef_name( lv_classname ).

  IF lv_include IS NOT INITIAL.
    READ REPORT lv_include INTO lt_source.
    IF sy-subrc = 0.
      WRITE: / '=== 类定义 ===', lv_include.
      LOOP AT lt_source INTO DATA(ls_line).
        WRITE: / ls_line-line.
      ENDLOOP.
    ENDIF.
  ENDIF.

  " ============================================================
  " 2. 读取类的实现部分 - 即具体的Method代码
  " ============================================================
  " 获取存放实现代码的Include名 (通常对应 'CCIMP')
  lv_include = cl_oo_classname_service=>get_ccimp_name( lv_classname ).

  IF lv_include IS NOT INITIAL.
    READ REPORT lv_include INTO lt_source.
    IF sy-subrc = 0.
      WRITE: / '=== 类实现 ===', lv_include.
      LOOP AT lt_source INTO DATA(ls_line2).
        WRITE: / ls_line2-line.
      ENDLOOP.
    ENDIF.
  ENDIF.

  " ============================================================
  " 3. 获取类所有的Include列表 (进阶用法)
  " ============================================================
  DATA: lt_includes TYPE seop_methods_w_include.
  
  " 获取该类所有方法的Include映射关系
  lt_includes = cl_oo_classname_service=>get_all_method_includes( lv_classname ).
  
  " 此时 lt_includes 表中包含了每个方法对应的Include名称
  " 如果需要读取特定方法的代码，可以遍历此表找到对应的Include
  LOOP AT lt_includes INTO DATA(ls_meth).
    WRITE: / 'Method:', ls_meth-cpdkey-method, 'Include:', ls_meth-incname.
  ENDLOOP.