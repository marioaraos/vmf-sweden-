Write-Host "VMF GitHub Update Script"

# Verificar que es un repo git
if (!(Test-Path ".git")) {
    Write-Host "ERROR: Este directorio no es un repositorio Git"
    exit
}

# Mostrar estado
git status

# Pedir mensaje de commit
$commitmsg = Read-Host "Escribe el mensaje del commit"

# Agregar cambios
git add .

# Commit
git commit -m "$commitmsg"

# Rama actual
$branch = git branch --show-current

# Push
Write-Host "Subiendo cambios a GitHub (rama: $branch)..."
git push origin $branch

Write-Host "Repo actualizado correctamente"
