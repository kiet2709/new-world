<#
  Cua vao duy nhat cho moi tac vu moi truong.
  Triet ly: CLI la xuong song, VS Code chi la mat tien (muc 4 cua la ban).

    .\dev.ps1 up            bat moi truong (py + cpp)
    .\dev.ps1 up ot         bat them mqtt + db + grafana
    .\dev.ps1 py            vao shell container Python
    .\dev.ps1 cpp           vao shell container C++
    .\dev.ps1 build         build lai image sau khi sua Dockerfile/requirements
    .\dev.ps1 down          tat (giu volume)
    .\dev.ps1 nuke          tat + xoa volume (lam lai tu dau)
    .\dev.ps1 ps            xem trang thai
#>
param(
  [Parameter(Position = 0)][string]$Cmd = "help",
  [Parameter(Position = 1)][string]$Arg = ""
)

# KHONG dat $ErrorActionPreference = "Stop": trong PowerShell 5.1, lenh native
# (docker) ghi tien trinh ra stderr, se bi hieu nham thanh loi va lam script chet.
# Kiem loi bang $LASTEXITCODE moi dung.

Set-Location $PSScriptRoot

function Test-DockerUp {
  docker info 1>$null 2>$null
  return ($LASTEXITCODE -eq 0)
}

function Assert-Docker {
  if (-not (Test-DockerUp)) {
    Write-Host ""
    Write-Host "  Docker engine chua chay." -ForegroundColor Yellow
    Write-Host "  Mo Docker Desktop, doi bieu tuong ca voi chuyen xanh, roi chay lai." -ForegroundColor Yellow
    Write-Host ""
    exit 1
  }
}

function Show-Help {
  Write-Host ""
  Write-Host "  dev.ps1 - cua vao moi truong hoc" -ForegroundColor Cyan
  Write-Host ""
  $rows = @(
    @("up",      "bat moi truong (py + cpp)"),
    @("up ot",   "bat them mqtt + db + grafana (tu Chang 2)"),
    @("py",      "vao shell container Python"),
    @("cpp",     "vao shell container C++"),
    @("build",   "build lai image sau khi sua Dockerfile/requirements"),
    @("down",    "tat, giu nguyen du lieu"),
    @("nuke",    "tat + xoa volume, lam lai tu dau"),
    @("ps",      "xem trang thai container")
  )
  foreach ($r in $rows) {
    Write-Host ("    .\dev.ps1 {0,-8} {1}" -f $r[0], $r[1])
  }
  Write-Host ""
}

switch ($Cmd) {
  "up" {
    Assert-Docker
    if ($Arg -eq "ot") { docker compose --profile ot up -d }
    else { docker compose up -d }
  }
  "py"    { Assert-Docker; docker compose exec py bash }
  "cpp"   { Assert-Docker; docker compose exec cpp bash }
  "build" { Assert-Docker; docker compose build }
  "down"  { Assert-Docker; docker compose --profile ot down }
  "nuke"  { Assert-Docker; docker compose --profile ot down -v }
  "ps"    { Assert-Docker; docker compose ps -a }
  default { Show-Help }
}
