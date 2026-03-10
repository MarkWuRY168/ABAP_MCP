# ZIDT_MCP - SAP MCP 工具包

## 项目概述

ZIDT_MCP 是一个在 SAP 系统中实现 MCP (Model Context Protocol) 协议支持的开发包。通过 HTTP 服务接口，允许外部系统（如 AI 助手）动态调用 SAP 函数模块，并提供完整的工具管理、日志记录和监控功能。

---

## 系统架构

```
┌─────────────────┐     HTTP      ┌──────────────────────────────────┐
│   外部调用方     │ ───────────>  │   ICF 服务 → ZCL_SAP_MCP_HANDLER │
│  (AI助手/前端)   │               └──────────────┬───────────────────┘
└─────────────────┘                               │
                                                  v
                                         ┌─────────────────────┐
                                         │  zidt_mcp_tools     │
                                         │  (工具注册表)        │
                                         └─────────────────────┘
                                                  │
                                                  v
                                         ┌─────────────────────┐
                                         │  动态调用函数模块     │
                                         │  (FUNC)             │
                                         └─────────────────────┘
                                                  │
                                                  v
                                         ┌─────────────────────┐
                                         │  zidt_mcp_log       │
                                         │  (调用日志)          │
                                         └─────────────────────┘
```

---

## 对象清单

### 数据字典对象 (DDIC)

| 对象名称 | 类型 | 说明 |
|---------|------|------|
| `zidt_mcp_tools` | CDS Table | MCP工具注册表，存储工具配置信息 |
| `zidt_mcp_log` | CDS Table | MCP工具调用日志表 |
| `zidt_s_created_info` | CDS Structure | 创建信息结构（含创建人、时间） |
| `zidt_s_changed_info` | CDS Structure | 修改信息结构（含修改人、时间） |

### 类 (Class)

| 对象名称 | 说明 |
|---------|------|
| `ZCL_SAP_MCP_HANDLER` | HTTP请求处理类，实现 `IF_HTTP_EXTENSION` 接口，处理MCP工具调用的核心逻辑 |

### 函数模块 (Function Modules)

| 对象名称 | 说明 |
|---------|------|
| `ZIDT_FM_MCP_TOOL_LIST` | 获取可用工具列表，支持按分类过滤 |
| `ZIDT_FM_MCP_TOOL_DETAIL` | 获取指定工具的详细信息（参数定义、类型等） |
| `ZIDT_FM_MCP_TOOL_USED` | 动态执行指定的函数模块工具 |

### 程序 (Reports)

| 对象名称 | 说明 |
|---------|------|
| `ZMCP_READ_LOG` | MCP工具调用日志查看报表（ALV展示） |
| `LZIDT_MCP_TOOLF01` | 工具函数INCLUDE（JSON Schema生成、类型映射等辅助功能） |

---

## 数据表结构

### zidt_mcp_tools（工具注册表）

| 字段 | 类型 | 说明 |
|-----|------|------|
| tool_id | ZIDT_E_TOOL_ID | 工具唯一标识（主键） |
| active_flag | ZIDT_E_ACTIVE_FLAG | 激活标志 |
| tool_name | ZIDT_E_TOOL_NAME | 工具名称 |
| description | ZIDT_E_TOOL_DESCRIPTION | 工具描述 |
| version | ZIDT_E_VERSION | 版本号 |
| timeout | ZIDT_E_TIMEOUT | 超时时间 |
| recount | ZIDT_E_RECOUNT | 重试次数 |
| priority | PRIORITY | 优先级 |
| category | ZIDT_E_CATEGORY | 分类 |
| tags | ZIDT_E_TAGS | 标签 |
| sys_class | ZIDT_E_SYS_CLASS | 系统类别（如：FUNC表示函数模块） |
| sys_name | ZIDT_E_SYS_NAME | 系统对象名称（如函数名） |
| base_flag | FLAG | 基础工具标志 |
| log_flag | FLAG | 日志记录标志 |
| created_by | ZIDT_E_CREATED_BY | 创建人 |
| created_date | ZIDT_E_CREATED_DATE | 创建日期 |
| created_time | ZIDT_E_CREATED_TIME | 创建时间 |
| changed_by | ZIDT_E_CHANGED_BY | 修改人 |
| changed_time | ZIDT_E_CHANGED_TIME | 修改时间 |
| changed_date | ZIDT_E_CHANGED_DATE | 修改日期 |

### zidt_mcp_log（调用日志表）

| 字段 | 类型 | 说明 |
|-----|------|------|
| mandt | MANDT | 客户端（主键） |
| log_guid | GUID | 日志唯一标识（主键） |
| tool_id | ZIDT_E_TOOL_ID | 工具ID |
| category | ZIDT_E_CATEGORY | 分类 |
| tags | ZIDT_E_TAGS | 标签 |
| sys_class | ZIDT_E_SYS_CLASS | 系统类别 |
| sys_name | ZIDT_E_SYS_NAME | 系统对象名称 |
| uname | UNAME | 用户名 |
| request_data | ZIDT_E_REQUEST_DATA | 请求数据（JSON格式） |
| request_datum | DATUM | 请求日期 |
| request_uzeit | UZEIT | 请求时间 |
| response_data | ZIDT_E_RESPONSE_DATA | 响应数据（JSON格式） |
| response_datum | DATUM | 响应日期 |
| response_uzeit | UZEIT | 响应时间 |

---

## 核心功能说明

### 1. 工具注册与管理

在 `zidt_mcp_tools` 表中注册可被调用的函数模块：

```abap
" 示例：注册一个工具
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

### 2. HTTP 请求处理流程

`ZCL_SAP_MCP_HANDLER` 类处理 HTTP 请求的完整流程：

```
1. 接收请求 → 提取 tool_id
2. 验证请求大小（最大 1MB）
3. 查询工具配置（zidt_mcp_tools）
4. [可选] 记录请求日志
5. 动态调用函数模块
6. [可选] 更新响应日志
7. 返回 JSON 响应
```

**关键方法：**

| 方法名 | 说明 |
|-------|------|
| `IF_HTTP_EXTENSION~HANDLE_REQUEST` | HTTP请求入口处理方法 |
| `REQUEST_MCP_LOG` | 记录请求日志（生成唯一GUID） |
| `RESPONSE_MCP_LOG` | 更新响应日志 |
| `EXTRACT_TOOL_ID` | 从查询字符串中提取工具ID |
| `VALIDATE_FUNCTION_MODULE` | 验证函数模块是否存在 |
| `CALL_MCP_FUNCTION` | 动态调用函数模块 |
| `VALIDATE_REQUEST_SIZE` | 验证请求数据大小 |
| `SET_ERROR_RESPONSE` | 设置错误响应 |

### 3. 动态函数调用

`ZIDT_FM_MCP_TOOL_USED` 实现动态调用函数模块的核心逻辑：

- 支持 IMPORT、EXPORT、CHANGING、TABLES 参数
- 动态创建数据结构（使用 RTTI）
- 参数类型自动映射
- JSON 序列化/反序列化

### 4. 参数类型映射

系统支持以下 ABAP 类型到 JSON 类型的映射：

| ABAP 类型 | JSON 类型 |
|-----------|-----------|
| CHAR(n) | char(n) |
| STRING | string |
| DATS | data |
| TIMS | time |
| INT / INT1 / INT2 | integer |
| DECFLLOAT16/34 / NUM / FLOAT | number(n) |
| 内表 | array (items) |
| 结构 | object |

### 5. TABLES 参数处理（v1.1.0 修复）

**问题描述：**

在 v1.0 版本中，获取工具详情时，TABLES 参数的 JSON Schema 返回不正确：

```json
// 错误的返回（v1.0）
{
  "TABLES": {
    "IT_DATA": {
      "type": "array",
      "items": { "type": "string" }  // ❌ 默认返回 string，丢失了结构信息
    }
  }
}
```

**修复方案：**

统一使用 `lcl_mcp_json_util=>get_json_schema_for_type` 方法处理所有类型：

```abap
" v1.1.0 修复后的代码
FORM build_json_part_tab USING ...
  IF <fs_ref> IS ASSIGNED AND <fs_ref> IS NOT INITIAL.
    " 获取表类型的完整 JSON Schema（自动包装为 array）
    lv_schema = lcl_mcp_json_util=>get_json_schema_for_type( <fs_ref> ).
  ELSE.
    " 默认类型
    lv_schema = '"type": "array", "items": { "type": "string" }'.
  ENDIF.
ENDFORM.
```

**修复效果：**

```json
// 正确的返回（v1.1.0）
{
  "TABLES": {
    "IT_DATA": {
      "name": "数据表",
      "type": "array",
      "items": {
        "MANDT": { "name": "客户端", "type": "char(3)" },
        "MATNR": { "name": "物料号", "type": "char(18)" },
        "MAKTX": { "name": "物料描述", "type": "char(40)" }
      }
    }
  }
}
```

### 6. 日志查看

通过 `ZMCP_READ_LOG` 报表查看工具调用历史：

- 按工具ID、日期、时间筛选
- ALV 列表展示
- 双击查看 JSON 详情（支持格式化显示）
- 支持刷新功能

---

## API 接口说明

### 获取工具列表

**函数模块：** `ZIDT_FM_MCP_TOOL_LIST`

**请求示例：**
```json
{
  "category": "USER_MGMT"
}
```

**响应示例：**
```json
[
  {
    "tool_id": "SAP_USER_READ",
    "tool_name": "读取SAP用户信息",
    "description": "根据用户名读取SAP用户详细信息",
    "category": "USER_MGMT"
  }
]
```

### 获取工具详情

**函数模块：** `ZIDT_FM_MCP_TOOL_DETAIL`

**请求示例：**
```json
{
  "tool_id": "SAP_USER_READ",
  "param": "IMPORT"
}
```

**响应示例：**
```json
{
  "tool_id": "SAP_USER_READ",
  "param": {
    "IMPORT": {
      "IV_USERNAME": {
        "name": "用户名",
        "type": "string"
      }
    }
  }
}
```

### 执行工具

**函数模块：** `ZIDT_FM_MCP_TOOL_USED`

**请求示例：**
```json
{
  "tool_id": "SAP_USER_READ",
  "param": {
    "IMPORT": {
      "IV_USERNAME": "ADMIN"
    }
  }
}
```

---

## 配置说明

### ICF 服务配置

需要在 SICF 事务中创建 ICF 服务并绑定 `ZCL_SAP_MCP_HANDLER` 类：

1. 事务代码：SICF
2. 创建路径：`/default_host/sap/zidt_mcp`
3. 处理程序列表：添加 `ZCL_SAP_MCP_HANDLER`

### 请求大小限制

最大请求大小：1MB（可在 `GC_MAX_REQUEST_SIZE` 常量中修改）

---

## 版本更新日志

### v1.1.0 (2025-03-09)

#### 问题修复

1. **修复 TABLES 参数结构返回不正确的问题**
   - 问题：`frm_build_json_part_tab` 对 TABLES 参数默认返回 `array of string`
   - 修复：统一使用 `lcl_mcp_json_util=>get_json_schema_for_type` 处理所有类型
   - 效果：TABLES 参数现在能正确返回表结构的完整 JSON Schema

#### 代码优化

1. **引入工具类 `LCL_MCP_JSON_UTIL`**
   - 封装 JSON Schema 生成逻辑
   - 添加 DDIC 字段描述缓存机制
   - 消除 `frm_build_json_part` 和 `frm_build_json_part_tab` 的重复代码
   - 统一参数处理接口

2. **优化 `ZCL_SAP_MCP_HANDLER` 类**
   - 添加详细的方法和参数注释
   - 增加常量定义（HTTP 状态码、错误消息等）
   - 增强错误处理和日志记录
   - 改进 GUID 生成逻辑（增加重试机制）
   - 优化 `set_error_response` 方法

3. **重构 `ZIDT_FM_MCP_TOOL_USED`**
   - 添加清晰的代码分步注释
   - 将复杂逻辑拆分为独立的 FORM
   - 增加常量定义减少硬编码
   - 增强错误处理和异常捕获
   - 使用 ENUM 定义参数类型

4. **优化 `ZIDT_FM_MCP_TOOL_DETAIL`**
   - 增加错误处理逻辑
   - 统一使用工具类方法
   - 优化 JSON 组装逻辑
   - 添加详细注释

#### 性能提升

- DDIC 字段描述缓存：减少重复的数据库查询
- 代码结构优化：提高代码可维护性

---

## 后续优化建议

### 代码质量

- [x] **错误处理增强**：补充具体错误处理逻辑
- [x] **硬编码消除**：抽取 JSON Schema 生成中的重复代码为通用方法
- [ ] **类型安全**：`ZIDT_FM_MCP_TOOL_USED` 中大量使用动态类型，考虑增加类型检查
- [ ] **单元测试**：为核心类和方法添加 ABAP Unit 测试

### 性能优化

- [x] **缓存机制**：DDIC 字段描述缓存（减少数据库查询）
- [ ] **批量操作**：日志记录支持批量插入
- [ ] **异步日志**：日志记录改为异步方式
- [ ] **工具配置缓存**：工具配置信息可缓存，减少数据库查询

1. **缓存机制**：工具配置信息可缓存，减少数据库查询
2. **批量操作**：日志记录支持批量插入
3. **异步日志**：日志记录可改为异步方式

### 功能扩展

1. **更多 sys_class 支持**：目前仅支持 FUNC，可扩展支持类方法、RFC等
2. **权限控制**：增加基于用户的工具访问权限控制
3. **调用统计**：增加工具调用次数、成功率等统计功能
4. **限流机制**：防止工具被频繁调用

### 安全性

1. **输入验证**：加强对输入 JSON 的格式验证
2. **敏感数据脱敏**：日志中的敏感数据（密码、密钥）应脱敏处理
3. **API 认证**：增加 API Key 或 OAuth 认证机制

---

## 开发规范

### 命名规范

- 类：`ZCL_*`（SAP本地类）
- 函数模块：`ZIDT_FM_*`（IDT命名空间）
- 程序：`Z*`（Z开头的报表）
- 表/结构：`zidt_*`（IDT命名空间）

### 代码注释

- 关键业务逻辑需添加中文注释
- 函数/方法需添加功能说明注释

---

## 依赖关系

```
ZCL_SAP_MCP_HANDLER
  ├── IF_HTTP_EXTENSION (SAP标准接口)
  ├── /ui2/cl_json (JSON处理)
  ├── cl_uuid_factory (GUID生成)
  └── zidt_mcp_tools, zidt_mcp_log (数据表)

ZIDT_FM_MCP_TOOL_*
  ├── /ui2/cl_json (JSON处理)
  ├── cl_fb_function_utility (函数接口获取)
  ├── cl_abap_typedescr (RTTI类型描述)
  └── zidt_mcp_tools (工具注册表)

ZMCP_READ_LOG
  ├── cl_salv_table (ALV显示)
  ├── cl_abap_browser (HTML展示)
  └── zidt_mcp_log (日志表)
```

---

## 版本信息

| 版本 | 日期 | 说明 |
|-----|------|------|
| 1.0 | 2025-03-09 | 初始版本 |
| 1.1.0 | 2025-03-09 | 代码优化版本 - 修复 TABLES 参数结构问题、增强错误处理、添加缓存机制 |

---

## 联系方式

如有问题或建议，请联系开发团队。
