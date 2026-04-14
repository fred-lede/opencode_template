<#
Opencode Template Setup Script (PowerShell)
#>
Param()

$root = Split-Path -Parent $MyInvocation.MyCommand.Definition
$projectRoot = Resolve-Path "$root/.." | Select-Object -ExpandProperty Path
Write-Host "[Bootstrap] Initializing new project from OpenCode template..."

$projName = Split-Path -Leaf $projectRoot
Write-Host "[Bootstrap] Project: $projName" -ForegroundColor Cyan

if (-Not (Test-Path (Join-Path $projectRoot '.git'))) {
  Set-Location $projectRoot
  git init
  git add .
  git commit -m "Bootstrap: initial project from OpenCode template"
}

Write-Host "[Bootstrap] Replacing placeholders in editable docs..." -ForegroundColor Green
$replace = {
  param([string]$Path)
  if (Test-Path $Path) {
    (Get-Content $Path) -replace '{{PROJECT_NAME}}', $projName -replace '{{DATE}}', (Get-Date -Format 'yyyy-MM-dd') | Set-Content $Path
  }
}
& $replace "$projectRoot/docs/requirements.md"
& $replace "$projectRoot/docs/architecture.md"
& $replace "$projectRoot/docs/api_spec.md"
& $replace "$projectRoot/docs/database_schema.md"
& $replace "$projectRoot/specs/feature_list.md"
& $replace "$projectRoot/TASK.md"
& $replace "$projectRoot/PROGRESS.md"
& $replace "$projectRoot/HANDOFF.md"

Write-Host "[Bootstrap] Done. You can now start your development." -ForegroundColor Green
