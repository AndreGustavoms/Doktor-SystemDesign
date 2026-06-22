# Guia Rapido de Uso

Este guia mostra como aplicar o Doktor System-Design em um projeto novo sem ler o repositorio inteiro.

## Quando usar

Use quando voce quer iniciar, revisar ou organizar um projeto com padroes claros de arquitetura, documentacao, qualidade e apoio por IA.

## Quando nao usar

Nao use como checklist cego. Se o projeto for muito pequeno, aplique apenas o minimo necessario: README, `IA.md`, stack real e validacao objetiva.

## Fluxo de 5 minutos

1. Copie os arquivos essenciais:

```text
core/GUIA_MINIMO_QUALIDADE.md
core/DESIGN_SYSTEM_README.md
core/TEMPLATE-CONTEXTO-IA.md
docs/STACK-E-ARQUITETURA.md
docs/CHECKLIST-PROJETO-PRONTO.md
```

2. Crie no projeto destino:

```text
README.md
IA.md
docs/
```

3. Use os templates:

| Necessidade | Template |
|-------------|----------|
| README inicial | [../templates/README-template.md](../templates/README-template.md) |
| Memoria operacional IA | [../templates/IA-template.md](../templates/IA-template.md) |
| Deploy | [../templates/DEPLOY-template.md](../templates/DEPLOY-template.md) |
| Seguranca | [../templates/SECURITY-template.md](../templates/SECURITY-template.md) |
| Decisao arquitetural | [../templates/ADR-0001-template.md](../templates/ADR-0001-template.md) |

4. Escolha a stack no contexto correto:

| Tipo de projeto | Caminho recomendado |
|-----------------|--------------------|
| Frontend app | React + TypeScript + Vite + Tailwind |
| Frontend simples | HTML + CSS + JavaScript |
| Backend CRUD/API | Python + Django + DRF |
| Fullstack JS pragmatico | React + TypeScript + Node + PostgreSQL |
| Script/automacao | Python ou PowerShell conforme ambiente |

5. Antes de considerar pronto, rode:

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/validate-repo.ps1
```

No Windows PowerShell antigo:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-repo.ps1
```

## Por tipo de tarefa

### Novo frontend

Leia:

- [../core/DESIGN_SYSTEM_FRONTEND.md](../core/DESIGN_SYSTEM_FRONTEND.md)
- [../guias/frontend/GUIA-COMPONENTES-UI-COMPOSTOS.md](../guias/frontend/GUIA-COMPONENTES-UI-COMPOSTOS.md)
- [../guias/frontend/GUIA-BREADCRUMB-E-METADATA-BAR.md](../guias/frontend/GUIA-BREADCRUMB-E-METADATA-BAR.md), se houver caminho tecnico ou arquivo

Entregue:

- componentes base em `components/ui`;
- estados de loading, vazio e erro;
- layout mobile e desktop;
- README com setup e validacao.

### Novo backend

Leia:

- [../core/DESIGN_SYSTEM_BACKEND.md](../core/DESIGN_SYSTEM_BACKEND.md)
- [../core/PROMPT_BASE_BACKEND.md](../core/PROMPT_BASE_BACKEND.md)
- [../docs/STACK-E-ARQUITETURA.md](STACK-E-ARQUITETURA.md)

Entregue:

- contratos de API claros;
- validacao de entrada;
- testes minimos;
- docs de variaveis e deploy;
- registro em `IA.md`.

### Novo fullstack

Leia primeiro:

- [../core/GUIA_MINIMO_QUALIDADE.md](../core/GUIA_MINIMO_QUALIDADE.md)
- [../core/DESIGN_SYSTEM_FRONTEND.md](../core/DESIGN_SYSTEM_FRONTEND.md)
- [../core/DESIGN_SYSTEM_BACKEND.md](../core/DESIGN_SYSTEM_BACKEND.md)

Depois escolha guias opcionais apenas quando a funcionalidade aparecer.

## Regra pratica

O Doktor nao deve deixar o projeto mais pesado. Ele deve deixar mais facil responder:

- o que esta sendo construido;
- como roda;
- como valida;
- quais decisoes ja foram tomadas;
- o que falta para publicar.

