传入参数：
{
    "tool_id": "GET_FUNC",
    "param": {
        "IMPORT": {
            "FUNCTIONNAME": "FUNCTION_INCLUDE_INFO"
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

返回参数：
{
    "GLOBAL_FLAG": "",
    "REMOTE_CALL": "",
    "UPDATE_TASK": "",
    "SHORT_TEXT": "",
    "FUNCTION_POOL": "",
    "REMOTE_BASXML_SUPPORTED": "",
    "IMPORT_PARAMETER": [],
    "CHANGING_PARAMETER": [
        {
            "PARAMETER": "FUNCNAME",
            "DBFIELD": "RS38L-NAME",
            "DEFAULT": "",
            "TYPES": "",
            "OPTIONAL": "X",
            "REFERENCE": "",
            "CHANGING": "",
            "TYP": "",
            "CLASS": "",
            "REF_CLASS": "",
            "LINE_OF": "",
            "TABLE_OF": ""
        },
        {
            "PARAMETER": "GROUP",
            "DBFIELD": "RS38L-AREA",
            "DEFAULT": "",
            "TYPES": "",
            "OPTIONAL": "X",
            "REFERENCE": "",
            "CHANGING": "",
            "TYP": "",
            "CLASS": "",
            "REF_CLASS": "",
            "LINE_OF": "",
            "TABLE_OF": ""
        },
        {
            "PARAMETER": "INCLUDE",
            "DBFIELD": "RS38L-INCLUDE",
            "DEFAULT": "",
            "TYPES": "",
            "OPTIONAL": "X",
            "REFERENCE": "",
            "CHANGING": "",
            "TYP": "",
            "CLASS": "",
            "REF_CLASS": "",
            "LINE_OF": "",
            "TABLE_OF": ""
        }
    ],
    "EXPORT_PARAMETER": [
        {
            "PARAMETER": "FUNCTAB",
            "DBFIELD": "",
            "TYPES": "",
            "REFERENCE": "",
            "TYP": "SUNI_FUNCTAB",
            "CLASS": "",
            "REF_CLASS": "",
            "LINE_OF": "",
            "TABLE_OF": ""
        },
        {
            "PARAMETER": "NAMESPACE",
            "DBFIELD": "RS38L-NAMESPACE",
            "TYPES": "",
            "REFERENCE": "",
            "TYP": "",
            "CLASS": "",
            "REF_CLASS": "",
            "LINE_OF": "",
            "TABLE_OF": ""
        },
        {
            "PARAMETER": "PNAME",
            "DBFIELD": "",
            "TYPES": "",
            "REFERENCE": "",
            "TYP": "TFDIR-PNAME",
            "CLASS": "",
            "REF_CLASS": "",
            "LINE_OF": "",
            "TABLE_OF": ""
        }
    ],
    "TABLES_PARAMETER": [],
    "EXCEPTION_LIST": [
        {
            "EXCEPTION": "FUNCTION_NOT_EXISTS",
            "IS_RESUMABLE": ""
        },
        {
            "EXCEPTION": "INCLUDE_NOT_EXISTS",
            "IS_RESUMABLE": ""
        },
        {
            "EXCEPTION": "GROUP_NOT_EXISTS",
            "IS_RESUMABLE": ""
        },
        {
            "EXCEPTION": "NO_SELECTIONS",
            "IS_RESUMABLE": ""
        },
        {
            "EXCEPTION": "NO_FUNCTION_INCLUDE",
            "IS_RESUMABLE": ""
        }
    ],
    "DOCUMENTATION": [
        {
            "PARAMETER": "FUNCTAB",
            "KIND": "P",
            "STEXT": "",
            "INDEX": " 001"
        },
        {
            "PARAMETER": "NAMESPACE",
            "KIND": "P",
            "STEXT": "",
            "INDEX": " 002"
        },
        {
            "PARAMETER": "PNAME",
            "KIND": "P",
            "STEXT": "",
            "INDEX": " 003"
        },
        {
            "PARAMETER": "FUNCNAME",
            "KIND": "P",
            "STEXT": "",
            "INDEX": " 004"
        },
        {
            "PARAMETER": "GROUP",
            "KIND": "P",
            "STEXT": "",
            "INDEX": " 005"
        },
        {
            "PARAMETER": "INCLUDE",
            "KIND": "P",
            "STEXT": "",
            "INDEX": " 006"
        },
        {
            "PARAMETER": "FUNCTION_NOT_EXISTS",
            "KIND": "X",
            "STEXT": "",
            "INDEX": " 007"
        },
        {
            "PARAMETER": "INCLUDE_NOT_EXISTS",
            "KIND": "X",
            "STEXT": "",
            "INDEX": " 008"
        },
        {
            "PARAMETER": "GROUP_NOT_EXISTS",
            "KIND": "X",
            "STEXT": "",
            "INDEX": " 009"
        },
        {
            "PARAMETER": "NO_SELECTIONS",
            "KIND": "X",
            "STEXT": "",
            "INDEX": " 010"
        },
        {
            "PARAMETER": "NO_FUNCTION_INCLUDE",
            "KIND": "X",
            "STEXT": "",
            "INDEX": " 011"
        }
    ],
    "SOURCE": []
}