# Komac Skill

You are an expert at using **Komac** (`komac.exe`), a manifest creator for the [winget-pkgs](https://github.com/microsoft/winget-pkgs) repository.

## Commands Reference

### `new` — Create a new package from scratch

```powershell
komac new [OPTIONS] [PACKAGE_IDENTIFIER]
```

| Flag / Option                | Description                                          |
| ---------------------------- | ---------------------------------------------------- |
| `-v, --version <VER>`        | Package version                                      |
| `-u, --urls <URLS>...`       | Installer URLs (space-separated)                     |
| `--package-locale`           | Package locale                                       |
| `--publisher`                | Publisher name                                       |
| `--publisher-url`            | Publisher URL                                        |
| `--publisher-support-url`    | Publisher support URL                                |
| `--package-name`             | Package name                                         |
| `--package-url`              | Package URL                                          |
| `--moniker`                  | Package moniker                                      |
| `--author`                   | Author                                               |
| `--license`                  | License identifier                                   |
| `--license-url`              | License URL                                          |
| `--copyright`                | Copyright text                                       |
| `--copyright-url`            | Copyright URL                                        |
| `--short-description`        | Short description                                    |
| `--description`              | Full description                                     |
| `--release-notes-url`        | Release notes URL                                    |
| `--concurrent-downloads <N>` | Parallel installer downloads (default: 28)           |
| `--resolves <ISSUES>...`     | Issues resolved by this submission                   |
| `-s, --submit`               | Auto-submit a pull request                           |
| `-o, --output <DIR>`         | Output directory for manifests (`OUTPUT_DIRECTORY`)  |
| `--open-pr`                  | Open the PR link automatically (`OPEN_PR`)           |
| `--dry-run`                  | Run without prompting or submitting (`DRY_RUN`)      |
| `--skip-pr-check`            | Skip existing PR check (`SKIP_PR_CHECK`)             |
| `--created-with <NAME>`      | External tool name (`KOMAC_CREATED_WITH`)            |
| `--created-with-url <URL>`   | External tool URL (`KOMAC_CREATED_WITH_URL`)         |
| `-t, --token <TOKEN>`        | GitHub PAT with `public_repo` scope (`GITHUB_TOKEN`) |

-----

### `update` — Add a version to a pre-existing package

```powershell
komac update [OPTIONS] --version <VER> --urls <URLS>... <PACKAGE_IDENTIFIER>
```

| Flag / Option                | Description                                  |
| ---------------------------- | -------------------------------------------- |
| `-v, --version <VER>`        | **Required.** New version                    |
| `-u, --urls <URLS>...`       | **Required.** Installer URLs                 |
| `-r, --replace [<VER>]`      | Version to replace                           |
| `--release-notes-url <URL>`  | Release notes URL                            |
| `--concurrent-downloads <N>` | Parallel downloads (default: 28)             |
| `--resolves <ISSUES>...`     | Issues resolved                              |
| `-s, --submit`               | Auto-submit PR                               |
| `-o, --output <DIR>`         | Output directory (`OUTPUT_DIRECTORY`)        |
| `--open-pr`                  | Open PR link (`OPEN_PR`)                     |
| `--dry-run`                  | Run without submitting (`DRY_RUN`)           |
| `--skip-pr-check`            | Skip existing PR check (`SKIP_PR_CHECK`)     |
| `--created-with <NAME>`      | External tool name (`KOMAC_CREATED_WITH`)    |
| `--created-with-url <URL>`   | External tool URL (`KOMAC_CREATED_WITH_URL`) |
| `-t, --token <TOKEN>`        | GitHub PAT (`GITHUB_TOKEN`)                  |

-----

### `remove` — Remove a version from winget-pkgs

> To remove a package entirely, all its versions must be removed.

```powershell
komac remove [OPTIONS] --version <VER> <PACKAGE_IDENTIFIER>
```

| Flag / Option            | Description                     |
| ------------------------ | ------------------------------- |
| `-v, --version <VER>`    | **Required.** Version to remove |
| `-r, --reason <REASON>`  | Deletion reason                 |
| `--resolves <ISSUES>...` | Issues resolved                 |
| `-s, --submit`           | Auto-submit PR                  |
| `--no-warning`           | Suppress removal warning        |
| `--open-pr`              | Open PR link (`OPEN_PR`)        |
| `-t, --token <TOKEN>`    | GitHub PAT (`GITHUB_TOKEN`)     |

-----

### `cleanup` — Delete merged/closed fork branches

```powershell
komac cleanup [OPTIONS]
```

| Flag / Option         | Description                              |
| --------------------- | ---------------------------------------- |
| `--only-merged`       | Only delete merged branches              |
| `--only-closed`       | Only delete closed branches              |
| `-a, --all`           | Auto-delete all relevant branches (`CI`) |
| `-t, --token <TOKEN>` | GitHub PAT (`GITHUB_TOKEN`)              |

-----

### `token` — Manage stored GitHub token

```powershell
komac token <COMMAND>
```

| Subcommand | Aliases      | Description                                      |
| ---------- | ------------ | ------------------------------------------------ |
| `update`   | `new`, `add` | Store / update token (`-t, --token <TOKEN>`)     |
| `remove`   | `delete`     | Remove stored token (`-y, --yes` to skip prompt) |

-----

### `list` — List all versions for a package

```powershell
komac list [OPTIONS] <PACKAGE_IDENTIFIER>
```

| Flag / Option         | Description                 |
| --------------------- | --------------------------- |
| `--json`              | Output as JSON              |
| `--pretty-json`       | Output as prettified JSON   |
| `--yaml`              | Output as YAML              |
| `--count`             | Output version count only   |
| `-t, --token <TOKEN>` | GitHub PAT (`GITHUB_TOKEN`) |

-----

### `show` — Display manifests for a package version

```powershell
komac show [OPTIONS] <PACKAGE_IDENTIFIER>
```

| Flag / Option                  | Description                           |
| ------------------------------ | ------------------------------------- |
| `-v, --version <VER>`          | Specific version (defaults to latest) |
| `-i, --installer-manifest`     | Show installer manifest               |
| `-d, --defaultlocale-manifest` | Show default locale manifest          |
| `-l, --locale-manifests`       | Show all locale manifests             |
| `--version-manifest`           | Show version manifest                 |
| `-t, --token <TOKEN>`          | GitHub PAT (`GITHUB_TOKEN`)           |

-----

### `sync` — Merge upstream microsoft/winget-pkgs into fork

```powershell
komac sync [OPTIONS]
```

| Flag / Option         | Description                                               |
| --------------------- | --------------------------------------------------------- |
| `-f, --force`         | Force merge even if branch has diverged (not recommended) |
| `-t, --token <TOKEN>` | GitHub PAT (`GITHUB_TOKEN`)                               |

-----

### `analyze` — Analyze an installer file

```powershell
komac analyze [OPTIONS] <FILE_PATH>
```

| Flag / Option | Description                                  |
| ------------- | -------------------------------------------- |
| `--hash`      | Hash the file and populate `InstallerSha256` |
| `--no-hash`   | Skip hashing                                 |

-----

### `submit` — Submit manifests from a local path

```powershell
komac submit [OPTIONS] <PATH>
```

| Flag / Option            | Description                                  |
| ------------------------ | -------------------------------------------- |
| `-y, --yes`              | Skip confirmation prompt (alias: `--submit`) |
| `-a, --all`              | Submit all packages in the folder            |
| `--resolves <ISSUES>...` | Issues resolved                              |
| `--open-pr`              | Open PR link (`OPEN_PR`)                     |
| `--dry-run`              | Run without submitting (`DRY_RUN`)           |
| `-t, --token <TOKEN>`    | GitHub PAT (`GITHUB_TOKEN`)                  |

-----

### `complete` — Generate shell autocompletion script

```powershell
komac complete [SHELL]
```

Supported shells: `bash`, `elvish`, `fish`, `powershell`, `zsh`.
Shell is inferred from the environment if omitted.

-----

## Common Environment Variables

| Variable                 | Used by                              |
| ------------------------ | ------------------------------------ |
| `GITHUB_TOKEN`           | All commands requiring GitHub access |
| `OUTPUT_DIRECTORY`       | `new`, `update`                      |
| `OPEN_PR`                | `new`, `update`, `remove`, `submit`  |
| `DRY_RUN`                | `new`, `update`, `submit`            |
| `SKIP_PR_CHECK`          | `new`, `update`                      |
| `KOMAC_CREATED_WITH`     | `new`, `update`                      |
| `KOMAC_CREATED_WITH_URL` | `new`, `update`                      |
| `CI`                     | `cleanup` (enables `--all`)          |

## Usage Guidelines

- Always use `--dry-run` first when testing new or update workflows.
- Prefer setting `GITHUB_TOKEN` as an environment variable over passing `-t` on the command line.
- Use `komac sync` before creating new manifests to ensure the fork is up to date.
- Use `komac cleanup` regularly to keep the fork tidy after PRs are merged or closed.
- `komac analyze` is useful for pre-checking an installer before running `new` or `update`.
