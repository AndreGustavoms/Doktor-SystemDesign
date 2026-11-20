# Design System Performance

> Performance e parte da experiencia e do custo operacional. Este guia ajuda a definir o que medir, onde investir e como evitar otimizacoes prematuras.

## 1. Defina o resultado que precisa ser rapido

Comece pelas tarefas e operacoes mais importantes para a pessoa usuaria e para a operacao. Registre:

- a acao ou pagina critica;
- o contexto de rede, dispositivo e volume esperado;
- o tempo e a variabilidade aceitaveis;
- a metrica, ferramenta e ambiente de verificacao;
- a linha de base e a condicao para revisar o resultado.

Escolha orcamentos praticos de carregamento, interacao, tamanho de ativos, latencia, consultas ou recursos conforme o produto. Um numero e um limite de trabalho, nao uma promessa universal. Reavalie-o com dados de uso.

## 2. Web: medir experiencia real

Use Core Web Vitals como referencias de experiencia. No navegador, os limites considerados bons hoje sao:

| Metrica | O que observa | Alvo bom |
|---|---|---|
| LCP | Carregamento do conteudo principal | <= 2.5 s |
| INP | Resposta a interacoes | <= 200 ms |
| CLS | Estabilidade visual | <= 0.1 |

Avalie o percentil 75 e segmente por mobile e desktop quando houver dados suficientes. Testes de laboratorio ajudam a localizar problemas; dados de campo mostram a experiencia real. Nao trate um score isolado de auditoria como medida completa do produto.

## 3. Interface e ativos

- Reduza JavaScript enviado por rota; adicione dependencia quando o ganho justificar o peso e a manutencao.
- Otimize imagens com dimensoes, formato e variantes adequadas a tela; nao carregue imagem desktop enorme em viewport estreito.
- Reserve espaco para imagens, anuncios ou conteudo que chega depois para evitar deslocamento.
- Carregue sob demanda apenas conteudo fora do caminho inicial quando isso reduzir trabalho sem piorar a descoberta.
- Use cache com invalidacao e atualizacao previsiveis.
- Evite recalculo e renderizacao repetidos medindo primeiro; considere paginacao ou virtualizacao quando volume e interacao pedirem.
- Proteja a interacao principal contra tarefas longas e scripts de terceiros sem limite.
- Nao remova feedback, semantica ou animacoes essenciais para perseguir um score.

## 4. Backend e dados

Meca latencia, erros, throughput e consumo de recursos nas operacoes relevantes. Para servicos com metas operacionais, defina SLI/SLO e budgets de erro de acordo com o produto.

- Analise queries e planos antes de criar indices ou caches.
- Procure N+1, consultas sem limite e payloads maiores que o necessario.
- Pagine colecoes grandes e limite entrada, tamanho e custo de operacoes.
- Configure timeouts em chamadas externas; use retry com backoff somente quando a falha for transitoria e a operacao puder ser repetida com seguranca.
- Use fila para trabalho demorado ou desacoplado quando ela melhorar o fluxo; considere custo de observacao, retentativa e idempotencia.
- Adicione cache para reduzir um gargalo medido, com regra de expiracao e invalidacao conhecida.
- Observe p50 e p95 (ou percentis mais altos quando a cauda for importante) junto com taxa de erro.

## 5. Como otimizar

Siga um ciclo curto:

1. Reproduza o caminho e capture uma linha de base.
2. Identifique o gargalo com profiler, trace, waterfall ou plano de query.
3. Escolha uma mudanca que ataque esse gargalo.
4. Compare antes e depois no mesmo contexto.
5. Confira regressao de funcionalidade, acessibilidade, estabilidade e custo.
6. Registre a decisao se afetar arquitetura ou operacao.

Nao otimize caminho frio sem impacto percebido. Nao adicione cache, worker, CDN, virtualizacao ou framework so por receio de escala futura.

## Checklist de performance

- [ ] Os caminhos criticos e o contexto de uso estao identificados.
- [ ] Ha uma linha de base ou uma explicacao para ainda nao medir.
- [ ] Os orcamentos sao ligados a tarefas e podem ser avaliados.
- [ ] Web Vitals sao medidos em dados de campo e laboratorio quando aplicavel.
- [ ] Ativos, scripts, rede, consultas e limites de dados foram considerados.
- [ ] Timeouts, retries, cache e fila tem politica e comportamento de falha.
- [ ] Mudancas foram comparadas antes e depois no mesmo contexto.
- [ ] A otimizacao manteve acessibilidade, previsibilidade e facilidade de operacao.

## Referencias

- [Web Vitals](https://web.dev/articles/vitals)
- [Como os limites de Core Web Vitals foram definidos](https://web.dev/articles/defining-core-web-vitals-thresholds)