# Guia Rapido de Uso

Use o Doktor System-Design para dar contexto e criterio a projetos novos sem copiar uma pilha de documentos que nao sera usada.

## 1. Comece pelo problema

Defina em poucas linhas:

- quem vai usar o projeto;
- qual tarefa ou problema ele resolve;
- que dados, integracoes e riscos estao envolvidos;
- como o resultado sera reconhecido;
- quais restricoes de stack, custo, deploy ou prazo existem.

## 2. Escolha o nivel de adocao

| Nivel | Quando usar | Base |
|---|---|---|
| Leve | Prototipo, ferramenta pequena ou exploracao | Guia Minimo, README e comandos reais |
| Focado | Uma tarefa de frontend, backend ou API | Guia Minimo mais os documentos do escopo |
| Completo | Produto com usuarios, dados, integracoes ou operacao continua | AGENTS, IA.md, arquitetura, seguranca, testes e guias relevantes |

Nao copie todos os templates por padrao. Adicione cada documento quando ele esclarecer uma decisao, orientar uso ou reduzir risco.

## 3. Prepare o repositorio

1. Leia [Guia Minimo de Qualidade](../core/GUIA_MINIMO_QUALIDADE.md).
2. Confira o README, os comandos e as convencoes existentes.
3. Copie e adapte [AGENTS-template.md](../templates/AGENTS-template.md) quando agentes de IA forem parte do fluxo.
4. Crie [IA-template.md](../templates/IA-template.md) se a continuidade entre sessoes justificar memoria operacional.
5. Escolha uma stack a partir das restricoes; registre decisao duradoura em ADR.
6. Leia apenas os guias do trabalho atual.
7. Se o produto tiver varias telas ou componentes compartilhados, copie e adapte [Design System Frontend do Projeto](../templates/DESIGN-SYSTEM-FRONTEND-template.md). Para uma pagina simples, registre somente as decisoes necessarias na tarefa.

## 4. Roteamento por tarefa

- Interface: [Frontend](../core/DESIGN_SYSTEM_FRONTEND.md), mais o guia opcional do padrao pedido.
- Base de UI compartilhada: [template de Design System Frontend](../templates/DESIGN-SYSTEM-FRONTEND-template.md), quando varias telas precisarem manter tokens, componentes e comportamento consistentes.
- Backend: [Backend](../core/DESIGN_SYSTEM_BACKEND.md).
- API: [API REST](../core/DESIGN_SYSTEM_API_REST.md).
- Arquitetura ou modularidade: [Arquitetura](../core/DESIGN_SYSTEM_ARQUITETURA.md) e [Modularidade](../core/DESIGN_SYSTEM_MODULARIDADE.md) se ambas forem necessarias.
- Seguranca, dados ou autenticacao: [Seguranca](../core/DESIGN_SYSTEM_SEGURANCA.md).
- Testes e verificacao: [Testes](../core/DESIGN_SYSTEM_TESTES.md).
- Performance: [Performance](../core/DESIGN_SYSTEM_PERFORMANCE.md).
- Stack: [Stack e Arquitetura](STACK-E-ARQUITETURA.md).
- Referencia atual ou padrao tecnico: [Referencias Tecnicas](REFERENCIAS-TECNICAS.md).
- Programa local que precisa de um launcher amigavel: [Entrada e Execucao](../core/GUIA-START-APP-SCRIPT.md).

## 5. Construir em ciclos curtos

1. Confirme o comportamento e os contratos.
2. Entregue um fluxo vertical pequeno que possa ser usado.
3. Revise estados, acessibilidade, seguranca e desempenho conforme o risco.
4. Execute as verificacoes adequadas e registre evidencias reais.
5. Atualize o README, IA.md, contratos ou ADRs afetados.
6. Deixe proximos passos como oportunidades para contribuicao, sem prometer o que nao esta priorizado.

## Primeiro pedido para IA

~~~text
Siga o AGENTS.md e o Guia Minimo de Qualidade deste projeto.
Leia o resumo vivo de IA.md, se existir.
Objetivo:
[uma frase sobre o projeto]
Tarefa agora:
[resultado e comportamento esperado]
Contexto e restricoes:
[stack existente, usuarios, dados, deploy, limites]
Criterio de pronto:
[como reconhecer o resultado e o que verificar]
~~~

O Doktor deve tornar mais facil entender o objetivo, executar o projeto, validar mudancas, acompanhar decisoes e continuar o trabalho.
