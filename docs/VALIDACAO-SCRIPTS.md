# Validacao dos Scripts

Este documento registra como validar os scripts do comando global `doktor` sem confundir teste de parser com instalacao real.

## Estado atual

Validacao local realizada em Windows, em 2026-06-22:

| Script | Validacao | Resultado |
|--------|-----------|-----------|
| `scripts/powershell/install-doktor-powershell.ps1` | Parser PowerShell via `[scriptblock]::Create(...)` | OK |
| `scripts/cmd/doktor-command.cmd` | `cmd /c scripts\cmd\doktor-command.cmd --help` | OK |
| `scripts/cmd/install-doktor-cmd.cmd` | `--uninstall` nao destrutivo para o repo | OK |
| `scripts/bash-zsh/install-doktor-bash-zsh.sh` | `bash -n` tentou usar WSL local | Bloqueado: `/bin/bash` ausente no WSL |

## O que ainda precisa de ambiente real

- Instalar o comando PowerShell em perfil temporario ou maquina de teste.
- Instalar o comando CMD e confirmar PATH em um novo terminal.
- Testar Bash/Zsh em Linux, macOS, Git Bash ou WSL com `/bin/bash` disponivel.
- Rodar `doktor` em pasta temporaria e confirmar que sincroniza apenas o destino `Padrao de qualidade - Doktor System-Design`.

## Validacao segura automatizada

Rode:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-repo.ps1
```

Ou, se tiver PowerShell 7:

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/validate-repo.ps1
```

Essa validacao cobre:

- ASCII;
- links Markdown relativos;
- texto quebrado conhecido;
- parser do instalador PowerShell;
- help do comando CMD;
- presenca dos scripts esperados.

## Validacao manual recomendada

Use uma pasta temporaria fora de qualquer projeto importante:

```powershell
$tmp = Join-Path $env:TEMP ("doktor-real-test-" + [guid]::NewGuid())
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
Set-Location $tmp
```

Depois teste o terminal desejado.

### PowerShell

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File C:\caminho\Doktor-System-Design\scripts\powershell\install-doktor-powershell.ps1
```

Abra um novo terminal e rode:

```powershell
doktor -Help
doktor
```

### CMD

```cmd
C:\caminho\Doktor-System-Design\scripts\cmd\install-doktor-cmd.cmd
```

Abra um novo CMD e rode:

```cmd
doktor --help
doktor
```

### Bash/Zsh

```bash
sh /caminho/Doktor-System-Design/scripts/bash-zsh/install-doktor-bash-zsh.sh
```

Abra um novo terminal ou rode `source ~/.bashrc`/`source ~/.zshrc`, depois:

```bash
doktor --help
doktor
```

## Criterio de aceite

O teste real passa quando:

- o comando `doktor --help` ou `doktor -Help` responde;
- `doktor` cria ou atualiza somente a pasta destino;
- arquivos fora da pasta destino nao sao removidos;
- uma segunda execucao informa que ja estava atualizado ou nao aplica mudancas inesperadas.

