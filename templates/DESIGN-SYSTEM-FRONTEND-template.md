# Design System Frontend do Projeto

> Copie e adapte este arquivo quando um produto tiver varias telas, estados ou componentes compartilhados. Para uma pagina simples, mantenha as decisoes no escopo da tarefa e remova este documento se ele nao reduzir retrabalho.

## 1. Contexto do produto

- Nome do produto:
- Responsavel pelo conteudo e pelas decisoes de UI:
- Usuarios principais:
- Tarefas principais:
- Frequencia e ambiente de uso:
- Dispositivos, navegadores e conectividade relevantes:
- Necessidades de acessibilidade conhecidas:
- Restricoes de marca, tecnologia, custo, prazo ou regulacao:

### O que significa uma boa experiencia aqui

- A pessoa consegue:
- A acao principal e:
- As informacoes que precisam estar sempre visiveis sao:
- Riscos de erro ou perda de dados:
- Sinais que indicam que a interface esta funcionando:

## 2. Mapa de telas e fluxos

| Tela/rota | Usuario e tarefa | Dados principais | Acoes | Acesso/permissao | Prioridade |
|---|---|---|---|---|---|
| | | | | | |

Registre os fluxos que atravessam mais de uma tela:

- Entrada e autenticacao:
- Primeira utilizacao:
- Tarefa mais frequente:
- Recuperacao de erro ou dado perdido:
- Encerramento, pagamento ou acao destrutiva:

## 3. Direcao visual

Descreva a personalidade visual em termos de hierarquia, composicao e uso. Nao escolha efeitos, paleta ou biblioteca antes de relaciona-los ao produto.

- Personalidade e tom:
- Hierarquia entre titulo, texto, dado e acao:
- Densidade de informacao:
- Tipografia e largura de leitura:
- Tratamento de superficie, borda e elevacao:
- Papel de cor e imagem:
- Movimento: onde orienta, confirma ou narra:
- O que deve permanecer simples ou sem decoracao:

### Registro de referencias

Para cada referencia importante, documente o que foi observado e o que sera adaptado. Nao copie marca, texto, codigo ou asset sem direito de uso.

| Fonte e data | Tela, viewport e estado observados | Principio reutilizavel | Adaptacao para este produto | Limites, licenca ou duvidas |
|---|---|---|---|---|
| | | | | |

Se uma captura ou interacao nao foi observada, registre essa limitacao. Separe evidencias do site, conclusoes derivadas do codigo e inferencias visuais.

## 4. Fundacoes e tokens

Defina nomes semanticos para funcao. Registre valores depois de conhecer a marca, conteudo, contraste e temas do produto.

| Categoria | Token/decisao | Valor do projeto | Uso e excecoes |
|---|---|---|---|
| Texto | text-primary, text-muted | | |
| Superficie | surface, surface-raised | | |
| Borda | border, border-strong | | |
| Acao | action, action-hover | | |
| Estado | success, warning, danger, info | | |
| Foco | focus-ring | | |
| Tipografia | display, heading, body, label, data | | |
| Espacamento | escala e densidade | | |
| Forma | radius, stroke, elevacao | | |
| Movimento | duracao, curva, reducao | | |

Temas e modos necessarios:

- [ ] Claro
- [ ] Escuro
- [ ] Alto contraste
- [ ] Densidade compacta
- [ ] Outro:

Verifique contraste e foco com os valores reais. Cor nao e o unico meio de comunicar erro, selecao ou status.

## 5. Layout responsivo

Escolha pontos de reorganizacao quando o conteudo ou os controles deixarem de caber. Os intervalos abaixo sao referencias de teste, nao breakpoints obrigatorios.

| Contexto | Larguras usadas na revisao | Layout e prioridades | Navegacao | Excecoes |
|---|---|---|---|---|
| Estreito | | | | |
| Intermediario | | | | |
| Amplo | | | | |

Decisoes que afetam mais de uma tela:

- Navegacao em tela estreita:
- Sidebar, drawer ou menu:
- Tabelas e dados densos:
- Formularios longos:
- Dialogs, drawers e bottom sheets:
- Imagens, videos e recortes:
- Zoom, orientacao e conteudo longo:

Nao dependa de hover, arrastar ou orientacao especifica como unico meio de operacao. Preserve o acesso a acoes essenciais.

## 6. Contratos dos componentes

Crie ou compartilhe um componente quando comportamento, significado ou variacao real justificar a fronteira. Evite transformar cada elemento em componente e evite um componente universal com muitas flags.

| Componente | Responsabilidade | Variantes | Estados | Teclado/foco | Quando usar |
|---|---|---|---|---|---|
| Button | | | | | |
| Field / form | | | | | |
| Menu / navigation | | | | | |
| Dialog / confirmation | | | | | |
| Table / collection | | | | | |
| Toast / feedback | | | | | |
| Outro | | | | | |

Documente os estados relevantes para cada fluxo:

- Inicial e carregando:
- Vazio e sem resultado:
- Erro recuperavel e proxima acao:
- Sucesso e confirmacao:
- Sem permissao:
- Desabilitado, selecionado e em envio:

## 7. Login, organizacoes e permissoes

Preencha apenas se o produto tiver sessao ou conteudo protegido.

- Metodos de entrada realmente habilitados:
- Rotas publicas e protegidas:
- Destinos de retorno permitidos:
- Sessao e expiracao:
- Papeis globais:
- Papeis dentro da organizacao:
- Permissoes por recurso/operacao:
- Recuperacao, verificacao e encerramento de sessao:
- Estados de erro sem expor segredo ou dado sensivel:

Regras do projeto:

- A autorizacao acontece no servidor para cada recurso e operacao:
- A UI esconde apenas acoes que a pessoa nao pode iniciar; isso nao substitui autorizacao:
- Senhas, tokens e segredos nao voltam em estado de formulario, URL, log ou telemetria:
- O menu mostra o contexto ativo de organizacao/conta:

## 8. Arquitetura e estado de interface

- Convencao de rotas e grupos:
- Fronteira entre pagina, feature, dominio e componentes compartilhados:
- Onde ficam acesso a dados, validacao e regras de negocio:
- Estado local e estado compartilhado:
- Filtros, busca, ordenacao e pagina no URL quando isso ajudar retorno/compartilhamento:
- Estados que dependem de servidor:
- Estrategia para loading, erro, vazio e atualizacao:
- Comportamento em falha de rede ou envio repetido:

Para listas, registre quando processar no cliente e quando no servidor, limite esperado e estrategia de paginacao. Em tela estreita, defina colunas essenciais, detalhe por item, lista alternativa ou rolagem indicada.

## 9. Acessibilidade e performance

Alvo de acessibilidade e requisitos aplicaveis:

- Uso por teclado e ordem de foco:
- Nome acessivel e labels:
- Foco visivel e nao encoberto:
- Contraste de texto, controles e estados:
- Zoom e reflow:
- Leitor de tela e atualizacoes dinamicas:
- Movimento reduzido:
- Alvos de toque:

Orcamento e medicao de performance:

- Fluxos e paginas prioritarios:
- Metricas de campo/laboratorio que serao acompanhadas:
- Limites de imagem, fonte, JavaScript e GPU escolhidos para o produto:
- Dispositivos e rede usados para medir:
- Responsavel por acompanhar regressao:

Defina os limites a partir do produto e da referencia atual em [Design System Performance](../core/DESIGN_SYSTEM_PERFORMANCE.md). Nao trate um numero sem contexto como meta universal.

## 10. Matriz de validacao

| Fluxo/tela | Estreito | Intermediario | Amplo | Teclado | Zoom | Movimento reduzido | Estados de falha |
|---|---|---|---|---|---|---|---|
| Entrada/autenticacao | | | | | | | |
| Navegacao principal | | | | | | | |
| Tarefa principal | | | | | | | |
| Formulario/dados | | | | | | | |

Registre evidencias reais: dispositivo ou viewport, rota, estado, data, resultado e o que nao foi verificado. Captura de tela documenta aparencia em um instante; nao substitui teste de teclado, foco, leitor de tela ou fluxo.

## 11. Decisoes e manutencao

| Data | Decisao | Motivo e alternativas | Custo/risco | Reavaliar quando |
|---|---|---|---|---|
| | | | | |

- Ultima revisao:
- Mudancas de marca, produto ou acessibilidade que exigem nova revisao:
- Componentes ou regras que devem ser removidos se deixarem de ser usados:
- Documentos tecnicos relacionados:

## Criterio de pronto

- [ ] Tarefas, telas, usuarios e permissoes estao descritos.
- [ ] A direcao visual deriva do produto e das referencias analisadas.
- [ ] Tokens semanticos e regras responsivas estao ligados a usos reais.
- [ ] Componentes documentados tem responsabilidade, estados e comportamento de teclado.
- [ ] Login, menus, dialogs, tabelas e falhas foram definidos quando aplicaveis.
- [ ] Acessibilidade e performance tem evidencias e criterios pertinentes ao produto.
- [ ] Decisoes e limitacoes podem ser entendidas por quem iniciar o proximo projeto.
