# Guia Minimo de Qualidade

> Leia este contrato antes de alterar qualquer projeto. Aplique cada criterio ao escopo real e aumente o rigor quando o risco exigir.

## Principios universais

1. Entenda objetivo, usuarios, estado atual e contratos antes de alterar.
2. Escolha a solucao mais simples que satisfaz requisitos presentes e proximos.
3. Separe responsabilidades por fronteira de mudanca, nao por regra de quantidade de arquivos ou camadas.
4. Preserve contratos publicos; planeje mudancas incompativeis.
5. Valide dados e permissoes em fronteiras de confianca; mantenha segredos fora do codigo e logs.
6. Teste comportamentos e contratos proporcionais ao risco. Automatize o que e repetivel; registre verificacao manual quando ela for mais adequada.
7. Atualize README, IA.md e documentacao quando uso, estrutura ou decisoes mudarem. Preserve a linha do tempo tecnica.
8. Registre decisoes caras de reverter, alternativas e trade-offs.
9. Prefira ferramentas e automacao existentes; nao crie uma ferramenta maior que o problema.
10. Use comandos de entrada que se encaixem no tipo de projeto; um menu interativo e opcional quando reduzir atrito real.
11. Revise dependencias novas, seu impacto, manutencao e riscos; atualize lockfile quando aplicavel.
12. Informe o que mudou, como foi validado e quais limites ficaram sem verificacao. Nunca declare uma verificacao que nao foi executada.

## Para interfaces

- Projete para conteudo, telas, zoom, teclado, toque e preferencias reais do publico.
- Considere WCAG 2.2 AA como alvo para interfaces web quando apropriado; requisitos formais dependem do produto e da jurisdicao.
- Trate estados de carregamento, vazio, sucesso, erro e permissao quando existirem.
- Meca performance em fluxos importantes; preserve clareza e acessibilidade ao otimizar.

## Para APIs e servicos

- Defina contratos, status e erros previsiveis.
- Aplique autorizacao por operacao e recurso.
- Limite colecoes, uploads e trabalhos custosos.
- Configure resiliencia para dependencias externas conforme o impacto de falha.

## Criterio de pronto

- [ ] O escopo e o comportamento esperado estao claros.
- [ ] A mudanca preserva ou documenta os contratos afetados.
- [ ] Arquitetura, seguranca e acessibilidade foram consideradas quando aplicaveis.
- [ ] Verificacoes relevantes foram executadas ou a limitacao foi registrada.
- [ ] Documentacao afetada e contexto operacional estao atualizados.
- [ ] O resultado e compreensivel para quem mantem o projeto depois.