# Como Usar em Outros Projetos

Este documento mostra formas praticas de copiar ou sincronizar o **Doktor System-Design** dentro de outros projetos.

> Voltar ao [README](../README.md).

## 1. Sincronizar uma copia local

Use quando quiser manter uma pasta independente, sem trazer o historico Git deste repositorio.

### PowerShell

```powershell
$repoUrl = "https://github.com/AndreGustavoms/Doktor-System-Design.git"
$dest = "Padrao de qualidade - Doktor System-Design"
$tmpDir = Join-Path $env:TEMP ("doktor-standards-" + [guid]::NewGuid())

git clone --depth 1 $repoUrl $tmpDir
Remove-Item -Recurse -Force (Join-Path $tmpDir ".git")
New-Item -ItemType Directory -Force -Path $dest | Out-Null
robocopy $tmpDir $dest /MIR | Out-Null
Remove-Item -Recurse -Force $tmpDir
```

### Linux, macOS, Git Bash ou WSL

```bash
repo_url="https://github.com/AndreGustavoms/Doktor-System-Design.git"
dest="Padrao de qualidade - Doktor System-Design"
tmp_dir="$(mktemp -d)"

git clone --depth 1 "$repo_url" "$tmp_dir/repo"
rm -rf "$tmp_dir/repo/.git"
mkdir -p "$dest"
rsync -a --delete "$tmp_dir/repo/" "$dest/"
rm -rf "$tmp_dir"
```

## 2. Usar os instaladores do comando global

Os scripts em [../scripts](../scripts) instalam um comando de sincronizacao para baixar a versao mais recente deste repositorio em qualquer pasta.

| Terminal | Script |
|----------|--------|
| Bash ou Zsh | [scripts/bash-zsh/install-doktor-bash-zsh.sh](../scripts/bash-zsh/install-doktor-bash-zsh.sh) |
| PowerShell | [scripts/powershell/install-doktor-powershell.ps1](../scripts/powershell/install-doktor-powershell.ps1) |
| CMD | [scripts/cmd/install-doktor-cmd.cmd](../scripts/cmd/install-doktor-cmd.cmd) |

O comando instalado e `doktor`, em minusculo. Ele sincroniza uma copia completa deste repositorio na pasta atual, dentro de `Padrao de qualidade - Doktor System-Design`.

## 3. Baixar como ZIP

### PowerShell

```powershell
Invoke-WebRequest -Uri "https://github.com/AndreGustavoms/Doktor-System-Design/archive/refs/heads/main.zip" -OutFile "doktor-system-design.zip"
Expand-Archive "doktor-system-design.zip" -DestinationPath .
Rename-Item "Doktor-System-Design-main" "Padrao de qualidade - Doktor System-Design"
Remove-Item "doktor-system-design.zip"
```

### Linux, macOS, Git Bash ou WSL

```bash
curl -L https://github.com/AndreGustavoms/Doktor-System-Design/archive/refs/heads/main.zip -o doktor-system-design.zip
unzip doktor-system-design.zip
mv Doktor-System-Design-main "Padrao de qualidade - Doktor System-Design"
rm doktor-system-design.zip
```

## 4. Clonar com Git

```bash
git clone --depth 1 https://github.com/AndreGustavoms/Doktor-System-Design.git "Padrao de qualidade - Doktor System-Design"
```

Use esta opcao quando quiser atualizar depois com `git pull`.

## 5. Baixar apenas uma pasta com sparse checkout

### Apenas `core/`

```bash
mkdir doktor-core
cd doktor-core
git init
git remote add -f origin https://github.com/AndreGustavoms/Doktor-System-Design.git
git sparse-checkout init --no-cone
git sparse-checkout set core
git pull origin main
```

### Apenas `guias/`

```bash
mkdir doktor-guias
cd doktor-guias
git init
git remote add -f origin https://github.com/AndreGustavoms/Doktor-System-Design.git
git sparse-checkout init --no-cone
git sparse-checkout set guias
git pull origin main
```

## Escolha rapida

| Cenario | Melhor opcao |
|---------|--------------|
| Quero uma copia independente e atualizavel | Sincronizar uma copia local |
| Quero instalar rapidamente sem Git depois | ZIP |
| Quero manter vinculo Git | `git clone` |
| Quero so os padroes obrigatorios | Sparse checkout de `core/` |
| Quero so guias reutilizaveis | Sparse checkout de `guias/` |
| Quero um comando recorrente | Instaladores em `scripts/` |
