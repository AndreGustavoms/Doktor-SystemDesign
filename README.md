# Doktor System-Design

Repositorio central de padroes de arquitetura, qualidade, documentacao, prompts e guias reutilizaveis para projetos de software.

## Autor

**Andre Gustavo Melo da Silva**  
GitHub: [@AndreGustavoms](https://github.com/AndreGustavoms)

## Mapa rapido

| Area | Para que serve |
|------|----------------|
| [AGENTS.md](AGENTS.md) | Roteiro de leitura para agentes de IA. Comece por aqui quando for usar o repositorio como contexto operacional. |
| [docs/INDICE-GERAL.md](docs/INDICE-GERAL.md) | Indice completo de documentos, guias e scripts. |
| [docs/GUIA-RAPIDO-USO.md](docs/GUIA-RAPIDO-USO.md) | Fluxo curto para aplicar o system design em um projeto novo. |
| [core/](core/) | Padroes obrigatorios: frontend, backend, README, qualidade minima, prompts base, start script e template de contexto IA. |
| [templates/](templates/) | Templates copiaveis de README, IA, deploy, seguranca e ADR. |
| [docs/CORE-PADROES-OBRIGATORIOS.md](docs/CORE-PADROES-OBRIGATORIOS.md) | Indice dos documentos obrigatorios. |
| [docs/CHECKLIST-PROJETO-PRONTO.md](docs/CHECKLIST-PROJETO-PRONTO.md) | Checklist para validar um projeto antes de entregar ou publicar. |
| [docs/CHECKLIST-PUBLICACAO.md](docs/CHECKLIST-PUBLICACAO.md) | Checklist para revisar identidade, scripts, links e qualidade antes de publicar. |
| [docs/CURADORIA-DOS-GUIAS.md](docs/CURADORIA-DOS-GUIAS.md) | Plano para revisar e transformar guias importados em padroes Doktor. |
| [docs/GUIAS-OPCIONAIS.md](docs/GUIAS-OPCIONAIS.md) | Indice dos guias reutilizaveis por dominio. |
| [docs/GIT-POLITICA-DE-VERSIONAMENTO.md](docs/GIT-POLITICA-DE-VERSIONAMENTO.md) | Politica de branches, commits e documentacao viva. |
| [docs/STACK-E-ARQUITETURA.md](docs/STACK-E-ARQUITETURA.md) | Stack padrao e criterios de arquitetura por tipo de projeto. |
| [docs/IDENTIDADE-DOKTOR.md](docs/IDENTIDADE-DOKTOR.md) | Identidade propria do Doktor: autoria local, influencia da origem e direcao visual/tecnica. |
| [docs/PADROES-OBSERVADOS-GITHUB.md](docs/PADROES-OBSERVADOS-GITHUB.md) | Padroes esteticos, arquiteturais e operacionais observados nos repositorios publicos do autor. |
| [docs/INSTALACAO-EM-OUTROS-PROJETOS.md](docs/INSTALACAO-EM-OUTROS-PROJETOS.md) | Como copiar ou sincronizar estes padroes em outros projetos. |
| [docs/DECISOES-DE-IDENTIDADE.md](docs/DECISOES-DE-IDENTIDADE.md) | Registro das decisoes de autoria, marca, stack e identidade publica. |
| [IA.md](IA.md) | Contexto operacional vivo deste repositorio para continuidade entre sessoes. |
| [guias/](guias/) | Guias opcionais de frontend, backend e integracao, usados somente quando a funcionalidade pedir. |
| [scripts/](scripts/) | Instaladores do comando global de sincronizacao do Doktor System-Design. |
| [scripts/validate-repo.ps1](scripts/validate-repo.ps1) | Validador local usado tambem pela CI. |
| [CHANGELOG.md](CHANGELOG.md) | Historico de versoes e mudancas relevantes. |
| [NOTICE.md](NOTICE.md) | Atribuicao da origem MIT usada como base inicial. |

## Estrutura

```text
Doktor-System-Design/
|-- AGENTS.md
|-- CONTRIBUTING.md
|-- IA.md
|-- LICENSE
|-- NOTICE.md
|-- README.md
|-- VERSION
|-- CHANGELOG.md
|-- core/
|   |-- DESIGN_SYSTEM_BACKEND.md
|   |-- DESIGN_SYSTEM_FRONTEND.md
|   |-- DESIGN_SYSTEM_README.md
|   |-- GUIA-START-APP-SCRIPT.md
|   |-- GUIA_MINIMO_QUALIDADE.md
|   |-- PROMPT_BASE_BACKEND.md
|   |-- PROMPT_BASE_FRONTEND.md
|   `-- TEMPLATE-CONTEXTO-IA.md
|-- docs/
|   |-- CHECKLIST-PUBLICACAO.md
|   |-- CHECKLIST-PROJETO-PRONTO.md
|   |-- CORE-PADROES-OBRIGATORIOS.md
|   |-- CURADORIA-DOS-GUIAS.md
|   |-- DECISOES-DE-IDENTIDADE.md
|   |-- GUIA-RAPIDO-USO.md
|   |-- GIT-POLITICA-DE-VERSIONAMENTO.md
|   |-- GUIAS-OPCIONAIS.md
|   |-- IDENTIDADE-DOKTOR.md
|   |-- INDICE-GERAL.md
|   |-- STACK-E-ARQUITETURA.md
|   |-- VALIDACAO-SCRIPTS.md
|   `-- INSTALACAO-EM-OUTROS-PROJETOS.md
|-- guias/
|   |-- backend/
|   |-- frontend/
|   `-- integracao/
|-- templates/
`-- scripts/
    |-- bash-zsh/
    |-- cmd/
    `-- powershell/
```

## Uso recomendado

1. Leia [AGENTS.md](AGENTS.md) para saber quais arquivos abrir em cada tipo de tarefa.
2. Use [core/GUIA_MINIMO_QUALIDADE.md](core/GUIA_MINIMO_QUALIDADE.md) como contrato minimo para qualquer entrega.
3. Use os documentos em `core/` como padrao obrigatorio de projeto.
4. Use [docs/GUIA-RAPIDO-USO.md](docs/GUIA-RAPIDO-USO.md) para aplicar em projeto novo sem ler tudo.
5. Use `templates/` para criar README, IA, deploy, seguranca e ADR.
6. Consulte `guias/` apenas quando a funcionalidade aparecer no escopo.
7. Atualize [IA.md](IA.md) quando houver decisoes estruturais, riscos ou pendencias relevantes.
8. Antes de publicar, confira o estado das escolhas em [docs/DECISOES-DE-IDENTIDADE.md](docs/DECISOES-DE-IDENTIDADE.md).

## Stack padrao

O Doktor System-Design agora usa uma baseline tecnica documentada em [docs/STACK-E-ARQUITETURA.md](docs/STACK-E-ARQUITETURA.md). Resumo:

| Contexto | Padrao |
|----------|--------|
| Frontend app | React + TypeScript + Vite + Tailwind CSS |
| Frontend simples | HTML + CSS + JavaScript |
| Backend comum | Python + Django + Django REST Framework |
| Banco inicial | SQLite |
| Banco em producao | PostgreSQL |
| Deploy backend pequeno/medio | Railway ou plataforma equivalente |
| Automacao | Python, PowerShell e Bash conforme ambiente |

Desvios sao permitidos quando houver motivo tecnico claro e documentado.

## Validacao

Rode localmente:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-repo.ps1
```

O mesmo validador roda na GitHub Actions em push e pull request.

## Licenca e origem

O material base foi importado de um projeto MIT. A atribuicao foi preservada em [NOTICE.md](NOTICE.md) e a licenca esta em [LICENSE](LICENSE).
