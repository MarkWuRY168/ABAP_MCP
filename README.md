# ZIDT_MCP

<div align="center">

![SAP](https://img.shields.io/badge/SAP-007ACC?style=flat&logo=sap&logoColor=white)
![ABAP](https://img.shields.io/badge/ABAP-005F7F?style=flat&logoColor=white)
![Version](https://img.shields.io/badge/Version-1.1.0-green)
![License](https://img.shields.io/badge/License-MIT-blue)

**SAP MCP (Model Context Protocol) 开发包 - 让 AI 助手轻松调用 SAP_MCP **

[技术文档](./docs/TECHNICAL.md) · [目录结构](./docs/doc_structure.md) · [问题反馈](https://github.com/MarkWuRY168/ABAP_MCP/issues)

</div>

---

## ✨ 特性

- 🔌 **MCP 协议支持** - 完整实现 Model Context Protocol，让 AI 助手能调用 SAP_MCP
- 🔄 **动态函数调用** - 无需开发新接口，动态调用已注册的工具
- 📋 **工具注册管理** - 通过数据表灵活管理可调用工具
- 📝 **完整日志记录** - 记录所有调用请求和响应，便于审计和问题排查
- 🔍 **JSON Schema 生成** - 自动生成参数定义，AI 助手可理解接口结构

---

## 🏗️ 系统架构

```
┌─────────────┐     HTTP      ┌────────────────────────────┐
│  AI 助手     │ ──────────>  │  SAP ICF Service          │
│ (Claude 等)  │               │  ZCL_SAP_MCP_HANDLER      │
└─────────────┘               └────────────┬───────────────┘
                                           │
                   ┌───────────────────────┼───────────────────────┐
                   │                       │                       │
                   v                       v                       v
           ┌───────────────┐       ┌───────────────┐       ┌───────────────┐
           │ zidt_mcp_tools│       │ Function Call │       │ zidt_mcp_log  │
           │ (工具注册表)   │       │ (动态执行)     │       │ (调用日志)     │
           └───────────────┘       └───────────────┘       └───────────────┘
```

---

## 🚀 快速开始

### 1. 安装部署

在 SAP 系统中导入以下对象：

| 对象类型 | 对象名称 |
|---------|---------|
| 表 | `ZIDT_MCP_TOOLS` |
| 表 | `ZIDT_MCP_LOG` |
| 类 | `ZCL_SAP_MCP_HANDLER` |
| 函数模块 | `ZIDT_FM_MCP_TOOL_LIST` |
| 函数模块 | `ZIDT_FM_MCP_TOOL_DETAIL` |
| 函数模块 | `ZIDT_FM_MCP_TOOL_USED` |

### 2. 配置 ICF 服务

在事务码 **SICF** 中创建服务：

- 路径：`/default_host/sap/zidt_mcp`
- 处理程序：`ZCL_SAP_MCP_HANDLER`

### 3. 注册工具

```abap
INSERT zidt_mcp_tools FROM VALUE #(
  tool_id     = 'SAP_USER_READ'
  active_flag = abap_true
  tool_name   = '读取SAP用户信息'
  description = '根据用户名读取SAP用户详细信息'
  sys_class   = 'FUNC'
  sys_name    = 'Z_USER_READ_DETAIL'
  log_flag    = abap_true
).
```

### 4. 调用接口

```bash
# 获取工具列表
curl "http://<sap_host>/sap/zidt_mcp?tool_id=list"

# 获取工具详情
curl "http://<sap_host>/sap/zidt_mcp?tool_id=SAP_USER_READ"

# 执行工具
curl -X POST "http://<sap_host>/sap/zidt_mcp" \
  -d '{"tool_id": "SAP_USER_READ", "param": {"IMPORT": {"IV_USERNAME": "ADMIN"}}}'
```

---

## 📖 使用场景

### 🤖 AI 助手集成

ZIDT_MCP 让 Claude、GPT 等 AI 助手能够：

- 📖 **读取 SAP 数据** - 查询用户、物料、订单等信息
- ✏️ **执行 SAP 操作** - 创建工单、修改数据等
- 🔍 **获取系统信息** - 查询配置、权限等信息

### 📊 监控与审计

- 查看工具调用历史
- 分析调用成功率
- 追踪问题订单

---

## 📦 项目结构

```
ZIDT_MCP/
├── docs/                           # 文档目录
│   ├── README.md                   # 项目简介
│   ├── TECHNICAL.md                # 技术详细说明
│   ├── doc_structure.md            # 目录结构说明
│   └── tests/                      # 测试文档
│       ├── z_read_class_code.abap  # 测试用 ABAP 代码
│       └── TS/                     # 测试脚本
│
└── src/                            # 源代码目录
    └── packages/
        └── ZIDT_MCP/               # 包名: ZIDT_MCP
            └── devel/              # 开发对象
                ├── classes/        # 类
                ├── data_elements/  # 数据元素
                ├── function_groups/ # 函数组
                ├── icf_services/   # ICF服务
                ├── programs/       # 程序
                ├── structures/     # 结构
                └── tables/         # 数据表
```

详细目录结构请查看 [doc_structure.md](./docs/doc_structure.md)

---

## 🔧 版本历史

| 版本 | 日期 | 说明 |
|-----|------|------|
| v1.1.0 | 2025-03-09 | 修复 TABLES 参数问题、增强错误处理、添加缓存 |
| v1.0.0 | 2025-03-09 | 初始版本 |

详细更新日志请查看 [TECHNICAL.md](./docs/TECHNICAL.md)

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

---

## 📄 许可证

MIT License - 自由使用、修改和分发

---

## 📧 联系方式

如有问题或建议，请提交 [Issue](https://github.com/MarkWuRY168/ABAP_MCP/issues) 或联系开发团队。
