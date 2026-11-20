# Design System Arquitetura

> Este documento ajuda a escolher limites e dependencias que mantem o software compreensivel e mudavel. A estrutura deve servir ao dominio e ao fluxo de trabalho, nao uma arvore de pastas universal.

## 1. Objetivo

Arquitetura distribui responsabilidades e torna mudancas previsiveis. O objetivo nao e maximizar camadas, padroes ou quantidade de arquivos; e permitir evoluir o sistema sem espalhar conhecimento e risco.

Use nomes e fronteiras que facilitem responder:

- onde uma regra de negocio vive;
- quem valida uma entrada externa;
- onde efeitos colaterais acontecem;
- qual contrato conecta dois modulos;
- quais partes podem mudar sem alterar as demais.

## 2. Escolha a menor arquitetura que serve

- Um script pequeno pode ser um unico modulo organizado.
- Uma aplicacao em crescimento costuma funcionar bem como **monolito modular**: um deploy simples, modulos com contratos claros e baixo acoplamento.
- Separe servicos ou deploys quando escala, isolamento, disponibilidade, seguranca ou autonomia de equipe justificar o custo operacional.
- Adote event-driven, fila ou cache quando um requisito observavel pedir isso, nao para antecipar crescimento hipotetico.

Registre em um ADR decisoes caras, dificeis de reverter ou com trade-offs relevantes. Use [ADR-0001-template.md](../templates/ADR-0001-template.md).

## 3. Organize pelo dominio e pelas mudancas

Prefira iniciar a navegacao por feature, produto ou dominio. Dentro de um modulo, crie subpastas para responsabilidades que realmente tenham fronteiras proprias.

Exemplo ilustrativo, adaptado ao framework:

~~~text
src/
|-- modules/
|   |-- accounts/
|   |   |-- domain/
|   |   |-- application/
|   |   |-- adapters/
|   |   +-- ui/
|   +-- reports/
|-- shared/
|-- app/
+-- tests/
~~~

Nem todo modulo precisa de todas as pastas. Um framework pode impor outra estrutura; respeite-a e preserve as fronteiras conceituais. Evite pastas vazias ou camadas criadas apenas para seguir o desenho.

## 4. Fronteiras e dependencias

- Regras centrais do produto devem ser compreensiveis sem conhecer detalhes de transporte, interface ou provedor externo quando isso for importante para o dominio.
- Adaptadores traduzem protocolos, banco, fila, arquivos e servicos externos para contratos internos.
- Dependencias entre modulos devem ser explicitas e orientadas a contratos pequenos.
- Evite ciclos, importacao global de estado e acesso a dados de outro modulo por detalhes internos.
- Mantenha a logica de composicao na borda: rotas, views, jobs e comandos delegam ao caso de uso adequado.
- Compartilhe um modelo ou componente quando ele tiver significado realmente comum, nao apenas porque dois nomes se parecem.

Um CRUD simples nao precisa de dominio rico, repository generico e interfaces para cada chamada. Introduza abstracao quando ela isolar variacao, efeito colateral ou uma fronteira de mudanca real.

## 5. Responsabilidades praticas

| Responsabilidade | Lugar tipico |
|---|---|
| Entrada HTTP, CLI ou evento | Adaptador de entrada |
| Regras e invariantes do produto | Dominio ou caso de uso |
| Persistencia e transacao | Adaptador de dados |
| Servico externo | Cliente/adaptador isolado |
| UI e composicao visual | Tela, componente ou feature de frontend |
| Configuracao e inicializacao | Borda de composicao |
| Observabilidade e auditoria | Infraestrutura, sem vazar dados sensiveis |

Os nomes variam por stack. Evite misturar regra de negocio, renderizacao, consultas, rede e configuracao no mesmo ponto quando isso dificultar testes ou mudancas independentes.

## 6. Contratos e mudancas

- Defina limites de entrada e saida, erros e ownership de dados.
- Valide dados ao cruzar uma fronteira de confianca.
- Prefira interfaces pequenas e estaveis; evite expor classes internas de um modulo.
- Mudancas incompativeis em contrato exigem plano de migracao, coordenacao ou versionamento conforme quem consome.
- Use idempotencia, transacao e compensacao quando a operacao puder ser repetida ou distribuida.
- Documente limitacoes e falhas esperadas de dependencias externas.

## 7. Evolucao e diagnostico

Sinais para rever a arquitetura:

- toda mudanca exige editar varios modulos sem relacao;
- a mesma regra existe em lugares diferentes;
- testes precisam de muita configuracao para validar comportamento simples;
- detalhes de um provedor vazam para o dominio ou a UI;
- ha ciclos de dependencia ou contratos compartilhados que mudam sem coordenacao;
- a operacao exige mais deploy, fila ou servico do que o valor entregue justifica.

Refatore a fronteira que causa atrito, preservando comportamento e contratos quando possivel. Nao mova codigo so para combinar com um diagrama.

## Checklist de arquitetura

- [ ] A arquitetura corresponde ao tamanho, risco e forma de operacao atuais.
- [ ] As fronteiras refletem dominios ou motivos reais de mudanca.
- [ ] Dependencias e efeitos colaterais estao visiveis.
- [ ] A logica importante pode ser exercitada sem infraestrutura desnecessaria.
- [ ] Modulos expoem contratos pequenos e nao criam ciclos.
- [ ] Complexidade distribuida tem justificativa concreta.
- [ ] Decisoes dificeis de reverter e trade-offs estao registrados.