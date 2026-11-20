# Design System Testes

> Testes devem reduzir risco de mudanca e explicar comportamento importante. O tipo, a quantidade e a ferramenta dependem do produto, da arquitetura e do custo de falha.

## 1. Estrategia baseada em risco

Mapeie os fluxos e contratos que podem causar dano, perda de dados, interrupcao ou regressao frequente. Priorize-os. Uma suite util e confiavel, facil de rodar e ligada ao que a pessoa usuaria ou outro sistema observa.

Nao existe porcentagem de cobertura que prove qualidade. Use cobertura para encontrar trechos sem verificacao e avalie se os casos testados importam.

## 2. Niveis de verificacao

- **Unidade**: regra ou transformacao com dependencias isoladas quando isso deixa o teste rapido e claro.
- **Integracao**: colaboracao real entre modulos, framework, banco, fila ou protocolo.
- **Contrato**: compatibilidade de APIs, eventos ou integracoes entre equipes e servicos.
- **E2E**: jornada critica pela interface ou pela entrada publica do sistema.
- **Manual/exploratorio**: visual, usabilidade, comportamento dificil de automatizar ou avaliacao em ambiente real.

A piramide e um modelo de custo, nao uma meta fixa. Use poucos E2E para fluxos importantes, mas nao evite um teste de integracao confiavel se ele proteger melhor o risco real. Para UI, combine automacao e verificacao manual.

## 3. O que torna um teste confiavel

- Nomeie pelo comportamento observado e condicao relevante.
- Mantenha preparacao, acao e verificacao faceis de ler; AAA e um formato possivel.
- Isole testes de dados, ordem, relogio e rede quando necessario.
- Verifique resultados observaveis e contratos, nao detalhes internos que podem mudar sem alterar comportamento.
- Cada teste deve falhar por um motivo compreensivel; um teste pode validar varias consequencias do mesmo comportamento.
- Evite sleeps fixos, dependencias compartilhadas, asserts vagos e retries que escondem instabilidade.
- Use dados sinteticos; nao copie dados reais pessoais ou de producao.

## 4. Banco, rede e mocks

Use infraestrutura real em testes de integracao quando ela for parte do comportamento que precisa ser verificado e o ambiente de teste for controlado. Use mock, fake ou simulador em limites externos quando isso tornar o teste deterministico ou evitar efeitos colaterais. Evite mockar toda colaboracao interna: isso pode apenas confirmar a implementacao atual.

Para pagamento, email, APIs externas e servicos caros, use cliente de teste, sandbox ou fake conforme o contrato e o risco. Nunca envie operacoes reais por acidente durante a suite.

## 5. TDD e outras tecnicas

TDD pode ajudar quando requisitos estao claros e o ciclo teste-implementacao mostra a forma do dominio. Exploracao, prototipo ou ajuste visual podem comecar de outra forma. Ao concluir, proteja comportamento importante com verificacao adequada.

Snapshot so e util quando a representacao completa faz parte do contrato. Prefira asserts pequenos e intencionais quando snapshots ficarem grandes ou opacos.

## 6. Execucao e manutencao

- Separe comandos rapidos de suites custosas.
- Execute verificacoes relevantes no fluxo local e na integracao continua.
- Identifique e corrija testes instaveis; nao transforme falha recorrente em retry silencioso.
- Controle portas, dados temporarios e recursos externos.
- Mantenha instrucoes de setup e comandos proximos do README ou do gerenciador de projeto.
- Quando nao for possivel automatizar, registre o procedimento manual e o que foi observado.

## Checklist de testes

- [ ] Os riscos e contratos principais estao cobertos.
- [ ] O nivel de teste corresponde a fronteira que precisa ser protegida.
- [ ] Testes nao dependem da ordem nem de dados privados.
- [ ] Mocks estao nas fronteiras certas e nao substituem verificacoes importantes.
- [ ] A suite e repetivel e reporta falhas com clareza.
- [ ] Cobertura percentual e usada como sinal, nao como prova.
- [ ] Validacao manual e limites nao automatizados estao registrados.