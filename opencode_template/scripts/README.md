# Scripts - Bootstrap Utilities

This directory contains scripts for initializing and managing projects created from the OpenCode template.

## Quick Start

### Create a new project from the template

**Windows (PowerShell):**
```powershell
cd opencode_template\scripts
.\bootstrap.ps1 -Name "my_new_project"
```

**Linux/macOS (Bash):**
```bash
cd opencode_template/scripts
./bootstrap.sh --name "my_new_project"
```

## Bootstrap Scripts

| Script | Platform | Purpose |
|--------|----------|---------|
| `bootstrap.sh` | Bash/POSIX | Safe, interactive bootstrap with validation |
| `bootstrap.ps1` | PowerShell | Safe, interactive bootstrap with validation |
| `setup_template.sh` | Bash/POSIX | Basic placeholder replacement (legacy) |
| `setup_template.ps1` | PowerShell | Basic placeholder replacement (legacy) |

## Features

- **Safety first**: Confirmation prompts and validation checks before making changes
- **Dry-run mode**: Preview what will happen without modifying anything
- **Validation mode**: Check prerequisites without executing
- **Color output**: Clear visual feedback on all operations
- **Git initialization**: Automatically initializes git with an initial commit
- **Placeholder replacement**: Replaces `{{PROJECT_NAME}}` and `{{DATE}}` in editable files

## Usage Examples

### Preview what would happen (dry-run)
```bash
# Bash
./bootstrap.sh --dry-run

# PowerShell
.\bootstrap.ps1 -DryRun
```

### Validate prerequisites only
```bash
# Bash
./bootstrap.sh --validate

# PowerShell
.\bootstrap.ps1 -Validate
```

### Create project with specific name
```bash
# Bash
./bootstrap.sh --name="my_project"
./bootstrap.sh --name my_project

# PowerShell
.\bootstrap.ps1 -Name "my_project"
```

### Interactive mode (uses parent directory name)
```bash
# Bash
./bootstrap.sh

# PowerShell
.\bootstrap.ps1
```

## What happens during bootstrap

1. **Copy**: Copies the entire template directory to the target location
2. **Replace**: Substitutes placeholders in editable files:
   - `{{PROJECT_NAME}}` → your project name
   - `{{DATE}}` → current date (YYYY-MM-DD)
3. **Git init**: Initializes git repository with initial commit (if not already a git repo)
4. **Report**: Shows summary and next steps

## Editable files (will have placeholders replaced)

- `docs/requirements.md`
- `docs/architecture.md`
- `docs/api_spec.md`
- `docs/database_schema.md`
- `specs/feature_list.md`
- `TASK.md`
- `PROGRESS.md`
- `HANDOFF.md`

## System-fixed files (copied as-is)

- `.opencode/` - Agent configurations
- `scripts/` - Scripts directory
- `AGENTS.md` - Agent roles and rules
- `.editorconfig`, `.gitignore`, `.gitattributes`
- `.pre-commit-config.yaml`

## Troubleshooting

### "Target path already exists"
Run with `--validate` first to check if the target directory is available.

### Permission denied
Make sure you have write permissions to the parent directory.

### Git not found
Install Git or ensure it's in your PATH. Git initialization is optional.

## Customization

Edit these scripts to match your workflow:
- Add additional validation checks
- Include pre/post hooks for your build system
- Customize placeholder patterns
- Add more file types to replace
