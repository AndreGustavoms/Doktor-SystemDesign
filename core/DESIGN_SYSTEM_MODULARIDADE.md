# Design System Modularidade

> Este documento orienta a escolha de fronteiras para funcoes, arquivos e modulos. Modularidade e uma ferramenta para limitar acoplamento e facilitar mudancas, nao uma meta de quantidade de arquivos.

## 1. O que torna um modulo bom

Um modulo coeso agrupa comportamento que muda junto, protege detalhes que nao precisam ser publicos e oferece uma interface compreensivel. O tamanho e secundario a esses tres sinais.

Prefira separar quando:

- duas partes mudam por motivos diferentes;
- um detalhe de infraestrutura precisa ser substituivel ou testavel;
- uma regra aparece duplicada;
- a interface publica virou ampla demais;
- nomes genericos escondem conteudo sem relacao;
- ler ou alterar um trecho exige entender muito estado nao relacionado.

Mantenha junto quando separar criaria modulos que apenas repassam chamadas, pastas vazias, muitos arquivos triviais ou navegacao pior.

## 2. Responsabilidade unica como heuristica

Pergunte: "Uma pessoa consegue descrever o papel deste modulo em uma frase clara?" Se a resposta listar tarefas sem relacao, procure uma fronteira melhor. A regra nao exige exatamente uma funcao, classe, hook, tipo ou componente por arquivo.

Co-localize o que muda junto: componente e estilos, testes e fixture, tipos locais e implementacao. Extraia apenas quando a reutilizacao, o comportamento ou a mudanca independente justificar.

## 3. Nomes e APIs

- Nomeie pelo conceito ou comportamento, nao pelo local temporario de uso.
- Prefira uma API pequena e exemplos proximos ao uso.
- Evite pastas deposito e objetos com muitas responsabilidades.
- Pastas `utils/`, `common/` ou `shared/` podem ser uteis, mas precisam de criterio de entrada e responsabilidade clara.
- Nao crie wrappers que apenas repetem a assinatura da dependencia sem acrescentar semantica, politica ou isolamento.

## 4. Tamanho e legibilidade

Nao existe limite universal de linhas que detecta baixa coesao. Use tamanho como sinal para revisar, nao como falha automatica.

Revise um modulo grande quando for dificil localizar a regra, compreender o fluxo, revisar uma mudanca ou escrever um teste. Revise um conjunto de modulos pequenos quando a mudanca exigir navegar entre muitos arquivos sem fronteira clara.

Complexidade ciclomatica, acoplamento, coesao, tamanho de diff e frequencia de mudancas podem complementar a leitura humana; nenhum indicador sozinho decide a refatoracao.

## 5. Leitura focada e custo de contexto

Abra primeiro os arquivos relacionados a tarefa, os contratos das dependencias e os testes pertinentes. Expanda a leitura quando uma fronteira ou efeito colateral exigir. A meta e reduzir leitura irrelevante sem ignorar contexto necessario para uma mudanca segura.

Nao use modularidade para esconder fluxo entre dezenas de arquivos. Mantenha o caminho principal facil de seguir e documente contratos que cruzam fronteiras.

## 6. Refatoracao segura

1. Identifique o atrito observavel ou risco.
2. Localize quem usa o modulo e quais contratos estao expostos.
3. Defina a nova fronteira antes de mover codigo.
4. Mova um comportamento por vez quando o risco for alto.
5. Preserve comportamento ou documente a mudanca.
6. Rode as verificacoes relevantes ao risco e compare a saida observada.
7. Remova compatibilidade temporaria quando o plano de migracao permitir.

Evite reestruturar arquivos sem relacao com a tarefa.

## Checklist de modularidade

- [ ] Cada modulo tem nome, papel e ownership compreensiveis.
- [ ] A separacao evita acoplamento, duplicacao ou mudanca coordenada sem necessidade.
- [ ] Abstracoes existentes escondem complexidade ou representam um conceito real.
- [ ] O caminho principal e rastreavel sem pular por arquivos triviais.
- [ ] Dependencias e contratos relevantes foram revistos.
- [ ] O tamanho foi avaliado junto com coesao e complexidade, sem corte arbitrario.
- [ ] A refatoracao tem verificacao proporcional ao risco.