# =============================================================
#  setup-github.ps1
#  Crea una estructura de repositorios en GitHub desde cero
#  Autor: SrJuNi0r — https://github.com/SrJuNi0r
# =============================================================
#
#  PERSONALIZACIÓN — edita esta sección antes de ejecutar
# =============================================================

# Tu usuario de GitHub
$USERNAME = "TuUsuarioGitHub"

# Tu email de GitHub (el mismo que usas en tu cuenta)
$EMAIL = "tu@email.com"

# Repositorios a crear
# Formato: @{ name = "nombre-repo"; desc = "Descripción"; folders = @("carpeta1", "carpeta2") }
# Si el repositorio no necesita carpetas, deja folders = @()
$REPOS = @(
    @{
        name    = "sysadmin-scripts"
        desc    = "Collection of sysadmin scripts for Linux server administration, automation and maintenance."
        folders = @("backups", "monitoring", "users", "networking", "maintenance", "misc")
    },
    @{
        name    = "docker-setups"
        desc    = "Docker Compose configurations for self-hosted services and homelab deployments."
        folders = @()
    },
    @{
        name    = "homelab-docs"
        desc    = "Documentation of my homelab setup — servers, services, network diagrams and configurations."
        folders = @("servers", "network", "services", "guides")
    },
    @{
        name    = "mi-otro-repo"
        desc    = "Descripción de ejemplo para otro repositorio."
        folders = @("carpeta-ejemplo-1", "carpeta-ejemplo-2")
    }
)

# =============================================================
#  A partir de aquí no hace falta tocar nada
# =============================================================

$TempDir = "$env:TEMP\github-setup"

function CreateRepo {
    param(
        [string]$Name,
        [string]$Desc,
        [string[]]$Folders
    )

    Write-Host "`n-> Creando $Name..." -ForegroundColor Cyan

    git config --global user.email $EMAIL
    git config --global user.name $USERNAME

    $existing = gh repo view "$USERNAME/$Name" 2>$null
    if ($existing) {
        Write-Host "   El repositorio ya existe, omitiendo creacion..." -ForegroundColor Yellow
    } else {
        gh repo create $Name --public --description $Desc --add-readme
    }

    $RepoPath = "$TempDir\$Name"
    if (Test-Path $RepoPath) {
        Remove-Item -Recurse -Force $RepoPath
    }

    git clone "https://github.com/$USERNAME/$Name.git" $RepoPath
    Set-Location $RepoPath

    if ($Folders.Count -gt 0) {
        foreach ($folder in $Folders) {
            New-Item -ItemType Directory -Path $folder -Force | Out-Null
            New-Item -ItemType File -Path "$folder\.gitkeep" -Force | Out-Null
        }
        git add .
        $status = git status --porcelain
        if ($status) {
            git commit -m "chore: initial folder structure"
            git push
        } else {
            Write-Host "   Sin cambios que subir." -ForegroundColor Yellow
        }
    }

    Set-Location $TempDir
    Write-Host "OK $Name listo" -ForegroundColor Green
}

New-Item -ItemType Directory -Path $TempDir -Force | Out-Null
Set-Location $TempDir

foreach ($repo in $REPOS) {
    CreateRepo $repo.name $repo.desc $repo.folders
}

Set-Location $env:USERPROFILE
Remove-Item -Recurse -Force $TempDir

Write-Host "`nTodos los repositorios creados correctamente." -ForegroundColor Green
Write-Host "Visita https://github.com/$USERNAME para verlos." -ForegroundColor Cyan
