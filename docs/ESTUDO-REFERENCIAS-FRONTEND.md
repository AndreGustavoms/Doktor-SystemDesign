# Estudo de Referencias Frontend

> Analise de produtos e repositorios para extrair principios de interface, interacao e arquitetura. Use como repertorio de decisoes, nao como receita visual ou garantia de qualidade do codigo estudado.

## Escopo e metodo

Revisao realizada em 2026-11-20. O objetivo foi entender a experiencia publica e, quando havia codigo aberto, conferir como login, navegacao, dialogs, tabelas, estado e organizacao de frontend foram implementados.

Fontes consultadas:

- Paginas publicas: [Jorge Web Pro](https://www.jorgewebpro.com/), [Lando Norris](https://landonorris.com/), suas paginas [On Track](https://landonorris.com/on-track), [Off Track](https://landonorris.com/off-track) e [Calendar](https://landonorris.com/calendar), alem das demonstracoes do [Tabler sign-in](https://preview.tabler.io/sign-in.html), [modals](https://preview.tabler.io/modals.html) e [data tables](https://preview.tabler.io/datatables.html).
- Codigo e documentacao publicados pelos autores: repositorios oficiais no GitHub listados nas secoes abaixo.
- No site Jorge Web Pro, tambem foram consultados HTML, CSS e JavaScript publicamente entregues pelo site, alem dos nomes e destinos dos assets encontrados no documento.

### Limites da observacao

O host do navegador integrado estava indisponivel nesta sessao. Por isso, nao foram feitas capturas de tela renderizadas, testes de viewport, cliques reais, navegacao por teclado ou auditoria de desempenho no navegador. A analise visual de Jorge e Lando separa o que foi confirmado pelo conteudo/CSS/estrutura do que e inferencia. As demonstracoes Tabler foram abertas como paginas de referencia, mas a revisao nao substitui uma auditoria manual completa.

Nenhum audio ou video foi enviado para escuta/assistencia. A rota https://www.jorgewebpro.com/estude retornou 404; a analise foi feita na pagina inicial do dominio.

As observacoes de codigo descrevem os arquivos publicos consultados na data acima. Repositorios, dependencias e sites podem mudar. Reconfirme o arquivo e a versao antes de reutilizar uma implementacao.

## Leitura executiva

As referencias cobrem tres problemas diferentes:

| Tipo | Referencias | Principio principal |
|---|---|---|
| Landing page de servico | Jorge Web Pro | Narrativa comercial que liga problema, processo, prova, resultado e CTA. |
| Marca editorial pessoal | Lando Norris | Separacao clara de mundos de conteudo dentro de uma identidade visual reconhecivel. |
| Produto SaaS e dashboard | SaaS Starter, SaaS Boilerplate, Kiranism, Open SaaS, Cal.diy, mickasmt, Tabler | Contratos de autenticacao, navegacao, tabelas, organizacoes, formularios e estados operacionais. |

Nao existe uma unica linguagem visual que sirva para os tres. O que pode ser compartilhado entre projetos e o metodo: definir tarefa e contexto, criar tokens e componentes semanticos, representar os estados reais e testar as larguras e interacoes relevantes.

## 1. Jorge Web Pro

Fonte: [jorgewebpro.com](https://www.jorgewebpro.com/).

### Estrutura e narrativa

A pagina organiza a venda de servico como uma sequencia de convencimento: hero, trabalhos, valor/percepcao, projetos selecionados, processo em seis etapas, diferenciais, beneficios/resultados, marca/sobre, FAQ, contato e rodape. Ha ancoras para essas partes, como services, work, projects, processo, resultados, faq e contact.

Essa ordem ensina uma boa pratica de landing page: nao despejar uma lista de servicos no topo. Primeiro apresenta a promessa, depois mostra evidencias, explica como a entrega acontece, responde objecoes e pede a acao. As secoes tem composicoes diferentes para manter ritmo sem perder a identidade.

### Direcao visual observada

O HTML e os estilos indicam uma direcao de marca, com hero escuro em azul marinho, blocos editoriais claros e escuros, acentos azuis, fontes personalizadas, grafismos e imagens proprias para projetos e secoes. Ha variaveis especificas por cena/secao, alem de tokens com nomes mais gerais. O layout usa valores fluidos com clamp() e possui muitos ajustes de breakpoint, incluindo variantes de arte/background para mobile, tablet, desktop e telas maiores.

Isso e util como estudo de art direction responsiva: o trabalho visual e recomposto por contexto e nao apenas encolhido. E um padrao adequado para marketing e portfolio, mas nao deve ser importado para um dashboard operacional sem motivo.

### Interacoes identificadas no codigo publico

- A navegacao desktop e uma barra tipo pill. Em tela estreita, o cabecalho oferece um botao de menu com nome acessivel, estado expandido e um backdrop customizado.
- A FAQ usa botoes com aria-expanded, aria-controls e regioes para as respostas.
- CTAs que apontam para WhatsApp sao interceptados para abrir um fluxo de orcamento em duas etapas: confirmacao de interesse e selecao de faixa de investimento. Algumas escolhas encaminham para WhatsApp; outras encerram com uma mensagem alternativa.
- O fluxo grava um evento de interesse e uma faixa de orcamento em uma tabela Supabase. Isso transforma o CTA em qualificacao de lead, nao apenas em um link.
- O codigo inclui tratamento de Escape e clique no backdrop para fechar o dialog. No trecho inspecionado, nao foi confirmado gerenciamento completo de foco, incluindo focus trap e restauracao do foco ao elemento que abriu o modal.
- O pacote de scroll implementa rolagem suave e ha regras para movimento reduzido, mas a regra encontrada parece parcial. A cobertura precisa ser validada no navegador antes de considerar o comportamento acessivel.

### O que aproveitar

- Amarrar promessa, prova, processo e CTA numa narrativa que corresponda a decisao que a pessoa precisa tomar.
- Criar cenas responsivas dedicadas quando a arte fizer parte da identidade; preservar a mensagem e o foco da acao em todas as larguras.
- Tornar o CTA especifico ao contexto, medindo o evento necessario e coletando somente os dados necessarios para a proxima etapa.
- Oferecer uma saida clara quando a pessoa ainda nao esta pronta para converter.

### O que validar antes de adotar

- Um interceptador global de links externos pode surpreender quem esperava abrir o WhatsApp imediatamente. O CTA deve anunciar o passo intermediario e manter uma forma direta de continuar.
- Um dialogo de lead que coleta dados precisa explicar o uso desses dados e limitar o que grava. A implementacao inspecionada usa um servico externo; credenciais, autorizacao e politicas de retencao precisam ser avaliadas separadamente.
- Teclas Escape e clique no fundo nao provam conformidade de dialogo. Verifique rotulo, foco inicial, foco contido, fechamento previsivel, retorno do foco, leitor de tela e comportamento em viewport estreita.
- Ativos visuais responsivos e fontes personalizadas podem custar caro. O tamanho bruto do JavaScript e CSS obtido por requisicao nao e uma medida de transferencia comprimida, carregamento percebido, Core Web Vitals ou custo de CPU.

## 2. Lando Norris

Fontes: [pagina inicial](https://landonorris.com/), [On Track](https://landonorris.com/on-track), [Off Track](https://landonorris.com/off-track) e [Calendar](https://landonorris.com/calendar).

### Arquitetura de conteudo

A navegacao separa a pagina inicial, a carreira esportiva (On Track), interesses pessoais (Off Track) e calendario. Dentro disso, a home apresenta historia, galeria de capacetes, loja, parceiros e redes sociais. On Track agrupa proxima corrida, carreira, temporadas, resultados e fotos de pista. Off Track organiza campanhas e interesses pessoais. O calendario oferece visualizador de pista, lista de eventos, sessoes e dados do circuito.

O ponto forte e a separacao por intencao. Quem procura resultados nao precisa atravessar o conteudo pessoal; quem chegou pela personalidade encontra um espaco proprio. As secoes compartilham a marca sem fingir que todo conteudo tem o mesmo modelo ou a mesma tarefa.

### Direcao e comportamento inferidos

O conteudo indexado e os metadados de imagens mostram uma experiencia editorial baseada em fotografia, campanha e narrativa, com um forte contraste entre material de pista e de vida pessoal. A home inclui um aviso de orientacao vertical e instrucoes de toque/rolagem. Esses textos sugerem uma experiencia de tela cheia e gesto, mas, sem viewport renderizada, nao permitem confirmar o layout, as animacoes nem o funcionamento do bloqueio de rolagem.

O calendario representa conteudo de evento com horario, sessao, resultado e circuito. Isso mostra que uma pagina de marca tambem pode precisar de uma visualizacao mais utilitaria, com agrupamento e filtros distintos da composicao editorial da home.

### O que aproveitar

- Organizar informacao por contexto do usuario, e nao por estrutura interna da organizacao.
- Manter uma identidade comum entre secao editorial, informacao tabular, calendario e conteudo de parceiro sem forcar um unico layout.
- Fazer paginas de indice e paginas de detalhe responderem a perguntas diferentes: visao geral da temporada, selecao de evento, detalhe do circuito e horarios.
- Tratar fotografias e campanhas como conteudo com recorte, proporcao, legenda, credito e carregamento planejados.

### Ponto de atencao observado

Na data da consulta, a home ainda apresentava o texto 2025 McLaren Formula 1 Driver, enquanto a pagina de calendario trazia a temporada de 2026. Isso e um exemplo concreto de conteudo temporal duplicado sem uma fonte de verdade visivel. Datas, cargos, temporadas e proxima corrida devem vir de dados compartilhados ou ter uma rotina editorial de revisao.

Um convite para rotacionar o dispositivo pode fazer sentido para uma cena de marca, mas nao pode bloquear conteudo ou interacoes essenciais. A escolha de orientacao precisa continuar utilizavel em telas estreitas, com zoom, teclado e tecnologias assistivas.

## 3. Projetos SaaS e bibliotecas

### nextjs/saas-starter

Fontes: [repositorio](https://github.com/nextjs/saas-starter), [tela de login](https://github.com/nextjs/saas-starter/blob/main/app/%28login%29/login.tsx), [acoes de login](https://github.com/nextjs/saas-starter/blob/main/app/%28login%29/actions.ts) e [sessao](https://github.com/nextjs/saas-starter/blob/main/lib/auth/session.ts).

**O que estudar:** grupos de rotas separados para login e dashboard; formulario ligado a uma acao de servidor; validacao de entrada; estados de envio e erro; criacao de sessao no servidor; guardas que verificam usuario e equipe; dashboard com conta, equipe e billing.

**Contrato importante:** o codigo de sessao usa JWT HttpOnly, Secure em producao e SameSite, com verificacao no servidor. A visibilidade de uma tela nao substitui autorizacao por usuario/equipe na leitura ou mutacao.

**Armadilha real no codigo consultado:** a acao de login devolve o valor de password no estado de erro e a interface o usa como valor inicial. Isso pode reintroduzir uma senha em estado serializado do cliente. Preserve, se fizer sentido, apenas dados nao sensiveis como email; nunca devolva ou reinsira senha em resposta de acao, URL, log ou telemetria.

### ixartz/SaaS-Boilerplate

Fontes: [repositorio](https://github.com/ixartz/SaaS-Boilerplate), [MenuToggle](https://github.com/ixartz/SaaS-Boilerplate/blob/main/src/components/MenuToggle.tsx), [navegacao mobile](https://github.com/ixartz/SaaS-Boilerplate/blob/main/src/features/dashboard/MobileNavigation.tsx) e [menu de organizacao](https://github.com/ixartz/SaaS-Boilerplate/blob/main/src/features/dashboard/OrganizationMenu.tsx).

**O que estudar:** base com Next App Router, TypeScript, Tailwind, componentes shadcn/Radix, Clerk e Drizzle; rotas localizadas; organizacoes e papeis; uma camada de navegacao de dashboard separada dos fluxos publicos. A documentacao do projeto descreve opcoes de login, MFA, passkeys e impersonation.

**O que conferir:** um componente de menu com icone sozinho precisa de nome acessivel e estado compreensivel. No MenuToggle.tsx consultado, esse contrato nao estava explicito no componente. Verifique se a camada que o envolve fornece o nome, o estado expandido e a relacao com o painel antes de reutiliza-lo.

### Kiranism/next-shadcn-dashboard-starter

Fontes: [repositorio](https://github.com/Kiranism/next-shadcn-dashboard-starter), [rota de sign-in](https://github.com/Kiranism/next-shadcn-dashboard-starter/tree/main/src/app/auth/sign-in), [formulario demonstrativo](https://github.com/Kiranism/next-shadcn-dashboard-starter/blob/main/src/features/auth/components/user-auth-form.tsx) e [area de produtos](https://github.com/Kiranism/next-shadcn-dashboard-starter/tree/main/src/features/products).

**O que estudar:** organizacao por feature; tabela com busca, filtro, ordenacao e paginacao sincronizados com a URL; prefetch de dados e hidratacao do React Query; sidebar com navegacao; modal de confirmacao com estado de envio; uso de primitivas acessiveis como base dos componentes.

**Distincao critica:** a rota de login usa Clerk. UserAuthForm e uma demonstracao isolada de UI que valida campos e mostra toast; ela nao e o fluxo real de autenticacao. Um toast de sucesso nao autentica ninguem. Mantenha telas demonstrativas claramente separadas da sessao e das permissoes reais.

**Contexto de versao:** a branch consultada usa Next.js 16, React 19 e Tailwind v4, e o projeto migrou parte dos componentes para primitivas Base UI. Isso e fotografia de uma branch em 2026, nao recomendacao para adotar essa stack sem avaliar compatibilidade, maturidade e necessidades do produto.

### wasp-lang/open-saas

Fontes: [repositorio](https://github.com/wasp-lang/open-saas), [pagina de login](https://github.com/wasp-lang/open-saas/blob/main/template/app/src/auth/LoginPage.tsx), [configuracao de auth](https://github.com/wasp-lang/open-saas/blob/main/template/app/src/auth/auth.wasp.ts) e [redirecionamento de sessao](https://github.com/wasp-lang/open-saas/blob/main/template/app/src/auth/RedirectIfLoggedIn.tsx).

**O que estudar:** declaracao de rotas, operacoes e autenticacao pelo Wasp; paginas pequenas que compoem LoginForm/SignupForm; validacao Zod; rotas de verificacao e recuperacao; estado de carregamento enquanto uma pessoa autenticada e redirecionada.

**Nao presumir:** a configuracao padrao consultada habilita email. Exemplos de Google/GitHub/Discord aparecem como configuracoes opcionais/comentadas; suporte documentado nao significa provedor ativado no projeto.

### Cal.com / Cal.diy

Fontes: [repositorio publico atual Cal.diy](https://github.com/calcom/cal.diy), [anuncio oficial da mudanca de escopo](https://next.cal.com/blog/cal-diy-open-source-to-closed-source) e [changelog v6.6](https://site.cal.com/blog/calcom-v6-6).

**Atualizacao de escopo:** a empresa anunciou em 2026 que a base de producao do Cal.com deixou de ser publica e que o repositorio aberto passou a se chamar Cal.diy, sem partes comerciais, equipes e organizacoes. Portanto, o codigo publico atual nao e uma copia integral do SaaS de producao.

**O que estudar:** jornadas de agendamento, paginas publicas de reserva, metadados e locale; transicao entre paginas antigas e App Router; navegacao desktop/mobile; drawer em mobile; dialogos de reagendamento com motivo, pendencia, sucesso/erro e invalidacao de dados; modais globais representados por estado de URL.

**Leitura de arquitetura:** wrappers de compatibilidade para props de SSR e paginas antigas permitem migrar gradualmente, mas tambem mostram custo de legado. Use essa tecnica como ponte com prazo e plano de remocao, nao como camada permanente por padrao.

**Leitura de UI:** um dialogo com mudanca de estado deve fechar e atualizar a consulta apenas apos sucesso, manter o motivo enquanto ha falha, informar erro sem perder entrada e bloquear duplo envio enquanto a mutacao esta pendente.

### mickasmt/next-saas-stripe-starter

Fontes: [repositorio](https://github.com/mickasmt/next-saas-stripe-starter), [formulario de auth](https://github.com/mickasmt/next-saas-stripe-starter/blob/main/components/auth/auth-form.tsx), [redirecionamento seguro](https://github.com/mickasmt/next-saas-stripe-starter/blob/main/lib/auth/redirect.ts), [sessao e papeis](https://github.com/mickasmt/next-saas-stripe-starter/tree/main/lib/auth) e [cabecalho do dashboard](https://github.com/mickasmt/next-saas-stripe-starter/blob/main/components/dashboard/dashboard-header.tsx).

**O que estudar:** separacao entre marketing, auth e app; papeis da plataforma distintos dos papeis dentro de uma organizacao; navegacao filtrada por capacidade; helper de sessao e protecao de rota; validacao de destino de redirecionamento para aceitar somente caminho relativo seguro; sidebar desktop e Sheet mobile que fecha ao navegar.

**Limite da versao aberta:** o magic link por email aparece como funcionalidade Pro e nao fica habilitado na versao publica consultada. Google tambem depende de configuracao OAuth. Leia os recursos habilitados e a configuracao real, nao apenas a aparencia dos formularios.

### Tabler

Fontes: [repositorio](https://github.com/tabler/tabler), [demo sign-in](https://preview.tabler.io/sign-in.html), [demo de modais](https://preview.tabler.io/modals.html), [demo de tabelas](https://preview.tabler.io/datatables.html) e [fonte do formulario](https://github.com/tabler/tabler/blob/main/preview/pages/sign-in.astro).

**O que estudar:** variedade de telas isoladas, temas, densidade, formularios, navegacao, modais de tamanhos diferentes e composicao de tabela. A galeria e valiosa como catalogo de padroes visuais e estados de layout.

**Limite funcional:** o formulario demo consultado tem action estatico, e a tabela demonstrativa faz ordenacao no cliente. Sao pecas de showcase, nao prova de autenticacao, autorizacao, paginacao server-side ou comportamento de um SaaS com dados reais. O README atual informa mais de 100 paginas e 6.500 icones; trate a contagem como dado sujeito a mudanca.

## 4. Padroes de interface derivados

### Login e autenticacao

1. Separe claramente tela, validacao, sessao e autorizacao. Um formulario bonito com toast nao e um login funcional.
2. Valide no servidor e verifique permissao no servidor em cada recurso protegido. Ocultar um link no menu melhora a interface, mas nao protege dados.
3. Use destinos de retorno permitidos. Aceite caminho local seguro ou allowlist, evitando redirecionamento para dominio controlado por terceiros.
4. Nunca devolva a senha em estado de acao ou resposta de validacao. Preserve somente dados que nao expoem segredo.
5. Defina estados de inicializacao, envio, erro, sucesso, sessao expirada, verificacao, recuperacao e redirecionamento.
6. Use autocomplete apropriado, labels associados, erros ligados aos campos e nomes de botao claros. Formulario deve continuar usavel com teclado, leitor de tela e gerenciador de senhas.
7. Mostre somente provedores e metodos configurados no ambiente. Um botao de login social sem configuracao funcional e um contrato quebrado.

### Navegacao, menus e organizacoes

1. Modele a navegacao pela tarefa e pelo papel, com uma estrutura coerente entre desktop e mobile.
2. Use links para destinos e botoes para acoes. Marque a pagina atual com semantica apropriada; nomeie menus icon-only.
3. Menu que abre deve expor estado (aria-expanded) e relacao com o painel; teclado e toque devem conseguir abrir, navegar, fechar e recuperar foco.
4. Um drawer mobile deve ter rotulo, fechamento previsivel, comportamento de foco, area de toque adequada e fechamento ao navegar quando isso for a expectativa do produto.
5. Papeis globais, papel dentro da organizacao e permissao por recurso sao conceitos diferentes. A UI pode filtrar acoes, mas o servidor decide.
6. Em produtos multi-tenant, deixe evidente qual organizacao esta ativa e nao misture seus dados ao alternar contexto.

### Dialogos, modais e confirmacoes

1. Prefira primitiva testada ou dialogo nativo adequado; nomeie o dialogo e ligue o titulo a ele.
2. Ao abrir, posicione foco com intencao. Em modal, contenha Tab dentro da janela, suporte Escape quando a acao for segura e restaure foco ao disparador no fechamento.
3. Nao dependa apenas do backdrop ou de uma animacao para indicar fechamento. Evite descartar texto ou mutacao sem aviso.
4. Operacoes destrutivas devem explicar alvo e consequencia. Rotule os botoes com a acao (Excluir projeto), nao com um Sim sem contexto.
5. Durante envio, previna duplicacao, preserve os campos, mostre pendencia e comunique sucesso/erro. Feche e atualize os dados somente quando a operacao terminar com sucesso.
6. Em mobile, escolha dialogo, drawer ou bottom sheet conforme a tarefa e o espaco; preserve foco, rolagem, botao de fechar e acesso ao conteudo.
7. Use modais globais controlados pela URL apenas quando compartilhar, voltar/avancar e restaurar estado forem beneficios reais.

### Tabelas, filtros e dados

1. Mantenha no URL os filtros, busca, ordenacao e pagina quando isso ajudar compartilhamento, historico do navegador ou retorno a uma lista.
2. Escolha processamento client-side para colecoes pequenas e ja carregadas; use servidor para volume alto, dados autorizados ou consultas caras. Defina limites e pagina antes de escalar.
3. Planeje colunas prioritarias, acao por linha, selecao, ordenacao, vazios, erro e carregamento. No mobile, escolha detalhe por linha, lista alternativa ou rolagem horizontal indicada.
4. Leia o contrato do componente de tabela: estado controlado, paginacao, ordenacao, filtros e selecao devem refletir os dados reais.
5. Prefetch/hidratacao pode melhorar a primeira interacao, mas precisa ser medido e nao pode duplicar consultas ou enviar dados que o usuario nao deveria receber.

### Direcao visual e conteudo

1. Landing pages, dashboards e sites editoriais podem compartilhar tokens e acessibilidade sem compartilhar a mesma composicao.
2. Conteudo de marca pede hierarquia, narrativa, fotografia e ritmo. Produto operacional pede previsibilidade, densidade controlada, status e tarefas claras.
3. Use imagens com formato, proporcao, carregamento e texto alternativo planejados. Arte responsiva pode ter crops diferentes sem duplicar a mensagem.
4. Dados que mudam por temporada, status ou organizacao devem vir de uma fonte confiavel ou ter proprietario e rotina de atualizacao.
5. Efeitos de scroll, gestos e cenas devem ser opcionais quando forem decorativos. Nao gaste desempenho nem remova uma acao essencial para sustentar o efeito.

## 5. Decisoes para projetos novos

| Necessidade | Comece estudando | Decisao a registrar |
|---|---|---|
| Entender o fluxo minimo de SaaS | nextjs/saas-starter | Rotas publicas/privadas, sessao, validacao, permissoes e estados de billing. |
| Organizacoes, papeis e localizacao | ixartz/SaaS-Boilerplate ou mickasmt/next-saas-stripe-starter | Modelo de tenant, papel global, papel de membro, locale e provedores habilitados. |
| Dashboard com filtros e tabela | Kiranism/next-shadcn-dashboard-starter | Fonte da verdade da query, estado no URL, limite de volume e estrategia mobile. |
| Autenticacao declarativa | wasp-lang/open-saas | Quais provedores estao realmente habilitados e onde a validacao roda. |
| Agendamento e fluxos complexos | Cal.diy | Estado da reserva, transicoes, idempotencia, dialogs, permissao e compatibilidade com legado. |
| Catalogo de componentes visuais | Tabler | O que e apenas demonstracao e o que tem comportamento real no produto. |
| Narrativa de uma landing page | Jorge Web Pro | Promessa, prova, processo, objecoes, CTA, consentimento e medicao. |
| Conteudo editorial com varias areas | Lando Norris | Modelo de conteudo, navegacao por contexto, atualizacao de dados e limites de orientacao. |

Antes de adotar uma stack, confirme a documentacao oficial, versoes suportadas, licenca, manutencao, acessibilidade dos componentes e custo de migracao. Use os exemplos como material de estudo de problemas concretos, nao como ranking universal.

## Referencias por fonte

- [nextjs/saas-starter](https://github.com/nextjs/saas-starter)
- [ixartz/SaaS-Boilerplate](https://github.com/ixartz/SaaS-Boilerplate)
- [Kiranism/next-shadcn-dashboard-starter](https://github.com/Kiranism/next-shadcn-dashboard-starter)
- [wasp-lang/open-saas](https://github.com/wasp-lang/open-saas)
- [Cal.diy](https://github.com/calcom/cal.diy)
- [mickasmt/next-saas-stripe-starter](https://github.com/mickasmt/next-saas-stripe-starter)
- [Tabler](https://github.com/tabler/tabler)

Para transformar uma nova referencia em mudanca, use o roteiro de [Referencias Visuais e Movimento](REFERENCIAS-VISUAIS-E-MOVIMENTO.md) e os criterios gerais de [Design System Frontend](../core/DESIGN_SYSTEM_FRONTEND.md).
