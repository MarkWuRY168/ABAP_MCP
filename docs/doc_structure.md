# ZIDT_MCP - ADT 目录结构

本项目按照 ADT (ABAP Development Tools) 风格组织代码。

## 目录结构

```
ZIDT_MCP/
├── docs/                           # 文档目录
│   ├── README.md                   # 项目简介
│   ├── TECHNICAL.md                # 技术详细说明
│   ├── doc_structure.md            # 目录结构说明
│   └── tests/                      # 测试文档
│       ├── z_read_class_code.abap  # 测试用 ABAP 代码
│       └── TS/                     # 测试脚本和结果
│           ├── test_tool_detail.md
│           └── test_use_tool.md
│
└── src/                            # 源代码目录
    └── packages/
        └── ZIDT_MCP/               # 包名: ZIDT_MCP
            └── devel/              # 开发对象
                ├── classes/        # 类
                │   ├── zcl_sap_mcp_handler.clas.abap
                │   └── zcl_sap_mcp_handler.clas.testclasses.abap
                │
                ├── data_elements/  # 数据元素
                │   ├── zidt_e_active_flag.dtel.xml
                │   ├── zidt_e_category.dtel.xml
                │   ├── zidt_e_changed_by.dtel.xml
                │   ├── zidt_e_changed_date.dtel.xml
                │   ├── zidt_e_changed_time.dtel.xml
                │   ├── zidt_e_created_by.dtel.xml
                │   ├── zidt_e_created_date.dtel.xml
                │   ├── zidt_e_created_time.dtel.xml
                │   ├── zidt_e_request_data.dtel.xml
                │   ├── zidt_e_response_data.dtel.xml
                │   ├── zidt_e_recount.dtel.xml
                │   ├── zidt_e_sys_class.dtel.xml
                │   ├── zidt_e_sys_name.dtel.xml
                │   ├── zidt_e_tags.dtel.xml
                │   ├── zidt_e_timeout.dtel.xml
                │   ├── zidt_e_tool_description.dtel.xml
                │   ├── zidt_e_tool_id.dtel.xml
                │   ├── zidt_e_tool_name.dtel.xml
                │   └── zidt_e_version.dtel.xml
                │
                ├── function_groups/ # 函数组
                │   └── zidt_mcp_tool/
                │       ├── functions/      # 函数模块
                │       │   ├── zidt_fm_mcp_tool_detail.func.abap
                │       │   ├── zidt_fm_mcp_tool_list.func.abap
                │       │   └── zidt_fm_mcp_tool_used.func.abap
                │       └── lzidt_mcp_toolf01.prog.abap  # 函数组INCLUDE
                │
                ├── icf_services/   # ICF服务
                │   └── zidt_mcp.icf.xml
                │
                ├── programs/       # 程序
                │   └── zmcp_read_log.prog.abap
                │
                ├── structures/     # 结构
                │   ├── zidt_s_changed_info.struct.xml
                │   └── zidt_s_created_info.struct.xml
                │
                └── tables/         # 数据表
                    ├── zidt_mcp_log.tabl.xml
                    └── zidt_mcp_tools.tabl.xml
```

## 对象清单

### 类 (Classes)
| 对象名 | 文件 | 说明 |
|--------|------|------|
| ZCL_SAP_MCP_HANDLER | `zcl_sap_mcp_handler.clas.abap` | HTTP请求处理类 |

### 函数模块 (Function Modules)
| 对象名 | 文件 | 说明 |
|--------|------|------|
| ZIDT_FM_MCP_TOOL_LIST | `zidt_fm_mcp_tool_list.func.abap` | 获取工具列表 |
| ZIDT_FM_MCP_TOOL_DETAIL | `zidt_fm_mcp_tool_detail.func.abap` | 获取工具详情 |
| ZIDT_FM_MCP_TOOL_USED | `zidt_fm_mcp_tool_used.func.abap` | 执行工具 |

### 程序 (Programs)
| 对象名 | 文件 | 说明 |
|--------|------|------|
| ZMCP_READ_LOG | `zmcp_read_log.prog.abap` | 日志查看报表 |

### 数据表 (Tables)
| 对象名 | 文件 | 说明 |
|--------|------|------|
| ZIDT_MCP_TOOLS | `zidt_mcp_tools.tabl.xml` | 工具注册表 |
| ZIDT_MCP_LOG | `zidt_mcp_log.tabl.xml` | 调用日志表 |

### 结构 (Structures)
| 对象名 | 文件 | 说明 |
|--------|------|------|
| ZIDT_S_CREATED_INFO | `zidt_s_created_info.struct.xml` | 创建信息 |
| ZIDT_S_CHANGED_INFO | `zidt_s_changed_info.struct.xml` | 修改信息 |

### 数据元素 (Data Elements)
| 对象名 | 文件 | 说明 |
|--------|------|------|
| ZIDT_E_ACTIVE_FLAG | `zidt_e_active_flag.dtel.xml` | 激活标志 |
| ZIDT_E_CATEGORY | `zidt_e_category.dtel.xml` | 分类 |
| ZIDT_E_CHANGED_BY | `zidt_e_changed_by.dtel.xml` | 修改人 |
| ZIDT_E_CHANGED_DATE | `zidt_e_changed_date.dtel.xml` | 修改日期 |
| ZIDT_E_CHANGED_TIME | `zidt_e_changed_time.dtel.xml` | 修改时间 |
| ZIDT_E_CREATED_BY | `zidt_e_created_by.dtel.xml` | 创建人 |
| ZIDT_E_CREATED_DATE | `zidt_e_created_date.dtel.xml` | 创建日期 |
| ZIDT_E_CREATED_TIME | `zidt_e_created_time.dtel.xml` | 创建时间 |
| ZIDT_E_REQUEST_DATA | `zidt_e_request_data.dtel.xml` | 请求数据 |
| ZIDT_E_RESPONSE_DATA | `zidt_e_response_data.dtel.xml` | 响应数据 |
| ZIDT_E_RECOUNT | `zidt_e_recount.dtel.xml` | 重试次数 |
| ZIDT_E_SYS_CLASS | `zidt_e_sys_class.dtel.xml` | 系统类别 |
| ZIDT_E_SYS_NAME | `zidt_e_sys_name.dtel.xml` | 系统对象名 |
| ZIDT_E_TAGS | `zidt_e_tags.dtel.xml` | 标签 |
| ZIDT_E_TIMEOUT | `zidt_e_timeout.dtel.xml` | 超时时间 |
| ZIDT_E_TOOL_DESCRIPTION | `zidt_e_tool_description.dtel.xml` | 工具描述 |
| ZIDT_E_TOOL_ID | `zidt_e_tool_id.dtel.xml` | 工具ID |
| ZIDT_E_TOOL_NAME | `zidt_e_tool_name.dtel.xml` | 工具名称 |
| ZIDT_E_VERSION | `zidt_e_version.dtel.xml` | 版本号 |

### ICF服务
| 路径 | 文件 | 说明 |
|------|------|------|
| /default_host/sap/zidt_mcp | `zidt_mcp.icf.xml` | MCP工具HTTP服务 |

## ADT命名约定

- 类文件: `<classname>.clas.abap`
- 类测试文件: `<classname>.clas.testclasses.abap`
- 函数模块: `<fmname>.func.abap`
- 程序: `<progname>.prog.abap`
- 表: `<tablename>.tabl.xml`
- 结构: `<structname>.struct.xml`
- 数据元素: `<dtelname>.dtel.xml`
- 域: `<domname>.doma.xml`
