url=http://support.learningleader.com.cn:55955/sap/zmcp?id=TOOL_DETAIL&sap-client=100

传入参数：
{
    "TOOL_ID": "GET_FUNC"
}

返回参数：
{
    "tool_id": "GET_FUNC",
    "param": {
        "IMPORT": {
            "FUNCTIONNAME": {
                "name": "功能模块的名称",
                "type": "char(30)"
            }
        },
        "EXPORT": {
            "GLOBAL_FLAG": {
                "name": "全局接口ID",
                "type": "char(1)"
            },
            "REMOTE_CALL": {
                "name": "函数模块的类型 (本地, 远程, ...)",
                "type": "char(1)"
            },
            "UPDATE_TASK": {
                "name": "更新处理过程",
                "type": "char(1)"
            },
            "SHORT_TEXT": {
                "name": "函数模块短文本",
                "type": "char(74)"
            },
            "FUNCTION_POOL": {
                "name": "函数组, 函数模块属于函数组",
                "type": "char(26)"
            },
            "REMOTE_BASXML_SUPPORTED": {
                "name": "BasXML 日志",
                "type": "char(1)"
            }
        },
        "TABLES": {
            "IMPORT_PARAMETER": {
                "type": "array",
                "items": {
                    "PARAMETER": {
                        "name": "参数名称",
                        "type": "char(30)"
                    },
                    "DBFIELD": {
                        "name": " 参考字段/结构参数",
                        "type": "char(26)"
                    },
                    "DEFAULT": {
                        "name": "输入参数的缺省值",
                        "type": "char(21)"
                    },
                    "TYPES": {
                        "name": "参考结构为 ABAP 类型",
                        "type": "char(1)"
                    },
                    "OPTIONAL": {
                        "name": "可选参数",
                        "type": "char(1)"
                    },
                    "REFERENCE": {
                        "name": "使用引用传递调用",
                        "type": "char(1)"
                    },
                    "CHANGING": {
                        "name": "更改允许参数",
                        "type": "char(1)"
                    },
                    "TYP": {
                        "name": "接口参数的关联类型",
                        "type": "char(132)"
                    },
                    "CLASS": {
                        "name": "类参考",
                        "type": "char(1)"
                    },
                    "REF_CLASS": {
                        "name": "类参考",
                        "type": "char(1)"
                    },
                    "LINE_OF": {
                        "name": "参数是 'LINE OF' 表格类型",
                        "type": "char(1)"
                    },
                    "TABLE_OF": {
                        "name": "参数为参考类型 'TABLE OF'",
                        "type": "char(1)"
                    }
                }
            },
            "CHANGING_PARAMETER": {
                "type": "array",
                "items": {
                    "PARAMETER": {
                        "name": "参数名称",
                        "type": "char(30)"
                    },
                    "DBFIELD": {
                        "name": " 参考字段/结构参数",
                        "type": "char(26)"
                    },
                    "DEFAULT": {
                        "name": "输入参数的缺省值",
                        "type": "char(21)"
                    },
                    "TYPES": {
                        "name": "参考结构为 ABAP 类型",
                        "type": "char(1)"
                    },
                    "OPTIONAL": {
                        "name": "可选参数",
                        "type": "char(1)"
                    },
                    "REFERENCE": {
                        "name": "使用引用传递调用",
                        "type": "char(1)"
                    },
                    "CHANGING": {
                        "name": "更改允许参数",
                        "type": "char(1)"
                    },
                    "TYP": {
                        "name": "接口参数的关联类型",
                        "type": "char(132)"
                    },
                    "CLASS": {
                        "name": "类参考",
                        "type": "char(1)"
                    },
                    "REF_CLASS": {
                        "name": "类参考",
                        "type": "char(1)"
                    },
                    "LINE_OF": {
                        "name": "参数是 'LINE OF' 表格类型",
                        "type": "char(1)"
                    },
                    "TABLE_OF": {
                        "name": "参数为参考类型 'TABLE OF'",
                        "type": "char(1)"
                    }
                }
            },
            "EXPORT_PARAMETER": {
                "type": "array",
                "items": {
                    "PARAMETER": {
                        "name": "参数名称",
                        "type": "char(30)"
                    },
                    "DBFIELD": {
                        "name": " 参考字段/结构参数",
                        "type": "char(26)"
                    },
                    "TYPES": {
                        "name": "参考结构为 ABAP 类型",
                        "type": "char(1)"
                    },
                    "REFERENCE": {
                        "name": "使用引用传递调用",
                        "type": "char(1)"
                    },
                    "TYP": {
                        "name": "接口参数的关联类型",
                        "type": "char(132)"
                    },
                    "CLASS": {
                        "name": "类参考",
                        "type": "char(1)"
                    },
                    "REF_CLASS": {
                        "name": "类参考",
                        "type": "char(1)"
                    },
                    "LINE_OF": {
                        "name": "参数是 'LINE OF' 表格类型",
                        "type": "char(1)"
                    },
                    "TABLE_OF": {
                        "name": "参数为参考类型 'TABLE OF'",
                        "type": "char(1)"
                    }
                }
            },
            "TABLES_PARAMETER": {
                "type": "array",
                "items": {
                    "PARAMETER": {
                        "name": "参数名称",
                        "type": "char(30)"
                    },
                    "DBSTRUCT": {
                        "name": " 参考字段/结构参数",
                        "type": "char(26)"
                    },
                    "TYPES": {
                        "name": "参考结构为 ABAP 类型",
                        "type": "char(1)"
                    },
                    "OPTIONAL": {
                        "name": "可选参数",
                        "type": "char(1)"
                    },
                    "TYP": {
                        "name": "接口参数的关联类型",
                        "type": "char(132)"
                    },
                    "CLASS": {
                        "name": "类参考",
                        "type": "char(1)"
                    },
                    "REF_CLASS": {
                        "name": "类参考",
                        "type": "char(1)"
                    },
                    "LINE_OF": {
                        "name": "参数是 'LINE OF' 表格类型",
                        "type": "char(1)"
                    },
                    "TABLE_OF": {
                        "name": "参数为参考类型 'TABLE OF'",
                        "type": "char(1)"
                    }
                }
            },
            "EXCEPTION_LIST": {
                "type": "array",
                "items": {
                    "EXCEPTION": {
                        "name": "参数名称",
                        "type": "char(30)"
                    },
                    "IS_RESUMABLE": {
                        "name": "可恢复的异常",
                        "type": "char(1)"
                    }
                }
            },
            "DOCUMENTATION": {
                "type": "array",
                "items": {
                    "PARAMETER": {
                        "name": "参数名称",
                        "type": "char(30)"
                    },
                    "KIND": {
                        "name": "类型",
                        "type": "char(1)"
                    },
                    "STEXT": {
                        "name": "短文本",
                        "type": "char(79)"
                    },
                    "INDEX": {
                        "name": "没有更多的定义范围, 可以使用插入级",
                        "type": "char(4)"
                    }
                }
            },
            "SOURCE": {
                "type": "array",
                "items": {
                    "LINE": {
                        "name": "EDIC: 程序编辑行",
                        "type": "char(72)"
                    }
                }
            }
        }
    }
}