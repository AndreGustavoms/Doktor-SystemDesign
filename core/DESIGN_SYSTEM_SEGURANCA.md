# Design System Seguranca

> Seguranca se aplica conforme dados, usuarios, integracoes e exposicao do produto. O objetivo e reduzir riscos concretos desde o desenho e manter controles verificaveis.

Consulte [Referencias Tecnicas](../docs/REFERENCIAS-TECNICAS.md), OWASP Top 10, OWASP ASVS e o [template SECURITY](../templates/SECURITY-template.md) conforme o nivel de risco.

## 1. Modele o risco

Antes de implementar autenticacao, dados pessoais, uploads, pagamentos, administracao ou acesso externo, identifique ativos, fronteiras de confianca, atores e abusos possiveis. Registre mitigacoes para os riscos mais relevantes. A profundidade deve acompanhar impacto e exposicao.

Use menor privilegio, negacao por padrao e defesa em profundidade. Seguranca nao substitui privacidade, consentimento, requisitos legais ou revisao de abuso do produto.

## 2. Segredos e configuracao

- Nunca coloque senha, token, chave privada ou credencial em codigo, historico Git, documentacao publica ou log.
- Mantenha arquivos locais de ambiente fora do repositorio e um exemplo sem valores reais quando o projeto depender dessas variaveis.
- Use o gerenciador de segredos da plataforma ou ambiente apropriado.
- Limite escopo e duracao de credenciais; remova as que nao sao mais usadas.
- Separe configuracao publica de segredo: valores incorporados no bundle frontend podem ser lidos por qualquer pessoa.
- Ao expor um segredo por engano, revogue ou rotacione primeiro; limpar o historico nao invalida a credencial vazada.

## 3. Autenticacao e autorizacao

Prefira bibliotecas e servicos mantidos pelo ecossistema. Nao escolha JWT por padrao: sessoes, cookies ou tokens dependem de cliente, ameaca, revogacao e deploy.

- Requisite autenticacao onde o recurso precisa de identidade.
- Autorize no servidor cada operacao e objeto; nao confie em ID, papel ou permissao enviada pelo cliente.
- Aplique minimo privilegio a usuarios, processos e tokens.
- Use armazenamento de senhas especializado com algoritmos adaptativos e configuracao mantida por biblioteca confiavel.
- Proteja sessao e token contra roubo, replay, exposicao em URL e armazenamento inseguro.
- Em fluxos de autenticacao, erros e requisitos devem ser acessiveis sem depender de desafios cognitivos desnecessarios.

## 4. Entradas, saidas e arquivos

- Trate corpo, URL, headers, webhooks, arquivos, eventos e dados externos como entrada nao confiavel.
- Valide formato, tamanho, intervalo, encoding e contexto antes de usar.
- Use queries parametrizadas ou ORM seguro; nunca concatene dados de usuario em SQL ou comandos.
- Codifique saida para o contexto e evite renderizar HTML nao confiavel.
- Verifique tipo, tamanho, nome, armazenamento e acesso de uploads.
- Limite uso de recursos para evitar abuso de CPU, memoria, banda ou servico pago.

Validacao nao substitui autorizacao, escaping de saida ou consulta parametrizada.

## 5. Dados, erros e logs

Colete e retenha somente dados necessarios. Defina acesso, finalidade, periodo de retencao e remocao conforme o produto e as obrigacoes aplicaveis. Use dados sinteticos em exemplos e testes.

Respostas para clientes nao devem revelar stack trace, query, configuracao, caminhos, tokens ou existencia de recursos privados. Logs devem manter contexto para diagnostico, com redacao e controle de acesso. Auditoria de operacoes sensiveis precisa registrar quem fez o que e quando sem copiar dados em excesso.

## 6. Dependencias, deploy e resposta

- Mantenha dependencias e imagens de build rastreaveis e atualizadas; revise alertas, lockfiles e origem.
- Restrinja permissoes de build, CI e deploy.
- Use transporte protegido e configuracoes seguras fornecidas pela plataforma; ajuste headers e politicas como CSP para o produto, sem aplicar valores copiados que quebrem a aplicacao.
- Defina como detectar, conter e comunicar um incidente de acordo com o impacto.
- Backups devem ser protegidos e sua restauracao deve ser exercitada quando a continuidade importar.

OWASP Top 10 e uma lista de conscientizacao, nao uma certificacao. Para revisao de controles, selecione requisitos do ASVS conforme o risco e a versao adotada. APIs tambem exigem foco em autorizacao por objeto e propriedade.

## Checklist de seguranca

- [ ] Ativos, atores, fronteiras e riscos principais foram identificados.
- [ ] Segredos estao fora do codigo e podem ser rotacionados.
- [ ] Autenticacao e autorizacao sao distintas e aplicadas no servidor.
- [ ] Dados externos sao validados e saida e protegida por contexto.
- [ ] Erros, logs e exemplos nao expoem dados sensiveis.
- [ ] Dependencias, CI, deploy e backups foram considerados conforme o risco.
- [ ] Dados pessoais tem finalidade, acesso e retencao definidos.
- [ ] O plano de resposta e proporcional ao impacto do produto.