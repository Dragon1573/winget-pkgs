---
name: winget-removal
description: Use AI Agents to remove a group of WinGet Manifests in batch
---

# winget-removal

Instructions for the agent to follow when this skill is activated.

## When to use

When user ask for removing a (group of) WinGet manifests, the skill should be automatically called for performing the batch removal.

## Prerequisites

1. Make sure if `winget.exe` is installed on user's device.
2. Since this repository is huge and full of tiny YAML files, _Sparse Checkout_ feature of Git might enabled. Detect this by checking Git repository-level and global-level settings.
3. If the _Sparse Checkout_ is enabled. Make sure manifest files are available under `manifests` folder (maybe stored in recursive sub-folders) before invoking the removal script.
   - If those manifests are already available on disk, **DO NOT EDIT** sparse checkout folder list.
   - If those manifests aren't available to you, you're permitted to edit `.git/info/sparse-checkout` folder list relative to the repository root folder.
   - After any changes of the list, perform `git sparse-checkout reapply` to apply the changes.

## Instructions

1. Inspect package identifier of package name from user's prompt, as `<keyword>` here.
3. Get all available versions via `winget.exe search -s winget <keyword>`
   - If user explicitly say it's a package identifier, first try adding `--id` switch before `<keyword>` for searching.
   - For above sub-rules failed, or you get an empty response, try without adding extra switches.
   - If searched package identifier **ISN'T EXACTLY MATCH** what was been inferred by user, pause and ask for user's clarification.
4. Check which version(s) user want to remove.
   1. If he/she didn't explicitly mentioned, pause here and ask for clear instructions. **DO NOT ACT WITHOUT KNOWING EXPLICITLY VERSION RANGE!**
   2. If user provide a fuzzy natural language "version range", try map it to exact array of versions.
5. Invoke `Remove-Package.ps1` for actual removal.
   - The PowerShell script is stored at `./templates/Remove-Package.ps1`, **relative to this Markdown file**.
   - Pass `-PackageIdentifier` string for telling with package to remove.
   - Pass `-Versions` array for telling exact versions to remove.
   - Pass `-IssueId` integer to link the pull request to a known issue.
   - Pass `-Assistant` with AI agent specific attribution.

## AI agent specific attribution guidelines

> ### Attribution
>
> When AI tools contribute to the repository, proper attribution helps track the evolving role of AI in the manifest maintenance process. Contributions should include an `Assisted-by` tag in the following format:
>
> ```txt
> Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
> ```
>
> Where:
>
> - `AGENT_NAME` is the name of the AI tool or framework
> - `MODEL_VERSION` is the specific model version used
> - `[TOOL1] [TOOL2]` are optional specialized analysis tools used (e.g., `Komac`, `Sundry`, `WinGetCreate`, `YamlCreate`)
>
> Basic tools (`git`, editors) **SHOULD NOT** be listed.
