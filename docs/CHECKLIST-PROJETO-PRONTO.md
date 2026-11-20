# Checklist de Projeto Pronto

Use os pontos aplicaveis ao escopo e ao risco do produto. Um item fora de contexto nao precisa virar trabalho.

## Produto e operacao

- [ ] Objetivo, publico e fluxo principal estao claros.
- [ ] O README mostra pre-requisitos, setup, configuracao e execucao real.
- [ ] Contratos, limites e decisoes importantes estao documentados.
- [ ] Outra pessoa consegue executar e validar sem contexto privado.

## Interface, quando existir

- [ ] A hierarquia ajuda a concluir a tarefa principal.
- [ ] O layout funciona com conteudo real, telas estreitas e zoom.
- [ ] Teclado, foco, labels, contraste e estados foram considerados.
- [ ] Loading, vazio, erro, sucesso e permissao estao claros quando aplicaveis.
- [ ] Movimento respeita preferencias e nao substitui significado.
- [ ] Performance foi verificada nos fluxos mais importantes.

## Servicos, quando existirem

- [ ] Entradas e permissoes sao validadas no servidor.
- [ ] Contratos, erros, paginacao e compatibilidade sao previsiveis.
- [ ] Transacoes, repeticao e falhas de integracoes foram consideradas.
- [ ] Logs ajudam o diagnostico sem expor segredos ou dados desnecessarios.
- [ ] Dados e migrations tem ownership e plano de recuperacao quando necessario.

## Seguranca e dados

- [ ] Segredos e dados reais sensiveis nao estao no repositorio ou exemplos.
- [ ] Riscos e controles foram avaliados para as fronteiras expostas.
- [ ] Dados pessoais tem finalidade, acesso, retencao e remocao tratados conforme o produto.
- [ ] Dependencias e pipeline foram revisados conforme o risco.

## Verificacao

- [ ] Testes e verificacoes protegem os comportamentos de maior risco.
- [ ] A verificacao manual registra ambiente, estado observado e limites.
- [ ] Testes instaveis ou pendencias conhecidas estao registrados.
- [ ] Links e comandos da documentacao correspondem ao repositorio.
- [ ] AGENTS e IA.md, quando usados, refletem o estado atual.
- [ ] O resultado descreve o que mudou, como foi validado e o que falta.

Um projeto esta pronto para o proximo passo quando comportamento, operacao, riscos e limites estao visiveis para quem vai usa-lo ou mante-lo.