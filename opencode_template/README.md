# OpenCode Personal Template

A self-contained, copyable development environment template for starting new OpenCode projects quickly.

## Quick Start

### Option 1: Use Bootstrap Script (Recommended)

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

The bootstrap script will:
1. Copy the template to your new project directory
2. Replace placeholders (`{{PROJECT_NAME}}`, `{{DATE}}`) in editable files
3. Initialize git with an initial commit
4. Show you next steps

### Option 2: Manual Copy

1. Copy this directory and rename it to your project name
2. Run bootstrap to replace placeholders:
   - Bash: `./scripts/setup_template.sh`
   - PowerShell: `.\scripts\setup_template.ps1`
3. Edit the docs/ files to define your project

## Features

- **Cross-platform**: Works on Windows, Linux, and macOS
- **Safety first**: Dry-run and validation modes available
- **Git integration**: Automatic initialization with initial commit
- **Placeholder replacement**: Automatic substitution of project name and date
- **Clear separation**: System-fixed vs editable content clearly separated

## Directory Structure

```
opencode_template/
├── .opencode/           # System-fixed: Agent configurations
│   ├── config.yaml      # Template configuration
│   ├── agents.yaml      # Agent role definitions
│   └── prompts/          # System prompts
├── docs/                # EDITABLE: Project specifications
│   ├── requirements.md  # Functional & non-functional requirements
│   ├── architecture.md  # System architecture
│   ├── api_spec.md      # API specifications
│   └── database_schema.md # Database schema
├── specs/               # EDITABLE: Feature specifications
│   ├── feature_list.md  # Feature overview
│   └── features/        # Individual feature specs
│       └── feature_name.md
├── scripts/             # Bootstrap utilities
│   ├── bootstrap.sh      # Bash bootstrap (POSIX)
│   ├── bootstrap.ps1     # PowerShell bootstrap (Windows)
│   ├── setup_template.sh  # Legacy bash bootstrap
│   └── setup_template.ps1 # Legacy PowerShell bootstrap
├── AGENTS.md            # Agent roles and rules
├── TASK.md              # Task tracker (per-project)
├── PROGRESS.md          # Progress log (per-project)
└── HANDOFF.md           # Session handoff (per-project)
```

## Content Separation

### System-Fixed (Copy As-Is)
- `.opencode/` - Agent configurations
- `scripts/` - Bootstrap utilities
- `AGENTS.md` - Agent operational rules
- `.editorconfig`, `.gitignore`, `.gitattributes`
- `.pre-commit-config.yaml`

### Editable (Per-Project)
- `docs/` - Requirements, architecture, API specs, database schema
- `specs/` - Feature list and individual feature specifications
- `TASK.md` - Active task tracker
- `PROGRESS.md` - Historical progress log
- `HANDOFF.md` - Session handoff notes

## Bootstrap Script Usage

### Dry-Run (Preview Only)
```bash
./bootstrap.sh --dry-run
.\bootstrap.ps1 -DryRun
```

### Validate Prerequisites
```bash
./bootstrap.sh --validate
.\bootstrap.ps1 -Validate
```

### Interactive Mode
```bash
./bootstrap.sh
.\bootstrap.ps1
```

## Next Steps After Bootstrap

1. Edit `docs/requirements.md` - Define what your project should do
2. Edit `docs/architecture.md` - Design your system architecture
3. Edit `specs/feature_list.md` - List features to implement
4. Run `opencode` - Start developing with AI assistance

## Documentation

- [scripts/README.md](scripts/README.md) - Detailed bootstrap script documentation
- [TASK.md](TASK.md) - Task tracking guidelines
- [PROGRESS.md](PROGRESS.md) - Progress logging guidelines
- [HANDOFF.md](HANDOFF.md) - Session handoff guidelines

## Requirements

- Git (optional, for git initialization)
- Bash 4.0+ (for Bash bootstrap)
- PowerShell 5.0+ (for PowerShell bootstrap)
