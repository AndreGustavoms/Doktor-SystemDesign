# Changelog

Todas as mudancas relevantes do Doktor System-Design devem ser registradas aqui.

Formato baseado em Conventional Commits e versoes semanticas.

## [0.3.0] - 2026-07-23

### Adicionado

- `core/DESIGN_SYSTEM_ECONOMIA_IA.md`: niveis de tarefa vs. nivel de modelo de IA, economia de contexto (nao reler o ja registrado, delegar buscas amplas, evitar duplicar trabalho entre agentes) e regra de escala do acervo (mais guias nao significa mais leitura por tarefa).
- `docs/POLITICA-DE-ATUALIZACAO.md`: gatilhos de revisao e processo de comparacao periodica com o repositorio de origem.
- Suite de testes automatizados para os instaladores (`scripts/tests/installers.tests.ps1`, `scripts/tests/run-tests.ps1`, `scripts/cmd/tests/ensure-gitignore.tests.ps1`, `scripts/bash-zsh/tests/installers.tests.sh`) - o repositorio nao tinha nenhum teste automatizado antes desta leva.
- Dois guias portados do repositorio de origem: `guias/frontend/GUIA-PAINEL-DE-COLECAO-COM-FILTROS-E-VIEWS.md` e `guias/integracao/GUIA-NOTION-COMO-BASE-DE-DADOS.md`.
- Oito guias tecnicos novos: `guias/integracao/GUIA-INTEGRACAO-LLM-E-AGENTES.md`, `guias/backend/GUIA-AUTENTICACAO-JWT-OAUTH.md`, `guias/backend/GUIA-FILAS-E-JOBS-ASSINCRONOS.md`, `guias/backend/GUIA-CACHE-COM-REDIS.md`, `guias/frontend/GUIA-FORMULARIOS-COMPLEXOS.md`, `guias/frontend/GUIA-TABELA-DE-DADOS-SERVER-SIDE.md`, `guias/integracao/GUIA-CI-CD-BASICO.md`, `guias/integracao/GUIA-OBSERVABILIDADE-LOGS-E-HEALTHCHECKS.md`.
- Secao "Sincronizacao com o remoto" em `docs/GIT-POLITICA-DE-VERSIONAMENTO.md`: `git pull` antes de comecar a commitar, `git push` automatico ao final de cada leva de commits.
- Secao "Estado atual (resumo vivo)" no `IA.md` deste repositorio, alinhando o arquivo real com o que `AGENTS.md`/`DESIGN_SYSTEM_ECONOMIA_IA.md` ja instruiam a IA a ler primeiro.

### Alterado

- `core/GUIA_MINIMO_QUALIDADE.md`: reintegradas regras de anti-alucinacao, validacao com evidencia real de execucao, regua unica de testes, automacao-antes-de-edicao-manual e dependencias pinadas com auditoria - perdidas numa reescrita anterior e recuperadas apos comparacao com o repositorio de origem.
- `core/DESIGN_SYSTEM_BACKEND.md`: adicionado TDD como fluxo preferencial, "ferramenta antes da solucao especifica" e documentacao viva em tempo real.
- `core/GUIA-START-APP-SCRIPT.md`: de `start_app.py` com flags de linha de comando restrito a apps web, para menu interativo/colorido obrigatorio para todo programa rodavel (web, CLI, automacao, script, desktop).
- `core/PROMPT_BASE_BACKEND.md` e `PROMPT_BASE_FRONTEND.md`: anti-alucinacao, validacao com evidencia real e filosofia de ferramenta reutilizavel.
- `AGENTS.md` e `templates/AGENTS-template.md`: regra de no maximo 1 guia opcional aberto por tarefa (mesmo com o acervo maior), regra de automacao-antes-de-ajuste-manual, regra de sincronizacao com o remoto.
- `core/TEMPLATE-CONTEXTO-IA.md` e `templates/IA-template.md`: mecanismo de arquivamento (`docs/ia-archive/IA-ARCHIVE-<ano>.md`) e secao "Estado atual (resumo vivo)" reescrevivel.
- `docs/GIT-POLITICA-DE-VERSIONAMENTO.md`: secao de limpeza de branch pos-merge; secao de sincronizacao com o remoto.
- Scripts de instalacao: PowerShell ganhou checagem/ajuste de `ExecutionPolicy`; CMD e Bash ganharam `.gitignore` automatico e idempotente da pasta de destino.
- Indices de navegacao (`docs/INDICE-GERAL.md`, `docs/GUIAS-OPCIONAIS.md`, `docs/CURADORIA-DOS-GUIAS.md`, `README.md`) atualizados com os documentos e guias novos.

### Corrigido

- `scripts/cmd/install-doktor-cmd.cmd`: trocado `setx` (que truncava o PATH em 1024 caracteres e convertia `REG_EXPAND_SZ` em `REG_SZ`) por escrita direta no registro via PowerShell, idempotente e sem esse limite.

### Validado

- Suite de testes dos instaladores: 30 testes passando, 1 pulado por ausencia de `rsync` no Git Bash do ambiente de teste (comportamento esperado, documentado em `docs/VALIDACAO-SCRIPTS.md`).
- `scripts/validate-repo.ps1`: ASCII, links Markdown, texto quebrado, parser PowerShell e help CMD, todos OK.

## [0.2.0] - 2026-06-23

### Adicionado

- `core/DESIGN_SYSTEM_ARQUITETURA.md`: padrao de organizacao por camadas, nomenclatura, regras de funcao e arquivo, antipadroes e checklist de entrega.
- `core/DESIGN_SYSTEM_SEGURANCA.md`: padrao obrigatorio de seguranca com secrets, variaveis de ambiente, autenticacao, autorizacao, validacao de entrada, SQL injection, XSS, headers HTTP, OWASP Top 10 e checklist de entrega.
- `core/DESIGN_SYSTEM_API_REST.md`: padrao obrigatorio de contrato HTTP com nomenclatura de endpoints, metodos, status codes, envelope data/error, versionamento, paginacao, filtros, autenticacao Bearer e checklist de entrega.
- `core/DESIGN_SYSTEM_TESTES.md`: padrao obrigatorio de testes com tipos (unitario, integracao, E2E), piramide, nomenclatura, estrutura AAA, mocks, cobertura minima e checklist de entrega.
- `scripts/hooks/commit-msg`: hook Git nativo para validar Conventional Commits antes de cada commit, sem dependencias externas.
- `templates/AGENTS-template.md`: template copiavel do AGENTS.md para projetos destino, com roteiro por tipo de tarefa incluindo os quatro novos padroes.
- `assets/social-preview.png`: imagem 1280x640 para o social preview do GitHub.
- Instrucoes de instalacao do hook em `docs/GIT-POLITICA-DE-VERSIONAMENTO.md`.

### Alterado

- `AGENTS.md`: roteiro expandido com entradas para arquitetura, seguranca, API REST e testes; regra de commit atualizada para Conventional Commits completo com tipos validos e mencao ao hook.
- `docs/CORE-PADROES-OBRIGATORIOS.md`: adicionadas secoes de seguranca, API REST, arquitetura e testes; secao duplicada de API REST removida.
- Politica de commits expandida: estrutura com escopo opcional, tipos style e test adicionados, modo imperativo e regra de nao misturar refatoracao com feature.
- Pasta destino do comando doktor renomeada de "Padrao de qualidade - Doktor System-Design" para "doktor SystemDesign".
- Repositorio renomeado no GitHub para Doktor-SystemDesign; remote local e todas as referencias internas atualizados.
- README, AGENTS, indice e template de AGENTS alinhados com todos os novos padroes de core.
- Caracteres nao ASCII normalizados em DESIGN_SYSTEM_API_REST.md, DESIGN_SYSTEM_SEGURANCA.md e DESIGN_SYSTEM_TESTES.md.
- Validador ASCII ajustado para ignorar assets binarios, como imagens PNG.

### Corrigido

- `scripts/cmd/doktor-command.cmd`: output exibia caminhos completos da pasta temporaria; corrigido para usar exit code do robocopy com SHA do commit.
- `AGENTS.md` e `docs/CORE-PADROES-OBRIGATORIOS.md`: linhas duplicadas de API REST removidas.

### Validado

- Scripts de instalacao testados em ambiente real: PowerShell (install, doktor, idempotencia, uninstall), CMD (install, doktor, uninstall), Bash/Git Bash (sintaxe, install e uninstall com rsync fake).
- Comando doktor sincroniza 58 arquivos a partir da URL https://github.com/AndreGustavoms/Doktor-SystemDesign.git.
- Hook commit-msg instalado e ativo neste repositorio.

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
- Scripts do comando global doktor.
- Template de AGENTS.md para orientar agentes de IA em projetos destino.

### Alterado

- README, AGENTS e guia rapido deixam explicito que o Doktor e um padrao leve, progressivo e focado em economia de contexto.
- Checklist e template de README consideram AGENTS.md parte do fluxo de projetos com apoio de IA.
- Guia rapido diferencia adocao minima, recomendada e completa, com prompt inicial para orientar a IA.

### Validado

- ASCII, links Markdown relativos, texto quebrado, parser PowerShell e help CMD.
- Tag v0.1.0 publicada apos confirmacao do remoto correto.
