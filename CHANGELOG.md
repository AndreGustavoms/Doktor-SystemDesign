# Changelog

Todas as mudancas relevantes do Doktor System-Design devem ser registradas aqui.

Formato baseado em Conventional Commits e versoes semanticas.

## [Nao lancado]

## [0.2.0] - 2026-06-23

### Adicionado

- `core/DESIGN_SYSTEM_ARQUITETURA.md`: padrao de organizacao por camadas, nomenclatura, regras de funcao e arquivo, antipadroes e checklist de entrega.
- `scripts/hooks/commit-msg`: hook Git nativo para validar Conventional Commits antes de cada commit, sem dependencias externas.
- Instrucoes de instalacao do hook em `docs/GIT-POLITICA-DE-VERSIONAMENTO.md`.

### Alterado

- Politica de commits expandida: estrutura com escopo opcional `tipo(escopo): descricao`, tipos `style` e `test` adicionados, modo imperativo e regra de nao misturar refatoracao com feature.
- Pasta destino do comando `doktor` renomeada de `Padrao de qualidade - Doktor System-Design` para `doktor SystemDesign`.
- Repositorio renomeado no GitHub para `Doktor-SystemDesign`; remote local e todas as referencias internas atualizados.
- `AGENTS.md` e `docs/CORE-PADROES-OBRIGATORIOS.md` atualizados com referencia ao novo padrao de arquitetura.

### Corrigido

- `scripts/cmd/doktor-command.cmd`: output exibia caminhos completos da pasta temporaria; corrigido para usar exit code do robocopy com SHA do commit.

### Validado

- Scripts de instalacao testados em ambiente real: PowerShell (install, doktor, idempotencia, uninstall), CMD (install, doktor, uninstall), Bash/Git Bash (sintaxe, install e uninstall com rsync fake).
- Comando `doktor` sincroniza 58 arquivos a partir da URL `https://github.com/AndreGustavoms/Doktor-SystemDesign.git`.

## [0.1.0] - 2026-06-22

### Adicionado

- Estrutura inicial do Doktor System-Design.
- Core de frontend, backend, README, qualidade minima, prompts e contexto IA.
- Guias opcionais de frontend, backend e integracao.
- Identidade Doktor com autoria local e atribuicao de origem.
- Templates copiaveis para README, IA, deploy, seguranca e ADR.
- Guia rapido de uso.
- Checklist de projeto pronto.
- Validador PowerShell e workflow GitHub Actions.
- Scripts do comando global `doktor`.
- Template de `AGENTS.md` para orientar agentes de IA em projetos destino.

### Alterado

- README, AGENTS e guia rapido deixam explicito que o Doktor e um padrao leve, progressivo e focado em economia de contexto.
- Checklist e template de README consideram `AGENTS.md` parte do fluxo de projetos com apoio de IA.
- Guia rapido diferencia adocao minima, recomendada e completa, com prompt inicial para orientar a IA.

### Validado

- ASCII, links Markdown relativos, texto quebrado, parser PowerShell e help CMD.
- Tag `v0.1.0` publicada apos confirmacao do remoto correto.
