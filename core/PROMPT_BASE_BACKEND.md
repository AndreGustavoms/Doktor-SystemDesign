# Prompt Base Backend

Use este modelo para planejar, construir ou revisar um backend. Adapte-o ao projeto e ao risco; nao imponha camadas ou tecnologias sem justificativa.

Antes de comecar, siga as instrucoes do AGENTS.md do projeto, leia o resumo vivo de IA.md se existir e abra apenas os guias que correspondem ao escopo.

## Prompt curto

~~~text
Atue como pessoa desenvolvedora backend neste projeto.

Objetivo:
[resultado observavel que o backend deve entregar]

Contexto:
[stack atual, dados, usuarios, deploy, integracoes, restricoes]

Contratos:
[entradas, saidas, permissoes, erros, compatibilidade]

Requisitos:
- [regra de negocio]
- [persistencia ou integracao]
- [seguranca, latencia e volume relevantes]

Forma de trabalhar:
- preserve a stack e contratos existentes quando atendem ao requisito;
- separe fronteiras quando isso reduzir acoplamento ou risco real;
- valide entradas e autorizacao em toda fronteira de confianca;
- trate transacoes, repeticao e falha parcial conforme o efeito da operacao;
- confirme APIs e dependencias na documentacao da versao instalada;
- execute verificacoes proporcionais ao risco e reporte saida real;
- atualize documentacao, comandos e contexto operacional afetados.

Criterio de pronto:
[comportamento, contrato e verificacao esperada]
~~~

## Prompt completo

~~~text
Quero trabalhar no backend deste projeto seguindo o AGENTS.md e o design system aplicavel.

Objetivo e fluxo de negocio:
[explique o valor e o comportamento esperado]

Atores e permissoes:
[usuarios, papeis, recursos, operacoes e ownership]

Estado atual:
- stack e comandos:
- modelos e migrations:
- contratos de API/eventos:
- integracoes:
- observabilidade:
- testes e CI:

Requisitos funcionais:
- [casos de uso]
- [erros e estados parciais]
- [compatibilidade com consumidores existentes]

Requisitos nao funcionais:
- latencia/volume/disponibilidade:
- privacidade e seguranca:
- deploy, custo e operacao:
- limites conhecidos:

Restricoes:
- manter:
- alterar:
- fora do escopo:
- dependencias autorizadas:

Criterios de arquitetura:
- escolha a menor estrutura que preserve fronteiras importantes;
- nao adicione servico, fila, cache ou camada sem requisito concreto;
- mantenha contratos pequenos, erros previsiveis e logs sem dados sensiveis;
- registre trade-offs caros de reverter.

Validacao:
- identifique testes, linters, build ou verificacoes relevantes;
- reporte comandos executados e saidas reais;
- registre verificacao manual e limites nao automatizados.

Entregue:
- mudanca e documentacao afetada;
- decisao tecnica e alternativas quando relevantes;
- evidencia de validacao e riscos residuais.
~~~

## Roteiro de leitura

Comece por [Guia Minimo](GUIA_MINIMO_QUALIDADE.md) e [Design System Backend](DESIGN_SYSTEM_BACKEND.md). Abra [API REST](DESIGN_SYSTEM_API_REST.md), [Seguranca](DESIGN_SYSTEM_SEGURANCA.md), [Testes](DESIGN_SYSTEM_TESTES.md), [Performance](DESIGN_SYSTEM_PERFORMANCE.md) e Stack somente quando o escopo exigir.