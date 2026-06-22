# Template de Contexto IA para Projetos

> **O que **: Este arquivo  o **template padro de contexto operacional para projetos desenvolvidos com apoio de IA**.
>
> **De onde ele vem**: Ele nasce do repositrio **Doktor System-Design**, junto com outros artefatos-base como o `DESIGN_SYSTEM_FRONTEND.md`, o `PROMPT_BASE_BACKEND.md` e o `DESIGN_SYSTEM_README.md`. Enquanto esses arquivos padronizam visual, execuo e documentao, este template padroniza a **memria tcnica do projeto** para uso por modelos de IA.
>
> **Qual  o propsito**: Servir como um **ponto nico de recuperao de contexto**. Ao copiar este arquivo para um projeto real, a IA consegue entender objetivo, stack, decises, bugs, testes e integraes sem depender de reler todo o cdigo ou o histrico completo da conversa.
>
> **Como ele deve ser usado**: Neste repositrio, ele funciona como **template mestre**. Em outros projetos, deve ser copiado e preenchido continuamente durante o desenvolvimento.
>
> **Pblico-alvo**: Principalmente modelos de IA e fluxos de trabalho assistidos por IA. O contedo pode ser tcnico, direto e especfico.
>
> **Regra fundamental**: Todo contexto relevante deve estar **neste nico arquivo**. No espalhe informaes crticas em vrios lugares se a inteno for permitir retomada rpida por outra IA ou por uma nova sesso.

## Contexto dentro do Doktor System-Design

Este repositrio no guarda apenas padres visuais. Ele centraliza os artefatos que eu reutilizo para iniciar e manter projetos consistentes do comeo ao fim. Dentro desse conjunto, este arquivo ocupa o papel de **memria persistente da execuo tcnica**.

Ele complementa os demais arquivos assim:

- `DESIGN_SYSTEM_FRONTEND.md` define padres visuais e de interface
- `DESIGN_SYSTEM_BACKEND.md` define padres de qualidade e arquitetura backend
- `PROMPT_BASE_BACKEND.md` define a forma de pedir implementao e arquitetura para IA
- `PROMPT_BASE_FRONTEND.md` define a forma de pedir interface e componentes para IA
- `DESIGN_SYSTEM_README.md` define como documentar o projeto para humanos
- `TEMPLATE-CONTEXTO-IA.md` (este arquivo, copiado como `IA.md` no projeto destino) define como preservar o contexto acumulado do projeto para IA

Nos guias tcnicos deste acervo, modularizao forte e separao clara de responsabilidades so tratadas como princpios estruturais centrais, especialmente no material de backend.

Alm dos padres gerais, a pasta `guias/` tambm concentra guias reaproveitveis mais especficos, organizados em `frontend/`, `backend/` e `integracao/`, extrados de projetos reais quando esse recorte tcnico fizer sentido.

Se o design system dita **como construir com consistncia**, este arquivo registra **o que j foi decidido, testado e aprendido** durante a construo.

---

## Como a IA deve usar este template

Quando este template for copiado para um projeto real, a IA responsvel deve trat-lo como a fonte principal de contexto acumulado do projeto.

### Quando registrar

Voc **DEVE** atualizar este arquivo sempre que:

1. **Deciso tcnica for tomada**  escolha de lib, padro, arquitetura, estrutura de banco
2. **Stack for definida ou alterada**  linguagem, framework, dependncias
3. **Teste importante passar ou falhar**  testes que validam comportamento crtico
4. **Design/arquitetura mudar**  refatoraes, mudana de padro, novo mdulo
5. **Bug significativo for resolvido**  causa raiz e fix aplicado
6. **Meta ou objetivo mudar**  pivs, mudanas de escopo, prioridades
7. **Conveno for estabelecida**  naming, estrutura de pastas, padro de commit
8. **Integrao externa for configurada**  APIs, servios, credenciais (sem expor secrets)
9. **Milestone for atingida**  feature completa, release, deploy
10. **Resumo de deciso relevante**  registre contexto, alternativas consideradas, concluso e validao de decises complexas

### Por que registrar resumo de deciso?

Modelos de IA podem **alucinar ou se confundir** durante decises longas. Registrar um resumo tcnico e auditvel permite:

- **Identificar onde o erro comeou**  se o resultado final estiver errado, d pra rastrear qual passo do raciocnio divergiu
- **Evitar loops**  se a IA j tentou um caminho e falhou, o registro impede que tente de novo
- **Retomar com outro modelo**  um modelo diferente consegue ler a deciso anterior e continuar de onde parou
- **Auditar alucinaes**  comparao entre a deciso registrada e o cdigo gerado revela inconsistncias

### Como registrar

- Seja **tcnico e especfico**  ex: "Migrado de `express` para `fastify` por performance em rotas async"
- Use **timestamps**  formato `[YYYY-MM-DD]`
- Registre o **porqu**, no s o qu  decises sem justificativa perdem valor
- Mantenha cada entrada **curta**  1-3 linhas por item
- Use as sees abaixo  no crie sees novas sem necessidade

---

## Objetivo do projeto

<!-- 
  Descreva aqui o objetivo principal do projeto em 2-3 frases.
  Atualize se o escopo mudar.
  Exemplo:
  [2026-03-11] API REST para gerenciamento de tarefas com autenticao JWT.
  Pblico: uso pessoal. Deploy: VPS prpria. Prioridade: simplicidade > escalabilidade.
-->

_Preencher no incio do projeto._

---

## Metas e milestones

<!-- 
  Liste as metas do projeto e marque conforme forem atingidas.
  Formato: [DATA] STATUS - Descrio
  STATUS: ? pendente | ? em progresso | ? concluda | ? cancelada
-->

_Preencher conforme o projeto avana._

---

## Stack e dependencias

<!-- 
  Registre a stack completa e dependncias instaladas.
  Atualize quando adicionar/remover/trocar qualquer tecnologia.
  Exemplo:
  [2026-03-11] Back-end: Python 3.12 + Django 5.1 + DRF 3.15
  [2026-03-11] DB: PostgreSQL 16 via Docker
  [2026-03-12] Adicionado django-cors-headers para CORS em dev
-->

_Preencher no setup do projeto._

---

## Decisoes de arquitetura

<!-- 
  Registre decises estruturais e o motivo de cada uma.
  Exemplo:
  [2026-03-11] Monolito Django ao invs de microservios  projeto pequeno, no justifica a complexidade.
  [2026-03-11] Pasta `services/` para lgica de negcio separada das views  facilita testes unitrios.
  [2026-03-12] JWT via `djangorestframework-simplejwt` ao invs de sesso  API stateless para consumo mobile futuro.
-->

_Preencher ao tomar decises._

---

## Decisoes de design e convencoes

<!-- 
  Padres de cdigo, naming, estrutura que foram definidos.
  Exemplo:
  [2026-03-11] Nomes de variveis e funes em ingls, comentrios em portugus.
  [2026-03-11] Commits seguem Conventional Commits: feat/fix/docs/refactor.
  [2026-03-11] Respostas da API sempre em formato { "data": ..., "error": ... }.
-->

_Preencher conforme convenes forem definidas._

---

## Testes importantes

<!-- 
  Registre testes que validam comportamento crtico.
  Inclua o que o teste cobre e se passou/falhou.
  Exemplo:
  [2026-03-12] ? test_auth_login  Login com credenciais vlidas retorna token JWT.
  [2026-03-12] ? test_auth_login_invalid  Credenciais invlidas retorna 401.
  [2026-03-13] ? test_upload_large_file  Timeout em arquivos >50MB. Fix pendente: aumentar TIMEOUT no nginx.
-->

_Preencher ao rodar testes._

---

## Bugs e fixes relevantes

<!-- 
  Bugs significativos e como foram resolvidos.
  Exemplo:
  [2026-03-13] BUG: CORS bloqueando requests do frontend em produo.
  CAUSA: `ALLOWED_ORIGINS` no inclua domnio com www.
  FIX: Adicionado `https://www.dominio.com` em settings.py L45.
-->

_Preencher ao resolver bugs._

---

## Integracoes e servicos externos

<!-- 
  APIs, servios e integraes configuradas.
  NO registre secrets/tokens aqui  apenas o servio e como est configurado.
  Exemplo:
  [2026-03-14] Stripe API  checkout de pagamento. Webhook configurado em /api/webhooks/stripe.
  [2026-03-14] SendGrid  envio de emails transacionais. Template ID: d-abc123.
-->

_Preencher conforme integraes forem adicionadas._

---

## Notas gerais

<!-- 
  Qualquer informao que no se encaixe nas sees acima
  mas que seria til para outra IA retomar o contexto.
  Exemplo:
  [2026-03-11] O cliente pediu para no usar Docker em produo  deploy direto na VPS.
  [2026-03-15] Performance: endpoint /api/reports leva ~3s. Otimizar se virar problema.
-->

_Preencher quando necessrio._

---

## Resumos de decisao

<!-- 
  Registre aqui um resumo tcnico de decises complexas, debug difcil
  ou qualquer situao onde contexto, alternativas e concluso importem.
  No registre chain of thought interno bruto; registre apenas informao til,
  verificvel e retomvel por outra pessoa ou IA.
  
  Formato:
  [YYYY-MM-DD] CONTEXTO: <o que estava tentando fazer>
  ALTERNATIVAS: <caminhos considerados>
  DECISO: <caminho escolhido e motivo>
  VALIDAO: <teste, verificao ou evidncia>
  
  Exemplo:
  [2026-03-13] CONTEXTO: Endpoint /api/users retornando 500 em produo.
  ALTERNATIVAS: Renomear no frontend ou aceitar `email` e `user_email` no serializer.
  DECISO: Aceitar ambos temporariamente para manter compatibilidade.
  VALIDAO: Teste de login com os dois formatos passou.
  
  [2026-03-14] CONTEXTO: Tentando implementar cache com Redis para /api/reports.
  ALTERNATIVAS: django-cacheops, redis-py direto ou Django cache framework.
  DECISO: Usar `django.core.cache` com `django-redis`, por simplicidade e cobertura suficiente.
  VALIDAO: Endpoint pesado respondeu com cache de 5min sem alterar contrato da API.
-->

_Preencher durante debug complexo ou decises que envolvam mltiplos caminhos._

---
