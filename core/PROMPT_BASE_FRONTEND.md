# Prompt Base Frontend

Use este modelo para planejar, construir ou revisar uma interface. Adapte-o ao projeto; remova campos sem relacao com a tarefa.

Antes de comecar, siga as instrucoes do AGENTS.md do projeto, leia o resumo vivo de IA.md se existir e abra apenas os guias que correspondem ao escopo.

## Prompt curto

~~~text
Atue como pessoa desenvolvedora frontend neste projeto.

Objetivo:
[fluxo, tela ou problema que precisa resolver]

Quem usa e contexto:
[publico, tarefa, dispositivo, frequencia, ambiente]

Estado atual:
[stack, componentes, rotas, API, restricoes]

Requisitos:
- [comportamentos e conteudo]
- [estados de carregamento, vazio, erro, sucesso]
- [responsividade, acessibilidade e navegadores relevantes]
- [direcao visual e referencias, se existirem]

Preserve:
[contratos, convencoes e comportamento que nao devem mudar]

Forma de trabalhar:
- siga a arquitetura existente e escolha o menor conjunto de componentes necessario;
- defina hierarquia e tokens visuais a partir do produto, sem assumir paleta ou framework;
- adapte o layout ao conteudo e aos tamanhos de tela; verifique teclado, foco e zoom;
- confirme APIs e dependencias na documentacao da versao instalada;
- execute apenas as verificacoes relevantes e informe a saida observada;
- nao diga que viu ou testou a interface sem evidencia;
- atualize a documentacao afetada.

Criterio de pronto:
[resultado observavel, comportamento, limites ou validacao]
~~~

## Prompt completo

~~~text
Quero trabalhar no frontend deste projeto seguindo o AGENTS.md e o design system aplicavel.

Objetivo e resultado para a pessoa usuaria:
[explique o problema e a tarefa principal]

Publico e contexto:
- quem usa:
- tarefa principal:
- frequencia e ambiente:
- dispositivos e navegadores:
- necessidades de acessibilidade:

Estado atual:
- stack e comandos:
- rotas e componentes relevantes:
- dados/API:
- testes ou validacoes existentes:
- convencoes visuais:

Requisitos funcionais:
- [acoes, dados, regras, navegacao]
- [estados de loading, vazio, erro, sucesso, permissao]

Direcao visual:
- personalidade e hierarquia:
- densidade:
- tipografia, cor, superficie e movimento:
- referencias a estudar, se houver:
- o que evitar:

Restricoes e contratos:
- manter:
- alterar:
- fora do escopo:
- compatibilidade:

Criterios de qualidade:
- layout acompanha o conteudo em larguras e zoom diferentes;
- teclado, foco, labels, contraste e preferencias de movimento foram considerados;
- componentes e tokens sao extraidos quando resolvem repeticao ou variacao real;
- estados de dados e falhas sao comunicados de forma clara;
- performance e custo de ativos correspondem ao fluxo principal.

Validacao:
- liste comandos relevantes e resultados reais;
- descreva a revisao manual de UI, tamanhos de tela, teclado e estados;
- aponte o que nao pode ser verificado e o risco residual.

Entregue:
- a mudanca;
- documentacao afetada;
- resumo do que mudou e por que;
- evidencia de validacao e limites.
~~~

## Quando a tarefa cria uma base de UI compartilhada

Se o projeto tiver varias telas ou componentes compartilhados, use [Design System Frontend do Projeto](../templates/DESIGN-SYSTEM-FRONTEND-template.md) como registro enxuto das decisoes. Preencha somente as secoes que afetam o produto; nao transforme o template em um processo obrigatorio para uma pagina simples.

Quando o usuario fornecer referencias:

- examine cada fonte e registre URL, estado, viewport e data;
- diferencie observacao direta, inferencia a partir do codigo e questao ainda sem verificacao;
- capture a aparencia e teste interacoes quando o navegador estiver disponivel;
- traduza principios para o contexto do produto sem copiar marca, texto, assets ou codigo sem licenca;
- registre o que foi impossivel observar e nao afirme que houve screenshot ou teste manual sem evidencia.

## Roteiro de leitura

Leia [Design System Frontend](DESIGN_SYSTEM_FRONTEND.md), [Guia Minimo de Qualidade](GUIA_MINIMO_QUALIDADE.md) e a secao de [Stack e Arquitetura](../docs/STACK-E-ARQUITETURA.md) relacionada ao projeto. Para desempenho ou uma interacao especial, abra [Performance](DESIGN_SYSTEM_PERFORMANCE.md) ou um unico guia opcional que corresponda ao fluxo.
