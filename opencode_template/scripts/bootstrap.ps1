# =============================================================================
# OpenCode Template - Enhanced Bootstrap (PowerShell)
# =============================================================================
# Features:
# - Copy template to target directory with safety checks
# - Optional --dry-run and --validate modes
# - Placeholder replacement ({{PROJECT_NAME}}, {{DATE}})
# - Git initialization
# =============================================================================
# Usage:
#   .\bootstrap.ps1                          # interactive (uses parent dir name)
#   .\bootstrap.ps1 -Name "my_project"        # use specified name
#   .\bootstrap.ps1 -DryRun                   # preview only
#   .\bootstrap.ps1 -Validate                # check prerequisites only
# =============================================================================

Param(
  [string]$Name = $null,
  [switch]$DryRun,
  [switch]$Validate
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$TemplateRoot = (Get-Item $ScriptDir).Parent.FullName
$ParentDir = Split-Path -Parent $TemplateRoot

if (-not (Test-Path $TemplateRoot)) {
  Write-Host "[Error] Template root not found: $TemplateRoot" -ForegroundColor Red
  exit 1
}

# Use script filename's parent dir name as default project name
if ([string]::IsNullOrEmpty($Name)) {
  $Name = Split-Path -Leaf $ParentDir
}

# Sanitize name (remove invalid chars for Windows paths)
$Name = $Name -replace '[\\/:*?"<>|]', '_'

$TargetPath = Join-Path $ParentDir $Name

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " OpenCode Template Bootstrap (PowerShell)" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "[Info] Template : $TemplateRoot" -ForegroundColor Gray
Write-Host "[Info] Target   : $TargetPath" -ForegroundColor Gray
Write-Host ""

# Validation mode
if ($Validate) {
  Write-Host "[Validate] Running prerequisite checks..." -ForegroundColor Yellow
  $errors = 0

  if (Test-Path $TargetPath) {
    Write-Host "[X] Target path already exists: $TargetPath" -ForegroundColor Red
    $errors++
  } else {
    Write-Host "[OK] Target path is available" -ForegroundColor Green
  }

  $requiredFiles = @(
    "docs\requirements.md",
    "docs\architecture.md",
    "docs\api_spec.md",
    "docs\database_schema.md",
    "specs\feature_list.md",
    "TASK.md",
    "PROGRESS.md",
    "HANDOFF.md"
  )
  $missing = 0
  foreach ($f in $requiredFiles) {
    $fullPath = Join-Path $TemplateRoot $f
    if (-not (Test-Path $fullPath)) {
      Write-Host "[!] Missing required file: $f" -ForegroundColor Yellow
      $missing++
    }
  }
  if ($missing -eq 0) {
    Write-Host "[OK] All required template files present" -ForegroundColor Green
  } else {
    Write-Host "[!] $missing required files missing" -ForegroundColor Yellow
  }

  if ($errors -eq 0) {
    Write-Host ""
    Write-Host "[Validate] All checks passed. Safe to proceed." -ForegroundColor Green
  } else {
    Write-Host ""
    Write-Host "[Validate] Found $errors error(s). Please resolve before proceeding." -ForegroundColor Red
  }
  exit $errors
}

# Dry-run mode
if ($DryRun.IsPresent) {
  Write-Host "[Dry-Run] No changes will be made." -ForegroundColor Yellow
  Write-Host ""
  Write-Host "[Dry-Run] Would perform:" -ForegroundColor Yellow
  Write-Host "  1. Copy '$TemplateRoot' to '$TargetPath'" -ForegroundColor White
  Write-Host "  2. Replace {{PROJECT_NAME}} -> '$Name'" -ForegroundColor White
  Write-Host "  3. Replace {{DATE}} -> '$(Get-Date -Format 'yyyy-MM-dd')'" -ForegroundColor White
  Write-Host "  4. Initialize git (if not exists)" -ForegroundColor White
  Write-Host ""
  Write-Host "To execute, run without --DryRun" -ForegroundColor Cyan
  exit 0
}

# Confirmation prompt
Write-Host "This will create a new project at:" -ForegroundColor Yellow
Write-Host "  $TargetPath" -ForegroundColor White
Write-Host ""
$confirmation = Read-Host "Proceed? (y/N)"
if ($confirmation -ne 'y' -and $confirmation -ne 'Y') {
  Write-Host "[Abort] Bootstrap cancelled." -ForegroundColor Red
  exit 0
}

# Full execution
Write-Host ""
Write-Host "[Step 1/4] Copying template..." -ForegroundColor Cyan
try {
  Copy-Item -Recurse -Force $TemplateRoot $TargetPath -ErrorAction Stop
  Write-Host "[OK] Template copied" -ForegroundColor Green
} catch {
  Write-Host "[Error] Failed to copy: $_" -ForegroundColor Red
  exit 1
}

Write-Host "[Step 2/4] Replacing placeholders..." -ForegroundColor Cyan
$DateStr = Get-Date -Format 'yyyy-MM-dd'
$files = @(
  "docs\requirements.md",
  "docs\architecture.md",
  "docs\api_spec.md",
  "docs\database_schema.md",
  "specs\feature_list.md",
  "TASK.md",
  "PROGRESS.md",
  "HANDOFF.md"
)
$replaced = 0
foreach ($f in $files) {
  $fullPath = Join-Path $TargetPath $f
  if (Test-Path $fullPath) {
    $content = Get-Content $fullPath -Raw -Encoding UTF8
    $newContent = $content -replace '{{PROJECT_NAME}}', $Name -replace '{{DATE}}', $DateStr
    Set-Content -Path $fullPath -Value $newContent -Encoding UTF8 -NoNewline
    $replaced++
  }
}
Write-Host "[OK] Replaced placeholders in $replaced file(s)" -ForegroundColor Green

Write-Host "[Step 3/4] Initializing git..." -ForegroundColor Cyan
$GitDir = Join-Path $TargetPath '.git'
if (-not (Test-Path $GitDir)) {
  Set-Location $TargetPath
  git init -q
  git add .
  git commit -m "Bootstrap: initial project from OpenCode template" -q
  Write-Host "[OK] Git initialized with initial commit" -ForegroundColor Green
} else {
  Write-Host "[Skip] Git already initialized" -ForegroundColor Gray
}

Write-Host "[Step 4/4] Finalizing..." -ForegroundColor Cyan
Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host " Bootstrap Complete!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "New project created at:" -ForegroundColor Cyan
Write-Host "  $TargetPath" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. cd $Name" -ForegroundColor White
Write-Host "  2. Edit docs\requirements.md to define your project" -ForegroundColor White
Write-Host "  3. Edit docs\architecture.md for system design" -ForegroundColor White
Write-Host "  4. Run 'opencode' to start development" -ForegroundColor White
Write-Host ""
