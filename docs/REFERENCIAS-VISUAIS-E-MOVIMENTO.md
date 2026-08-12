# Referencias Visuais, Movimento e 3D

Este documento mantem uma curadoria de referencias externas para interfaces de
marca, landing pages, componentes animados e experiencias 3D. Ele serve como
ponto de pesquisa antes de desenhar uma nova experiencia visual Doktor.

As referencias orientam comportamento, composicao e qualidade de interacao.
Elas nao autorizam copiar identidade, codigo, assets ou componentes comerciais.

## Catalogo oficial

| Referencia | Categoria | O que observar | Quando consultar |
|------------|-----------|----------------|------------------|
| [OriginKit](https://www.originkit.dev/) | Componentes animados | Reveals, transicoes, composicao de landing page e componentes com movimento | Ao buscar uma interacao de marca pronta para ser reinterpretada no projeto |
| [Skiper UI](https://skiper-ui.com/) | Componentes experimentais para shadcn/ui | Image reveal, drag, scroll, cursor trail, dynamic island e microinteracoes | Ao desenhar uma interacao incomum sem perder clareza de uso |
| [Cult UI](https://www.cult-ui.com/) | Componentes, efeitos e blocos | Cards com estados ricos, efeitos visuais, secoes de marketing e composicoes experimentais | Ao pesquisar padroes abertos ou referencias premium para landing pages |
| [GSAP](https://gsap.com/) | Motor de animacao | Timeline, scroll narrativo, SVG, texto, UI e coordenacao de sequencias | Quando a experiencia exige coreografia precisa ou varias animacoes sincronizadas |
| [Motion](https://motion.dev/) | Animacao para JavaScript e frameworks | Gestos, layout animation, scroll-linked motion e transforms independentes | Quando o projeto precisa de animacao declarativa, leve e integrada a componentes |
| [Three.js](https://threejs.org/) | 3D/WebGL | Cena, camera, luz, materiais, geometria, shaders e interacao espacial | Quando o 3D comunica o produto e existe orcamento de performance para sustenta-lo |

## Como escolher

| Necessidade | Ponto de partida |
|------------|------------------|
| Descobrir componentes e acabamentos visuais | OriginKit, Skiper UI e Cult UI |
| Coordenar uma narrativa complexa de scroll | GSAP |
| Animar componentes, gestos e mudancas de layout | Motion |
| Criar cena, objeto ou ambiente 3D real | Three.js |
| Misturar componentes com uma cena de marca | Comece pelo componente e adicione GSAP, Motion ou Three.js somente onde houver ganho claro |

## Regras de adocao

1. **Reinterpretar, nao clonar.** Extraia o principio da interacao e adapte-o aos
   tokens, conteudo e identidade do projeto.
2. **Confirmar licenca e plano.** Uma vitrine pode misturar conteudo aberto,
   gratuito e premium. Verifique a licenca do item especifico antes de copiar
   codigo ou asset.
3. **Usar documentacao oficial.** Confirme API, versao, instalacao e suporte no
   site oficial antes de implementar.
4. **Aplicar progressive enhancement.** O conteudo principal deve continuar
   acessivel se WebGL, animacao ou JavaScript falhar.
5. **Respeitar movimento reduzido.** Toda animacao nao essencial deve responder
   a `prefers-reduced-motion` e ter estado final legivel sem transicao.
6. **Definir orcamento visual.** Meca custo de JavaScript, GPU, imagens e fontes.
   Nao combine varias bibliotecas de animacao sem uma justificativa objetiva.
7. **Movimento deve explicar algo.** Use animacao para hierarquia, continuidade,
   causalidade, feedback ou narrativa. Se ela so disputa atencao, remova.

## Criterio de pronto

- A referencia escolhida e a finalidade da interacao foram registradas.
- A implementacao usa identidade e conteudo proprios.
- Licenca e versao foram verificadas na fonte oficial.
- Teclado, foco, contraste e movimento reduzido foram testados.
- A pagina continua utilizavel sem a camada visual avancada.
- Performance foi observada em desktop e em viewport movel realista.

Ultima revisao desta curadoria: 2026-08-12.
