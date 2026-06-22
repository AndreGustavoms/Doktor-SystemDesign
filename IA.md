# IA.md - Contexto Operacional

## Objetivo atual

Transformar este repositorio em uma base propria de system design, qualidade e guias reutilizaveis para projetos Doktor, aproveitando o que havia de bom no repositorio de referencia sem copiar identidade pessoal de terceiros para o corpo da documentacao.

## Estado atual

- Estrutura importada: `core/`, `docs/`, `guias/`, `scripts/`, `AGENTS.md`, `CONTRIBUTING.md`, `LICENSE`.
- README reescrito para servir como porta de entrada do Doktor System-Design.
- Identidade pessoal separada em `docs/DECISOES-DE-IDENTIDADE.md`.
- Atribuicao legal centralizada em `NOTICE.md` e `LICENSE`.
- Identidade publica definida: Andre Gustavo Melo da Silva, GitHub `AndreGustavoms`, nome `Doktor System-Design`.
- Comando global escolhido: `doktor`, em minusculo.
- Scripts simplificados para sincronizar este repositorio sem submodulos.
- Stack consolidada em `docs/STACK-E-ARQUITETURA.md` como baseline tecnica por contexto.
- `CONTRIBUTING.md` reescrito em tom neutro.
- Checklist de publicacao criado em `docs/CHECKLIST-PUBLICACAO.md`.
- Indice geral criado em `docs/INDICE-GERAL.md`.
- Identidade Doktor criada em `docs/IDENTIDADE-DOKTOR.md`, misturando autoria local, padroes observados e influencia da origem MIT.
- Plano de curadoria dos guias criado em `docs/CURADORIA-DOS-GUIAS.md`.
- `core/GUIA_MINIMO_QUALIDADE.md` e `docs/STACK-E-ARQUITETURA.md` marcados como revisados na curadoria.
- `core/DESIGN_SYSTEM_BACKEND.md` reescrito e marcado como revisado.
- `core/DESIGN_SYSTEM_FRONTEND.md` reescrito e marcado como revisado.
- `core/DESIGN_SYSTEM_README.md` reescrito e marcado como revisado.
- `core/PROMPT_BASE_BACKEND.md` e `core/PROMPT_BASE_FRONTEND.md` reescritos e marcados como revisados.
- `core/GUIA-START-APP-SCRIPT.md` marcado como revisado apos validacao estrutural.
- Guias de integracao revisados: Railway, Scraping Multiformato e GitHub API.
- Leitura dos repositorios publicos de `AndreGustavoms` registrada em `docs/PADROES-OBSERVADOS-GITHUB.md`.
- Guias frontend revisados/criados: Background Visual, Calendario Academico, Particulas e Glow, Componentes UI Compostos, Breadcrumb e Metadata Bar, Arvore Hierarquica, Arvore de Materiais Dual View, Heatmap de Atividade, Onboarding e Ajuda, Sistema de Alerta e Grade.
- Guia rapido de uso, checklist de projeto pronto e templates copiaveis criados.
- CI simples adicionada com `scripts/validate-repo.ps1` e `.github/workflows/validate.yml`.
- Guias backend CPF e Cifra de Cesar reescritos no padrao Doktor.
- Versao inicial registrada em `VERSION` e `CHANGELOG.md`.

## Decisoes tomadas

- Nao trazer submodulos externos do repositorio de origem.
- Manter atribuicao MIT da origem, sem repetir assinaturas pessoais no fim dos guias.
- Usar ASCII nos arquivos normalizados para evitar texto quebrado vindo da origem.
- Tratar stack como baseline tecnica revisavel do repositorio, nao como preferencia pessoal publica.
- Publicar autoria local como Andre Gustavo Melo da Silva / AndreGustavoms.
- Usar padroes observados no GitHub como direcao inicial, nao como regra cega para todo projeto.
- Misturar influencia Felixo/Felipe como heranca estetica/metodologica documentada, sem transferir autoria pessoal para o README principal ou guias tecnicos.

## Pendencias

- Melhorar gradualmente qualquer guia novo importado.
- Seguir `docs/CURADORIA-DOS-GUIAS.md` para manter os guias opcionais como padroes Doktor revisados.
- Testar os instaladores `scripts/` em ambientes reais antes de recomendar uso publico amplo.
- Usar `docs/CHECKLIST-PUBLICACAO.md` antes de push/divulgacao.
- Criar tag `v0.1.0` depois de confirmar remoto correto e renderizacao no GitHub.

## Validacao recente

- Varredura por identidade pessoal confirmou que nomes de terceiros ficaram apenas em `LICENSE` e `NOTICE.md`.
- Varredura por residuos de submodulo nos scripts deve ser repetida apos qualquer alteracao em `scripts/`.
- Guias de integracao foram alinhados ao padrao de abertura Doktor e a documentacao oficial foi consultada para Railway/GitHub.
- Padroes publicos observados: app operacional, React/TypeScript/Vite/Tailwind, componentes proprios, Lucide, acento verde/ciano, documentacao forte e seguranca desde o desenho.
- Blocos de interrogacao conhecidos nos guias frontend foram removidos por reescrita dos guias afetados.
- Guias frontend opcionais foram neutralizados para nao depender de projetos pessoais ou exemplos herdados.
- Identidade Doktor agora aceita influencia da origem como DNA de system design, preservada em documento proprio e atribuicao legal.
- Validador local cobre ASCII, links Markdown, texto quebrado, parser PowerShell e help CMD.
- Bash/Zsh real ainda nao foi validado porque o ambiente local apontou para WSL sem `/bin/bash`.
