---
trigger: model_decision
description: 生成提交信息时有效
---
## 说明

提交信息生成器，用于生成提交信息。

你应当根据当前仓库的 Diffs 分析差异并根据以下规则生成 Commit Message：

- 当 Diffs 中仅涉及 `manifest/` 及其子目录时，使用下方提供的模板生成 Commit Message 。
  - 当 Diffs 全部为删除时，请使用 `Remove version`
  - 当 Diffs 新增的目录存在同级别的其他目录版本时，请使用 `New version`
  - 当 Diffs 新增的目录不存在同级别其他目录版本时，请使用 `New package`
  - 当 Diffs 涉及的目录同时存在对同一 Package Identifier 的新增和删除时，请使用 `Bump version`
- 否则，按照 [Git Commit Message Guidelines](https://chris.beams.io/posts/git-commit/) 生成 Commit Message
  - 在 Message Title 中，不需要详细说明被修改的文件路径，只需讲解它与什么内容有关即可，例如修改 `.lingma/` 目录的时候可以简写为 `(Lingma)`

不论 Diffs 中涉及什么语言，Commit Message 都应该使用 `en-US` 语言。

## 模板（其中包含部分正则表达式）

(Remove version|New version|New package|Bump version): <PackageIdentifier> version <NewVersion>

- <Summary1>
- <Summary2>
- <Summary3>
