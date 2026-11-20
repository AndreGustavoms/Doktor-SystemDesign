# Design System API REST

> O objetivo e oferecer contratos HTTP consistentes, evolutiveis e seguros. Use as convencoes existentes quando estaveis e escolha regras explicitas para novos consumidores.

## 1. Modelar o contrato

Antes de criar rotas, identifique recursos, atores, permissoes, operacoes e erros. Use nomes de recurso compreensiveis. Substantivos no plural e URLs em kebab-case sao convencoes frequentes, nao uma exigencia quando a API ou framework ja usa outra forma consistente.

Evite URLs que codificam acoes simples como verbos. Acoes de dominio que nao se encaixam naturalmente em CRUD podem ter rotas explicitas e documentadas.

## 2. Semantica HTTP

Escolha metodos conforme a semantica do protocolo:

| Metodo | Uso tipico | Idempotente pelo protocolo |
|---|---|---|
| GET | Leitura sem efeito colateral | Sim |
| POST | Criar ou executar uma operacao | Nao, por padrao |
| PUT | Criar/substituir a representacao do recurso | Sim |
| PATCH | Alterar parcialmente um recurso | Nao necessariamente |
| DELETE | Remover ou desativar um recurso | Sim |

Idempotencia descreve o efeito pretendido de repetir uma requisicao; respostas podem variar. Para operacoes POST que podem ser repetidas por timeout, avalie uma chave de idempotencia e um contrato para replays.

## 3. Status HTTP

Retorne o status que descreve o resultado e mantenha a semantica do HTTP:

- sucesso: 200, 201, 202 ou 204 conforme o resultado e o corpo;
- erro do cliente: 400 para requisicao invalida, 401 para falta de autenticacao, 403 para falta de permissao, 404 para recurso indisponivel, 409 para conflito e 429 para limite excedido;
- erro do servidor ou dependencia: use 5xx quando a falha nao for causada por uma requisicao corrigivel pelo cliente.

Use 422 quando a convencao da API o justificar. Nao devolva 200 para uma operacao que falhou.

## 4. Respostas e erros

Mantenha os formatos consistentes dentro da API. Um envelope de sucesso pode ser util, mas nao e obrigatorio se o formato de recurso direto for mais simples ou se o contrato existente usar outro padrao.

Para erros HTTP, considere [RFC 9457 Problem Details](https://www.rfc-editor.org/rfc/rfc9457.html) quando nao houver um formato estabelecido. Campos adicionais devem ser documentados e nao podem revelar stack trace, SQL, caminhos locais, segredos ou dados de outros usuarios.

Exemplo ilustrativo:

~~~json
{
  "type": "https://example.com/problems/invalid-input",
  "title": "Invalid input",
  "status": 400,
  "detail": "One or more fields are invalid.",
  "errors": [
    { "field": "email", "code": "invalid_format" }
  ]
}
~~~

Erros devem permitir que clientes diferenciem falha de validacao, autenticacao, autorizacao, conflito, limite e indisponibilidade sem depender de texto localizado.

## 5. Colecoes, busca e ordenacao

Pagine colecoes grandes ou sem limite previsivel. Escolha offset quando acesso por pagina e contagem importam; escolha cursor quando a lista muda durante a navegacao ou o volume torna offset custoso. Defina limites maximos e comportamento de cursores expirados.

Filtros, campos de ordenacao e direcao devem ter allowlist. Documente busca, limites, ordenacao padrao e quais campos sao retornados. Nao permita consultas sem limite ou combinacoes de filtros que causem custo descontrolado.

## 6. Compatibilidade e versao

Versione quando consumidores externos precisam de um contrato de longa duracao e uma mudanca incompativel nao pode ser coordenada. Uma API privada implantada junto com seu cliente pode adotar outra estrategia. Nao adicione uma versao para parecer pronta sem um plano de compatibilidade.

Mudancas aditivas ainda podem quebrar clientes que rejeitam campos desconhecidos; teste a compatibilidade real. Ao depreciar um contrato, informe prazo, substituto e caminho de migracao em documentacao e respostas conforme o protocolo adotado.

## 7. Seguranca e documentacao

- Valide tipos, formato, tamanho e limites em toda entrada externa.
- Autorizacao deve considerar usuario, funcao, objeto e propriedade, no servidor.
- Evite tokens em URLs; proteja autenticacao e transporte.
- Aplique rate limits e limites de custo nos fluxos que podem ser abusados.
- Documente endpoints, esquemas, autenticacao, permissoes, erros e exemplos.
- OpenAPI e util quando multiplos consumidores precisam de um contrato formal; nao duplique documentacao manual sem necessidade.
- Verifique seguranca especifica para APIs em [OWASP API Security Top 10](https://api-security.owasp.org/editions/2023/en/).

## Checklist de API

- [ ] Metodos e status descrevem corretamente o efeito.
- [ ] Formatos de sucesso e erro sao consistentes e seguros.
- [ ] Autorizacao cobre recurso e campos, nao apenas a rota.
- [ ] Colecoes e buscas tem limites e allowlists.
- [ ] Retentativa, idempotencia e versao foram decididas conforme o contrato.
- [ ] Consumidores tem documentacao suficiente para operar e migrar.