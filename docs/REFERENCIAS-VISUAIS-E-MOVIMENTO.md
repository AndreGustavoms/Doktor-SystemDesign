# Referencias Visuais e Movimento

> Repertorio externo para estudar principios e interacoes. Estas fontes nao sao um tema visual obrigatorio nem substituem pesquisa com as pessoas que usarao o produto.

## 1. Fontes para estudar sistemas e padroes

| Fonte | Melhor uso |
|---|---|
| [Material Design 3](https://m3.material.io/) | Tokens, componentes, temas e comportamento multiplataforma. |
| [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/) | Layout adaptavel, comportamento e convencoes das plataformas Apple. |
| [GOV.UK Design System](https://design-system.service.gov.uk/) | Componentes e padroes de servico, formularios e mensagens de erro com orientacao de uso. |
| [W3C WCAG 2.2](https://www.w3.org/TR/WCAG22/) | Criterios de acessibilidade; use em conjunto com as referencias oficiais de apoio. |

Sistemas publicados resolvem necessidades e usuarios especificos. Compare o contexto antes de transportar um padrao.

## 2. Repertorio de interacao e acabamento

| Fonte | O que observar |
|---|---|
| [Origin UI](https://originui.com/) | Componentes e detalhes de interface para inspirar uma implementacao adaptada. |
| [Skiper UI](https://skiper-ui.com/) | Interacoes de scroll, gestos e componentes experimentais. |
| [Cult UI](https://www.cult-ui.com/) | Composicoes de marketing e efeitos de interface. |
| [GSAP](https://gsap.com/) | Coreografia com timelines, scroll e SVG. |
| [Motion](https://motion.dev/) | Gestos e transicoes declarativas em interfaces. |
| [Three.js](https://threejs.org/) | Cena 3D quando profundidade e objeto espacial ajudam a explicar o produto. |

As bibliotecas e galerias mudam. Confira a pagina original, a API atual, suporte, custo e licenca do exemplo especifico antes de adotar ou copiar codigo.

## 3. Roteiro para revisar uma referencia

Para cada URL, imagem, video ou audio recebido:

1. Abra a fonte original e registre titulo, URL, data e contexto do produto.
2. Explore a experiencia nos estados e tamanhos relevantes, em vez de julgar apenas a primeira dobra.
3. Observe hierarquia, alinhamento, tipografia, espaco, cor, componentes e comportamento.
4. Capture evidencia visual com origem, viewport e estado identificados. Nao use a captura como substituto da analise.
5. Para video ou audio, assista ou escute o material quando a ferramenta permitir; se nao permitir, registre a limitacao e procure transcricao ou material alternativo.
6. Separe o que e principio reutilizavel do que depende da marca, plataforma, conteudo ou licenca.
7. Avalie teclado, foco, contraste, movimento reduzido, telas estreitas e custo de carregamento.
8. Converta os achados em tokens, componentes ou criterios do projeto. Justifique o que sera adaptado ou descartado.

## 4. Regras de uso

- Reinterprete o principio; nao clone layout, marca, copy, asset ou codigo sem direito de uso.
- Confirme termos e licenca no item exato, especialmente em exemplos premium.
- Mantenha conteudo e controles utilizaveis sem WebGL, animacao ou JavaScript decorativo.
- Use movimento para hierarquia, continuidade, feedback ou narrativa. Respeite `prefers-reduced-motion`.
- Defina um orcamento para imagens, fontes, JavaScript e GPU antes de empilhar efeitos.
- Nao adote mais de uma biblioteca de movimento sem motivo medido.
- Prefira uma referencia que esclarece a necessidade atual a uma colecao longa de efeitos.

## 5. Registro curto de referencia

~~~text
Fonte e data:
Produto e contexto:
Elemento ou comportamento observado:
Principio que pode ser reutilizado:
Adaptacao proposta:
Acessibilidade e responsividade:
Licenca e custo:
Impacto esperado em performance:
Evidencia ou limitacao da revisao:
~~~

## Referencias tecnicas relacionadas

Veja [Referencias Tecnicas](REFERENCIAS-TECNICAS.md) para acessibilidade, responsividade, seguranca, HTTP e performance web.

## Estudos de caso analisados

O [Estudo de Referencias Frontend](ESTUDO-REFERENCIAS-FRONTEND.md) detalha Jorge Web Pro, Lando Norris e repositorios SaaS publicos. Inclui estrutura, login, menus, dialogs, tabelas, responsividade inferida, riscos e limites da revisao. Use-o para comparar decisoes concretas; retome a fonte original antes de implementar, porque sites e repositorios mudam.
