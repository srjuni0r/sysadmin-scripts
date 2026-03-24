# ⚙️ setup-github.ps1

Script de PowerShell que crea automáticamente repositorios en GitHub con sus carpetas iniciales y descripciones. Solo tienes que editar una sección al inicio del script y ejecutarlo.

---

## 📋 Requisitos previos

Antes de ejecutar el script necesitas tener instalado y configurado lo siguiente. Sigue los pasos en orden.

### 1. Git

Comprueba si ya lo tienes:
```powershell
git --version
```
Si no está instalado:
```powershell
winget install Git.Git
```

### 2. GitHub CLI

Comprueba si ya lo tienes:
```powershell
gh --version
```
Si no está instalado:
```powershell
winget install GitHub.cli
```
> Después de instalar, cierra PowerShell y ábrelo de nuevo.

### 3. Iniciar sesión en GitHub

```powershell
gh auth login
```
Selecciona:
- **GitHub.com**
- **HTTPS**
- **Yes** (autenticar Git con tus credenciales)
- **Login with a web browser**

Se mostrará un código en la terminal. Cópialo, pulsa Enter, pégalo en el navegador y autoriza.

---

## ✏️ Personalización

Abre `setup-github.ps1` y edita únicamente la sección marcada al inicio:

```powershell
# Tu usuario de GitHub
$USERNAME = "TuUsuarioGitHub"

# Tu email de GitHub
$EMAIL = "tu@email.com"

# Repositorios a crear
$REPOS = @(
    @{
        name    = "mi-repositorio"
        desc    = "Descripción del repositorio."
        folders = @("carpeta1", "carpeta2")
    },
    @{
        name    = "otro-repositorio"
        desc    = "Otro repositorio sin carpetas."
        folders = @()
    }
)
```

- **name**: nombre del repositorio (sin espacios, usa guiones)
- **desc**: descripción que aparece en GitHub
- **folders**: carpetas a crear dentro del repositorio. Deja `@()` si no quieres ninguna

---

## 🚀 Ejecución

Abre PowerShell, navega hasta donde tienes el script y ejecuta:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\setup-github.ps1
```

---

## ℹ️ Notas

- Los repositorios se crean como **públicos**
- Si un repositorio ya existe en tu cuenta, el script lo omite y continúa con las carpetas
- Las carpetas se crean con un archivo `.gitkeep` para que Git las detecte
- El script no modifica ni borra nada que ya exista

---

<!-- EN -->
# ⚙️ setup-github.ps1

PowerShell script that automatically creates GitHub repositories with their initial folder structure and descriptions. Just edit one section at the top of the script and run it.

---

## 📋 Prerequisites

Before running the script you need the following installed and configured. Follow the steps in order.

### 1. Git

Check if already installed:
```powershell
git --version
```
If not installed:
```powershell
winget install Git.Git
```

### 2. GitHub CLI

Check if already installed:
```powershell
gh --version
```
If not installed:
```powershell
winget install GitHub.cli
```
> After installing, close PowerShell and reopen it.

### 3. Log into GitHub

```powershell
gh auth login
```
Select:
- **GitHub.com**
- **HTTPS**
- **Yes** (authenticate Git with your credentials)
- **Login with a web browser**

A code will appear in the terminal. Copy it, press Enter, paste it in the browser and authorise.

---

## ✏️ Customisation

Open `setup-github.ps1` and edit only the marked section at the top:

```powershell
# Your GitHub username
$USERNAME = "YourGitHubUsername"

# Your GitHub email
$EMAIL = "your@email.com"

# Repositories to create
$REPOS = @(
    @{
        name    = "my-repository"
        desc    = "Repository description."
        folders = @("folder1", "folder2")
    },
    @{
        name    = "another-repo"
        desc    = "Another repository with no folders."
        folders = @()
    }
)
```

- **name**: repository name (no spaces, use hyphens)
- **desc**: description shown on GitHub
- **folders**: folders to create inside the repository. Use `@()` for none

---

## 🚀 Running the script

Open PowerShell, navigate to where the script is saved and run:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\setup-github.ps1
```

---

## ℹ️ Notes

- Repositories are created as **public**
- If a repository already exists on your account, the script skips it and continues
- Folders are created with a `.gitkeep` file so Git tracks them
- The script does not modify or delete anything that already exists
