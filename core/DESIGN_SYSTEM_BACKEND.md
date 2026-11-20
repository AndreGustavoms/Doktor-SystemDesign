# Design System Backend

Este guia orienta a implementacao de servicos confiaveis, seguros, observaveis e faceis de evoluir. A arquitetura e a stack devem servir ao dominio e a operacao.

Consulte [Stack e Arquitetura](../docs/STACK-E-ARQUITETURA.md), [API REST](DESIGN_SYSTEM_API_REST.md), [Seguranca](DESIGN_SYSTEM_SEGURANCA.md), [Testes](DESIGN_SYSTEM_TESTES.md) e [Performance](DESIGN_SYSTEM_PERFORMANCE.md) conforme o escopo.

## 1. Comece pelo contrato do sistema

Defina o que o backend precisa garantir:

- entradas, saidas, estados e falhas esperadas;
- identidade, permissoes e ownership dos dados;
- requisitos de latencia, volume e disponibilidade;
- efeitos colaterais, transacoes e integracoes;
- dados pessoais ou regulados envolvidos;
- como instalar, executar, validar, observar e recuperar o servico.

Nao escolha filas, caches ou microservicos antes de identificar um requisito que eles atendem.

## 2. Responsabilidades e limites

Separe fronteiras quando isso permitir mudar, testar ou operar cada responsabilidade sem espalhar conhecimento:

- entrada (HTTP, CLI, evento ou tarefa);
- validacao e adaptacao do contrato externo;
- caso de uso e regra de negocio;
- persistencia e transacao;
- clientes de servicos externos;
- configuracao, observabilidade e autenticacao.

Controllers e handlers devem autenticar, validar o limite de entrada e delegar o trabalho. Regras centrais nao devem depender de detalhes de HTTP quando isso dificultar reutilizacao ou teste. Um backend simples nao precisa criar todas essas camadas desde o primeiro dia; use a menor estrutura que mantenha as fronteiras visiveis.

## 3. Dados e persistencia

Escolha o armazenamento a partir do modelo e das operacoes:

- dados relacionais e transacoes frequentemente se ajustam a banco relacional;
- chave-valor, documento, busca ou armazenamento de objetos atendem outras formas de acesso;
- SQLite pode ser adequado para uso local, educacional ou implantacao pequena com limites conhecidos;
- um banco gerenciado como PostgreSQL pode ser adequado quando concorrencia, operacao e disponibilidade justificarem.

Documente ownership dos dados, migrations, constraints, transacoes, backups e retencao quando aplicavel. Restrinja consultas e tamanho de payload. Use indices e cache com base em acesso medido, nao por previsao abstrata.

## 4. Regras, consistencia e idempotencia

- Valide no limite e mantenha invariantes no lugar onde a regra e dona.
- Defina limites de transacao e evite efeitos colaterais antes de confirmar dados criticos.
- Operacoes repetiveis devem ter comportamento idempotente ou uma estrategia para evitar duplicacao.
- Para fluxos distribuidos, documente compensacao, retentativa e estado parcial.
- Use formato decimal ou tipo adequado para dinheiro e unidades quando a precisao importar.
- Mantenha datas com timezone definido e regras de calendario explicitas.

## 5. Integracoes e resiliencia

Isole integracoes em adaptadores com contratos pequenos. Defina timeout e limites. Repetir chamadas apenas quando a falha for transitoria e a operacao puder ser repetida com seguranca. Considere backoff, rate limit, idempotencia e circuit breaker conforme impacto e frequencia de falha.

Jobs e filas sao uteis para trabalho demorado, retentavel ou desacoplado, mas adicionam operacao, monitoramento e consistencia eventual. Comece com processamento direto se ele atender latencia e confiabilidade requeridas.

## 6. Configuracao, erros e observabilidade

- Configuracoes por ambiente ficam fora do codigo; segredos usam um armazenamento apropriado ao ambiente.
- Falhe cedo quando uma configuracao obrigatoria estiver ausente ou invalida.
- Retorne erros estaveis e uteis ao cliente sem detalhes internos.
- Registre contexto suficiente para diagnostico, com identificador de correlacao quando fizer sentido.
- Nao registre credenciais, payloads sensiveis ou dados pessoais sem finalidade e protecao definidas.
- Use metricas e traces para operacoes cujo desempenho ou disponibilidade precisam ser acompanhados.

## 7. Stack e testes

Use a stack existente se ela atende aos requisitos. Para projeto novo, compare custo de manutencao, ecossistema, equipe, deploy, integracoes e seguranca. Registre desvios importantes em ADR ou IA.md.

Planeje testes pelo risco: regras criticas, persistencia real, autorizacao, contratos, migracoes e integracoes merecem verificacao proporcional. TDD e uma tecnica util quando escrever o comportamento esperado primeiro reduz ambiguidade; nao e requisito para toda mudanca. Detalhes em [Design System Testes](DESIGN_SYSTEM_TESTES.md).

## 8. Entrada para desenvolvimento e documentacao

Documente o comando real de setup e execucao no README. Use um launcher interativo como `start_app.py` somente quando ele tornar um fluxo local mais acessivel; consulte [Entrada e Execucao do Projeto](GUIA-START-APP-SCRIPT.md).

Atualize README, contexto IA e documentos de contrato quando comandos, operacao ou comportamento mudarem. Preserve decissoes anteriores como historico, acrescentando novos registros quando forem superadas.

## Checklist backend

- [ ] Contratos, permissoes, dados e falhas esperadas estao definidos.
- [ ] Fronteiras separam regra, transporte, persistencia e integracao onde isso agrega.
- [ ] Dados e transacoes correspondem aos invariantes do dominio.
- [ ] Operacoes repetidas e falhas parciais foram consideradas.
- [ ] Integracoes tem timeouts e politica de retentativa adequada.
- [ ] Erros e logs ajudam a diagnosticar sem expor dados sensiveis.
- [ ] Seguranca, testes e performance foram avaliados conforme o risco.
- [ ] Setup, execucao, validacao e operacao estao documentados.