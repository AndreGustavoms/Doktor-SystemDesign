# Design System README

Um README deve ajudar uma pessoa a entender o projeto e executar a tarefa mais importante sem precisar de contexto privado ou da conversa original.

## 1. O que responder primeiro

- O que o projeto faz e para quem?
- Como instalar e executar o fluxo principal?
- Como configurar o que e necessario?
- Como validar uma mudanca?
- Onde estao os contratos e decisoes importantes?
- Quais limites ou riscos afetam o uso?

## 2. Estrutura sugerida

Use apenas secoes que resolvem perguntas reais deste projeto:

~~~text
Nome e descricao
Uso ou demonstracao, se houver
Pre-requisitos
Instalacao e configuracao
Como rodar
Como testar ou validar
Arquitetura e documentacao
Decisoes, limitacoes e riscos
Contribuicao
Licenca
~~~

A ordem pode variar conforme o publico. Projetos pequenos precisam de menos secoes; servicos em producao precisam de instrucoes operacionais claras.

## 3. Conteudo

- Use comandos reais e reproduziveis do repositorio.
- Separe setup, execucao, testes e deploy; nao invente um launcher ou comando generico.
- Liste configuracoes necessarias sem incluir valores reais de segredo.
- Registre a stack que existe, nao uma desejada.
- Explique o contrato publico e a forma de reportar problemas quando aplicavel.
- Escreva para quem nao conhece a conversa ou a equipe.
- Use linguagem simples, acessivel e inclusiva. Evite slogans, contexto privado e promessas sem evidencia.
- Enquadre melhorias futuras como ideias para contribuicao, nao compromissos.
- Mantenha screenshots, badges e links uteis, com texto alternativo e origem apropriados.

## 4. Exemplos e referencias

Demonstre um caminho minimo utilizavel. Use dados sinteticos e um ambiente sem efeitos externos. Links devem apontar para a documentacao certa e nao substituir uma explicacao curta sobre por que abrir a fonte.

Se houver interface visual, uma captura recente pode facilitar a leitura. Identifique o estado e o tamanho da janela; nao apresente imagem desatualizada como estado atual.

## 5. Revisao

- [ ] A primeira tela do README explica o valor e o uso do projeto.
- [ ] Comandos foram conferidos no estado atual do repositorio.
- [ ] Configuracao, ambiente e segredos estao separados.
- [ ] Links, imagens, badges e texto alternativo funcionam.
- [ ] Estrutura e limitacoes correspondem ao que existe.
- [ ] O documento pode ser entendido sem conhecimento privado.