# Stack e Arquitetura

Este documento orienta escolhas tecnicas para projetos novos e mudancas de stack. Nao existe uma combinacao universal que sirva a qualquer projeto.

## 1. Como decidir

Comece por restricoes e resultados, nao pela popularidade da ferramenta:

- qual problema, publico e fluxo principal;
- experiencia de quem vai manter;
- tecnologia existente e custo de migracao;
- plataforma de deploy, requisitos de dados e integracoes;
- acessibilidade, desempenho, seguranca e disponibilidade esperados;
- custo, licenca e manutencao de longo prazo;
- prazo, capacidade de equipe e risco de lock-in.

Use a stack existente quando ela atende os requisitos. Para um projeto novo sem restricoes, prefira tecnologias estaveis, bem documentadas e que a equipe consiga operar. Registre alternativas e trade-offs quando a escolha for cara ou dificil de reverter.

## 2. Tabela de decisao por contexto

| Necessidade | Direcoes possiveis | Pergunta de escolha |
|---|---|---|
| Pagina estatica ou conteudo | HTML/CSS, gerador estatico, framework existente | O conteudo precisa de estado, personalizacao ou atualizacao frequente? |
| Interface rica ou app client-side | Framework de UI com TypeScript ou alternativa da equipe | O estado e a interacao justificam runtime e build maiores? |
| Backend com admin, auth e CRUD | Framework completo ou composicao de servicos | O ecossistema integrado reduz trabalho real? |
| API pequena e focada | Framework HTTP leve ou runtime existente | Quais contratos, validacao e operacao sao necessarios? |
| App com varios dominios | Monolito modular | Fronteiras de dominio e deploy simples atendem agora? |
| Sistema que exige deploy ou escala independentes | Servicos separados ou arquitetura distribuida | Ha ownership, carga ou isolamento que pague o custo operacional? |
| Persistencia relacional | Banco relacional; SQLite para escopo local adequado | Quais transacoes, concorrencia, backup e operacao importam? |
| Busca, cache, fila ou documentos | Servico especifico quando o padrao de acesso pedir | O ganho medido justifica mais um componente para operar? |

Exemplos sao opcoes, nao uma lista fechada ou endosso de versao.

## 3. Regras de evolucao

- Nao introduza microservicos para organizar pastas.
- Comece com deploy simples e limites internos claros quando nao houver requisito distribuido.
- Selecione banco por consultas, consistencia, volume e operacao; nao por moda.
- Cache e fila adicionam invalidacao, reprocessamento e falhas novas. Adicione-os com um problema definido.
- Framework e biblioteca reduzem codigo local, mas acrescentam atualizacao e dependencia. Avalie ambos os lados.
- Reaproveitamento e interoperabilidade devem compensar o custo de abstracao.

## 4. Decisao registrada

Use ADR para escolhas que afetam contratos, armazenamento, deploy ou fronteiras de equipe. O registro deve incluir:

- contexto e restricoes;
- opcoes consideradas;
- decisao e motivo;
- trade-offs, riscos e gatilho de revisao.

Para escolhas locais de baixo impacto, uma nota no README ou IA.md basta. Ver [template de ADR](../templates/ADR-0001-template.md).

## 5. Fontes tecnicas

Consulte [Referencias Tecnicas](REFERENCIAS-TECNICAS.md) para padroes de acessibilidade, seguranca, API e performance. Confirme versoes e APIs na documentacao oficial antes de implementar; este documento evita fixar versoes de ferramentas.