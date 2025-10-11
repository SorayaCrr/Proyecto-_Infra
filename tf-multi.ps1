
# tf-multi.ps1 — Recorre subcarpetas con .tf y ejecuta fmt/validate/plan/apply
param(
  [switch]$Apply,          # agrega -Apply para aplicar automáticamente
  [string]$Workspace = "dev", # cambia a dev/qa/prod
  [string]$VarFile = ""       # opcional: ruta a .tfvars (ej.: ".\env\dev.tfvars")
)

$ErrorActionPreference = "Stop"

function Find-TfDirs {
  Get-ChildItem -Path . -Recurse -Directory | Where-Object {
    Test-Path (Join-Path $_.FullName "*.tf")
  } | ForEach-Object { $_.FullName }
}

$dirs = Find-TfDirs

Write-Host "Carpetas Terraform detectadas:" -ForegroundColor Cyan
$dirs | ForEach-Object { Write-Host " - $_" }

foreach ($d in $dirs) {
  Write-Host "`n=== $d ===" -ForegroundColor Yellow
  Push-Location $d

  # Solo ejecuta en "roots": donde exista main.tf o algún archivo con provider/resource (ajústalo a tu standard)
  $isRoot = Test-Path "./main.tf"
  if (-not $isRoot) { Pop-Location; continue }

  terraform fmt -recursive -check | Out-Null
  terraform init -input=false

  # Workspace
  $wsExists = terraform workspace list | Select-String -SimpleMatch " $Workspace"
  if (-not $wsExists) { terraform workspace new $Workspace | Out-Null }
  terraform workspace select $Workspace | Out-Null

  # Validate
  if ($VarFile -and (Test-Path $VarFile)) {
    terraform validate
    terraform plan -var-file="$VarFile" -out=".tfplan"
  } else {
    terraform validate
    terraform plan -out=".tfplan"
  }

  if ($Apply.IsPresent) {
    terraform apply -auto-approve ".tfplan"
  }

  Pop-Location
}
