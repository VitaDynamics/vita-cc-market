# Vita CC Market - Claude Code 插件市场

Vita CC Market 是一个 Claude Code 插件市场，提供各种实用的插件来增强你的开发工作流。

## 可用插件

### Vengineer 插件

**Vengineer** 是一个最佳实践和实用工具插件，包含：

- **命令 (Commands)**：
  - `/core:plan` - 将功能描述转化为结构化的项目计划
  - `/core:work` - 高效执行项目计划
  - `/core:review` - 使用多代理分析进行全面的代码审查
  - `/core:deepen-plan` - 通过并行研究代理增强计划
  - `/core:plan_review` - 获取专业评审者的反馈
  - `/core:compound` - 将已解决的问题记录为分类文档

- **代理 (Agents)**：
  - 架构评审、性能优化、安全审查、模式识别等专业代理
  - 最佳实践研究、框架文档研究、Git 历史分析等研究代理

- **技能 (Skills)**：
  - 文档记录 - 将解决方案捕获为分类文档
  - 技能创建 - 创建或编辑 Claude Code 技能
  - Git Worktree - 管理 Git 工作树进行隔离式并行开发

## 安装方式

### 从阿里云安装

在 Claude Code 中运行：

```
/plugin marketplace add git@codeup.aliyun.com:vbot/VitaCore/vita-cc-market.git
```

### 从 GitHub 安装

在 Claude Code 中运行：

```
/plugin marketplace add VitaDynamics/vita-cc-market
```

其中 `owner/repo` 是 GitHub 仓库的格式。

### 安装步骤

1. 在 Claude Code 中运行添加命令：
   ```
   /plugin marketplace add owner/repo
   ```

2. 运行以下命令确认已添加：
   ```
   /plugin marketplace list
   ```

3. 使用以下命令浏览可用插件：
   ```
   /plugin browse
   ```

4. 安装插件：
   ```
   /plugin install plugin-name@marketplace-name
   ```

## 添加其他来源的 Marketplace

### Git URL

```
/plugin marketplace add https://gitlab.com/company/plugins.git
```

### 本地路径

```
/plugin marketplace add ./my-marketplace
```

## 更多信息

参考 [Discover and install prebuilt plugins](https://docs.claude.com/claude-code/installing-plugins) 页面了解详情。

## 许可证

MIT
