# DESIGN SYSTEM PARA ECONOMIA DE IA

> **O que e**: Padrao de como gastar contexto e capacidade de IA de forma proporcional a tarefa, para reduzir custo (tokens, tempo, dinheiro) sem perder qualidade.
>
> **Quando usar**: Sempre que uma tarefa envolver agente de IA - seja voce decidindo qual modelo/ferramenta usar, seja um agente decidindo quantos documentos ler antes de agir.
>
> **Objetivo**: Este acervo ja e um roteador de contexto (ver [`../AGENTS.md`](../AGENTS.md)). Este documento cobre a outra metade do custo: qual "tamanho" de IA usar por tarefa, e como evitar reprocessamento redundante.
>
> **Nao e**: Nao e um benchmark de modelos nem uma tabela de precos - isso muda rapido demais para viver em documentacao versionada. Este guia fala em **niveis de tarefa**, nao em nomes de produto especificos.

---

## 1. Regra central

Gaste capacidade de IA (contexto lido, tamanho do modelo, numero de chamadas) na medida da complexidade e do risco da tarefa - nunca no maximo disponivel por padrao, e nunca no minimo quando o risco for alto.

Tarefa simples com modelo caro e desperdicio. Tarefa critica com modelo economico e risco. O objetivo e casar os dois.

---

## 2. Niveis de tarefa e nivel de IA correspondente

| Nivel de tarefa | Exemplos | Nivel de modelo/agente recomendado |
|---|---|---|
| **Mecanica / leitura** | Buscar um arquivo, listar ocorrencias, resumir um log, aplicar um rename simples, checar se um link existe | Modelo economico e rapido (o "tier" mais leve disponivel na ferramenta em uso). Nao precisa de raciocinio profundo. |
| **Implementacao comum** | Escrever uma feature seguindo padrao ja definido no repositorio, corrigir bug com causa conhecida, escrever teste, revisar PR pequeno | Modelo intermediario (o "tier" padrao da ferramenta). Bom equilibrio custo/qualidade para a maioria do trabalho do dia a dia. |
| **Arquitetura / decisao critica** | Desenhar a arquitetura de um sistema novo, decidir entre trade-offs de seguranca, revisar mudanca de alto risco, debugar problema sem causa raiz clara | Modelo mais avancado disponivel. O custo extra se justifica pelo custo de errar uma decisao estrutural. |

Ao usar Claude especificamente, isso mapeia hoje para a familia de modelos leve/intermediario/avancado (ex.: Haiku/Sonnet/Opus) - consulte [`claude-api`](../core/PROMPT_BASE_BACKEND.md) ou a documentacao oficial da Anthropic para os nomes e versoes atuais, ja que isso muda com o tempo e nao deve ser fixado aqui.

### Regra pratica de escolha

- Comece perguntando: **"se isso der errado, qual o custo de corrigir depois?"** Custo baixo -> modelo economico. Custo alto -> modelo avancado.
- Nao promova uma tarefa mecanica para o modelo mais caro so por seguranca. Isso e o oposto de economia.
- Nao rebaixe uma decisao arquitetural ou de seguranca para o modelo mais barato para "economizar". O prejuizo de uma decisao ruim custa mais do que a diferenca de preco entre tiers.
- Quando em duvida entre dois niveis, escolha o **menor** e escale se o resultado nao for suficiente - e mais barato tentar de novo com mais capacidade do que sempre comecar no teto.

---

## 3. Economia de contexto (independente do modelo escolhido)

Isto vale para qualquer tier de modelo, inclusive o mais avancado: contexto gasto e custo gasto, e contexto mal gasto tambem piora a qualidade da resposta (sinal desnecessario compete com sinal util).

1. **Siga o roteador antes de ler qualquer coisa.** [`AGENTS.md`](../AGENTS.md) diz exatamente quais documentos abrir por tipo de tarefa. Nao leia "por garantia".
2. **Nao releia o que ja esta registrado.** Se `IA.md` ja tem a decisao, o estado atual e as pendencias, parta dali - nao reprocesse o codigo inteiro para redescobrir contexto ja escrito.
3. **Prefira o resumo vivo ao historico completo.** Ao retomar um projeto, leia primeiro a secao "Estado atual (resumo vivo)" do `IA.md` (ver [`TEMPLATE-CONTEXTO-IA.md`](TEMPLATE-CONTEXTO-IA.md)); so desca ao historico datado ou aos archives se o resumo nao bastar.
4. **Delegue busca ampla, nao leitura seletiva.** Quando a tarefa exigir varias buscas exploratorias (ex.: "onde isso e usado no projeto todo"), prefira uma ferramenta/agente dedicado a busca em vez de ler arquivo por arquivo manualmente - evita reler o mesmo arquivo em multiplas idas.
5. **Nao duplique trabalho entre agentes.** Se uma tarefa ja foi delegada a um agente ou subagente, nao repita a mesma investigacao no fluxo principal "por garantia" - use o resultado retornado.
6. **Feche o escopo antes de abrir arquivos.** Identifique o tipo de tarefa primeiro (frontend? backend? guia especifico?) e so entao abra os documentos daquele tipo - evita abrir documentos de todas as categorias "para nao perder nada".
7. **Cache e reaproveitamento tecnico**, quando a ferramenta de IA usada oferecer:
 - Reaproveite prompts de sistema e contexto estavel entre chamadas em vez de reenviar tudo do zero a cada requisicao, quando a API/ferramenta suportar cache de prompt.
 - Em fluxos automatizados (scripts, integracoes), evite chamar o modelo mais de uma vez para a mesma pergunta; registre e reutilize a resposta quando fizer sentido.

---

## 4. Sinais de que o gasto esta desproporcional

- A IA leu mais de 3-4 documentos deste acervo para uma tarefa que o `AGENTS.md` mapeia para 1-2.
- A mesma pergunta foi refeita em modelos diferentes sem motivo (ex.: pedir a mesma analise de novo "para conferir") quando o resultado anterior ja era confiavel.
- Uma tarefa mecanica (rename, busca, formatacao) foi enviada para o modelo mais avancado disponivel.
- Uma decisao de arquitetura ou seguranca foi tomada no modelo mais economico sem revisao posterior.
- O `IA.md` do projeto nao reflete decisoes ja tomadas, forcando a IA a redescobrir contexto por leitura de codigo a cada sessao.

Quando notar um desses sinais, ajuste o fluxo antes de continuar - nao acumule o desperdicio "porque ja comecou assim".

---

## 5. Checklist de economia de IA

- [ ] O nivel de modelo escolhido combina com o risco/complexidade real da tarefa (nem subutilizado, nem superdimensionado).
- [ ] Apenas os documentos indicados pelo `AGENTS.md` para esta tarefa foram lidos.
- [ ] O `IA.md` do projeto foi consultado antes de reprocessar codigo para redescobrir contexto ja registrado.
- [ ] Buscas exploratorias amplas foram delegadas a uma ferramenta/agente dedicado, em vez de leitura manual arquivo por arquivo.
- [ ] Nenhum trabalho foi duplicado entre agente principal e subagentes.
- [ ] Se a ferramenta de IA usada suporta cache de prompt, o contexto estavel foi estruturado para reaproveitar esse cache.

---

## 6. Ideias para quem quiser contribuir

- Um pequeno registro de "custo por tipo de tarefa" real (tokens ou tempo gasto) para calibrar os niveis da secao 2 com dados, nao so intuicao.
- Uma versao deste guia com exemplos por ferramenta especifica (Claude Code, outras CLIs de IA), mantida fora deste arquivo para nao prender o padrao geral a uma ferramenta so.
