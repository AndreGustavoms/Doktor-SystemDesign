# Design System Frontend

Este guia orienta a criacao de interfaces claras, distintas, responsivas, acessiveis e rapidas. Ele define criterios de qualidade; nao exige uma stack, paleta ou estilo unico.

Consulte [Stack e Arquitetura](../docs/STACK-E-ARQUITETURA.md) para escolhas tecnicas, [Referencias Tecnicas](../docs/REFERENCIAS-TECNICAS.md) para fontes normativas e [Referencias Visuais e Movimento](../docs/REFERENCIAS-VISUAIS-E-MOVIMENTO.md) para repertorio visual.

## 1. Resultado esperado

Uma boa interface ajuda a pessoa a concluir sua tarefa sem atrito e transmite a identidade do produto com consistencia. Ela deve continuar compreensivel em telas diferentes, com teclado, zoom, conteudo real, falhas de rede e preferencias de acessibilidade.

Defina antes de desenhar:

- quem usa e qual tarefa principal quer concluir;
- o contexto de uso (frequencia, dispositivo, ambiente, conectividade);
- quais dados, estados e erros aparecem;
- o que a tela deve priorizar;
- quais restricoes de marca, tecnologia e conteudo existem.

## 2. Direcao visual

A aparencia deve parecer feita para o produto, nao montada a partir de uma galeria generica. Escolha uma direcao visual deliberada e registre-a em linguagem simples:

- personalidade e tom visual;
- hierarquia de titulo, texto, dado e acao;
- densidade adequada ao trabalho;
- composicao, alinhamento, ritmo e espaco em branco;
- tipografia, formas, superficies e nivel de contraste;
- uso de cor, imagem, ilustracao, iconografia e movimento.

A beleza vem de hierarquia, proporcao, detalhe e coerencia. Evite aplicar a mesma grade de cards, hero, gradiente, vidro fosco ou sombra em todo produto. Use cada efeito para reforcar uma ideia ou estado. Mantenha o conteudo e a acao principal mais evidentes que a decoracao.

### Modo de uso da tela

Use a densidade e o contexto, nao uma regra por tempo de uso, para escolher o tratamento:

- **Operacional**: leitura rapida, dados densos, filtros e tarefas repetidas. Priorize legibilidade, alinhamento, estados e baixa distracao.
- **Editorial ou marca**: descoberta, narrativa, catalogo e apresentacao. Pode explorar composicao, tipografia e movimento, desde que a navegacao e as tarefas continuem claras.

Uma mesma aplicacao pode combinar os dois modos, mantendo tokens e componentes coerentes.

## 3. Sistema visual

Crie um conjunto pequeno de tokens semanticos e reutilize-o. O nome descreve o papel, nao a aparencia: `text-primary`, `surface`, `border`, `action`, `status-danger`. Isso permite temas e ajustes sem perseguir valores soltos.

Quando houver variacoes de tema, marca ou plataforma, mantenha as camadas claras:

- **Primitivos** guardam valores de base, como `blue-600`, `space-4` ou `radius-md`.
- **Semanticos** ligam valores a funcao, como `text-primary`, `surface-raised` ou `action-primary`. Estes sao a interface normal que os componentes consomem.
- **De componente** existem somente para uma necessidade repetida ou variacao estavel, como `dialog-shadow`; nao replique a escala sem motivo.

Um projeto simples pode usar apenas propriedades customizadas CSS. Se varios produtos, marcas ou ferramentas precisarem trocar tokens, escolha uma fonte de verdade e avalie um formato de intercambio como o [Design Tokens Format 2025.10](../docs/REFERENCIAS-TECNICAS.md). A especificacao e estavel para uso, mas vem de um W3C Community Group e nao esta no W3C Standards Track; adote-a quando interoperabilidade reduzir retrabalho, nao por obrigacao.

Defina conforme o produto:

- cores de texto, superficie, borda, acao e estados;
- escala tipografica, altura de linha e largura confortavel de leitura;
- escala de espacamento e densidade;
- largura maxima de conteudo, gutters, colunas e intervalos de secao quando forem compartilhados;
- radius, borda, elevacao e foco;
- duracao e curva de movimento;
- tema claro/escuro e estados de alto contraste, se necessarios.

Cor nao pode ser o unico meio de comunicar erro, selecao ou status. Garanta contraste para texto, controles e foco. Evite gradientes decorativos sem papel semantico.

## 4. Responsividade

Projete para o conteudo e para o fluxo, nao para uma lista fixa de modelos de telefone. Mobile-first e uma boa estrategia quando a experiencia principal comeca em telas estreitas, mas nao e uma obrigacao universal.

- Prefira Grid, Flexbox, unidades relativas, limites de largura e imagens responsivas.
- Escolha breakpoints quando o conteudo ou os controles deixam de caber; use unidades relativas quando pratico.
- Use media queries para reorganizar o shell da pagina pelo viewport. Para um componente reutilizado em espacos de larguras diferentes, considere container queries; declare um container apenas onde ele for necessario e prefira consulta pela largura quando a altura nao importar.
- Use `clamp()` para escalas fluidas com limites legiveis quando isso simplificar a composicao. Para texto, nao dependa apenas de `vw`; mantenha limites relativos e valide zoom e ampliacao.
- Evite que conteudo longo force overflow: permita quebra de texto e revise larguras minimas intrinsecas em itens de Grid/Flexbox.
- Reorganize a prioridade dos dados e a navegacao em telas estreitas; nao apenas reduza tudo.
- Para tabelas densas, escolha conscientemente colunas prioritarias, detalhe por linha ou rolagem horizontal claramente indicada.
- Evite largura e altura fixas para conteudo que pode crescer. Reserve proporcoes quando isso evita salto de layout.
- Teste larguras estreitas, intermediarias e amplas, conteudo longo, zoom e orientacao. Um layout responsivo nao deve depender de um unico breakpoint.
- Preserve operacoes por teclado e toque. Para web, use WCAG 2.2 AA como alvo de projeto quando apropriado; os criterios sobre tamanho de alvo, reflow e foco tem excecoes e devem ser lidos no contexto.

Nao esconda acao essencial no mobile nem exija gesto de arrastar como unico meio de operacao.

## 5. Acessibilidade como requisito de interface

Para interfaces web, use HTML semantico e os controles nativos quando atendem ao comportamento. Mire WCAG 2.2 nivel AA, salvo requisito contratual ou regulatorio diferente. Nao declare conformidade sem avaliar as paginas completas e seus estados.

Para widgets compostos que precisem de interacao ARIA personalizada, consulte os padroes WAI-ARIA APG listados em [Referencias Tecnicas](../docs/REFERENCIAS-TECNICAS.md). Use o padrao de menu para menus de acoes; uma lista de navegacao comum nao precisa virar um widget ARIA de menu.

Verifique:

- uso por teclado, ordem de foco logica e foco visivel que nao fique coberto;
- nomes acessiveis, labels persistentes, instrucoes e erros ligados aos campos;
- contraste de texto, controles, estados e foco;
- zoom e reflow sem perda de conteudo ou funcao;
- alvos de toque com tamanho e espacamento confortaveis;
- alternativas textuais, legendas ou transcricoes quando aplicavel;
- anuncios acessiveis para atualizacoes importantes sem mover foco indevidamente;
- preferencias de contraste, tema e movimento quando suportadas.

Use `prefers-reduced-motion` para remover ou substituir movimento nao essencial. Movimento nunca deve ser necessario para entender o estado. A automacao de acessibilidade ajuda, mas nao substitui teclado e inspecao manual.

## 6. Componentes e composicao

Crie componentes quando houver comportamento, significado ou variacao que mereca uma fronteira reutilizavel. Extraia componentes por coesao e repeticao real; nao transforme cada elemento HTML em uma camada de abstracao.

Cada componente reutilizavel deve ter:

- um papel e nome claros;
- uma API pequena, com variantes intencionais;
- comportamento semantico e teclado esperado;
- estados definidos;
- estilos alinhados aos tokens;
- limites de responsabilidade conhecidos.

Componha componentes simples antes de criar um componente universal com muitas flags. Mantenha conteudo, dominio, acesso a dados e apresentacao separados na medida que facilite mudancas independentes. Siga as convencoes do framework existente.

Elementos comuns como botoes, campos, selecao, dialogo, notificacao e lista devem ser consistentes quando aparecerem. Nao crie um kit completo antes de saber quais elementos o produto usa. Para exemplos portaveis, consulte [Componentes UI Compostos](../guias/frontend/GUIA-COMPONENTES-UI-COMPOSTOS.md).

## 7. Estados e fluxos

Pense no ciclo completo, nao apenas no estado ideal:

- inicial e carregando;
- vazio e sem resultado;
- dados parciais ou desatualizados;
- erro com proximo passo;
- sucesso e confirmacao;
- sem permissao;
- selecionado, ativo, desabilitado e em envio.

Evite skeletons que imitam conteudo sem necessidade. Preserve dados do formulario quando um envio falhar. Erros devem aparecer junto ao contexto e explicar como corrigir. Evite duplo envio em operacoes que criam ou pagam algo.

## 8. Formularios, navegacao e dados

- Todo campo tem label e instrucoes necessarias; placeholder e apenas exemplo.
- Valide no momento adequado e apresente erros especificos sem apagar entrada valida.
- Use navegacao que combine com a tarefa: cabecalho, abas, trilha, painel ou etapas.
- Para listas, torne busca, filtro, ordenacao e contagem descobriveis quando forem uteis.
- Use tabela quando a comparacao tabular importar; escolha lista ou cartoes quando isso facilitar leitura e toque.
- Nao esconda acoes essenciais atras de hover. Garanta estado de foco equivalente.

Consulte guias opcionais apenas quando o fluxo pedir uma tabela, formulario complexo, calendario ou outro padrao especifico.

### Autenticacao, menus e dialogs

Quando o produto tiver sessao, organizacoes, menus ou dialogs, trate o comportamento como parte do contrato da interface:

- Diferencie tela demonstrativa de autenticacao real. Valide credenciais no servidor, verifique a sessao e autorize cada recurso no servidor; esconder um link nao e controle de acesso.
- Valide destinos de retorno com caminhos locais seguros ou uma allowlist. Nunca devolva senha em estado de acao, resposta, URL, log ou telemetria.
- Exponha apenas os metodos de login configurados. Cubra envio, erro, sucesso, verificacao, recuperacao, sessao expirada e redirecionamento.
- Use labels persistentes, autocomplete adequado, erros ligados ao campo e estados de envio que evitem duplicacao sem apagar a entrada.
- Menus com icone precisam de nome acessivel e estado compreensivel. Controles que abrem paineis devem comunicar estado e relacao com o conteudo; teclado, toque, Escape e foco devem ter comportamento definido.
- Em aplicacoes com organizacoes, mostre qual contexto esta ativo e trate papel da plataforma, papel de membro e permissao por recurso como dimensoes distintas.
- Dialogs precisam de titulo associado, foco inicial intencional, foco contido quando modais, fechamento previsivel e restauracao do foco. Confirmacoes destrutivas descrevem o alvo e a consequencia.
- Durante uma mutacao, mostre pendencia, previna envio duplicado, preserve os campos e comunique erro ou sucesso. Feche o dialogo e atualize dados no momento correto do fluxo.
- Em telas estreitas, escolha entre dialogo, drawer ou bottom sheet pela tarefa. O padrao precisa continuar operavel com teclado, leitor de tela e rolagem ampliada.

Para exemplos e alertas extraidos de repositorios publicos, consulte [Estudo de Referencias Frontend](../docs/ESTUDO-REFERENCIAS-FRONTEND.md). Essas referencias sao estudos de caso, nao implementacoes garantidas como seguras ou acessiveis.

## 9. Movimento e acabamento

Movimento serve para feedback, continuidade, orientacao ou narrativa. Prefira transicoes curtas e previsiveis para ferramentas; reserve coreografia mais rica para momentos em que ela agrega significado. Evite loops constantes, parallax excessivo, cursor customizado que substitui controles e efeitos que aumentam custo sem esclarecer a interface.

Comece com a pagina utilizavel sem a camada decorativa. Confira teclado, foco, movimento reduzido e desempenho antes de adotar bibliotecas ou efeitos de cena.

## 10. Validacao de UI

Valide com conteudo real e estados relevantes. Combine ferramentas automatizadas com observacao manual:

- telas estreitas, intermediarias e amplas;
- teclado, foco e ampliacao de texto;
- loading, vazio, erro, sucesso e permissao;
- textos longos, numeros extremos e nomes grandes;
- tema e movimento reduzido quando suportados;
- navegador e dispositivos representativos do publico.

Nao afirme que a interface foi vista ou testada se nao foi. Registre o que foi observado e o que permanece sem verificacao. Avalie performance conforme [Design System Performance](DESIGN_SYSTEM_PERFORMANCE.md).

## Checklist frontend

- [ ] A tarefa principal e a hierarquia visual estao claras.
- [ ] A direcao visual combina com o produto e nao depende de decoracao generica.
- [ ] Layout, conteudo e controles se adaptam a larguras e zoom diferentes.
- [ ] Semantica, teclado, foco, contraste, labels e erros foram considerados.
- [ ] Componentes e tokens foram extraidos onde reduzem duplicacao ou variacao acidental.
- [ ] Estados de carregamento, vazio, erro, sucesso e permissao foram tratados quando aplicaveis.
- [ ] Login, menus, dialogs, redirecionamentos e permissoes cobrem teclado, foco e estados reais quando aplicaveis.
- [ ] Movimento tem funcao e respeita a preferencia de reducao.
- [ ] Performance e comportamento em navegadores/dispositivos relevantes foram considerados.
- [ ] Documentacao e validacao refletem o que foi de fato executado.
