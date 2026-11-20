# AGENTS.md - Roteiro de IA do Projeto

> Copie e adapte este arquivo como AGENTS.md na raiz do projeto. Mantenha-o curto e aponte para documentos que existem no repositorio.

## 1. Leitura inicial

1. Leia core/GUIA_MINIMO_QUALIDADE.md.
2. Leia o resumo vivo de IA.md se existir; consulte o historico apenas quando necessario.
3. Use o README para conhecer o objetivo, comandos e convencoes.
4. Abra somente os guias aplicaveis ao escopo. Tarefas simples costumam precisar de 1-2 documentos alem do guia minimo; tarefas amplas ou de alto risco podem precisar de mais.
5. Procure scripts e comandos existentes antes de criar ferramentas ou alterar dados.

## 2. Roteiro por tarefa

| Tarefa | Documento inicial |
|---|---|
| Frontend, UI ou UX | core/DESIGN_SYSTEM_FRONTEND.md |
| Backend, dados ou regra de negocio | core/DESIGN_SYSTEM_BACKEND.md |
| API HTTP | core/DESIGN_SYSTEM_API_REST.md |
| Arquitetura ou fronteiras | core/DESIGN_SYSTEM_ARQUITETURA.md |
| Modularidade ou refatoracao | core/DESIGN_SYSTEM_MODULARIDADE.md |
| Seguranca ou privacidade | core/DESIGN_SYSTEM_SEGURANCA.md |
| Testes e verificacao | core/DESIGN_SYSTEM_TESTES.md |
| Performance | core/DESIGN_SYSTEM_PERFORMANCE.md |
| README ou documentacao | core/DESIGN_SYSTEM_README.md |
| Stack ou decisao de arquitetura | docs/STACK-E-ARQUITETURA.md |
| Padrao tecnico atual | docs/REFERENCIAS-TECNICAS.md |
| Entrada e comandos de execucao | core/GUIA-START-APP-SCRIPT.md |
| Projeto novo | docs/GUIA-RAPIDO-USO.md |

Use um guia de guias/ somente quando a funcionalidade correspondente estiver no escopo.

## 3. Regras de trabalho

- Preserve a stack e os contratos existentes quando atendem ao pedido.
- Escolha arquitetura, dependencias, testes e verificacoes pelo contexto e pelo risco.
- Nao trate limites de linhas, cobertura percentual ou stack de exemplo como requisito universal.
- Em interfaces, considere telas, zoom, teclado, foco, toque, conteudo e preferencias do publico.
- Valide dados e permissoes em fronteiras de confianca; mantenha segredos fora do codigo e logs.
- Confirme APIs e dependencias na documentacao da versao instalada.
- Execute verificacoes relevantes e reporte a saida real; indique limites que nao foram verificados.
- Atualize README, IA.md, contratos e documentos afetados quando uso ou comportamento mudar.
- Preserve o historico de IA.md; acrescente registros quando decisoes mudarem.
- Nunca publique segredo, dado pessoal ou caminho local privado em documentacao.

## 4. Criterio de pronto

Outra pessoa deve conseguir entender:

- o que mudou e por que;
- como executar e configurar;
- como validar;
- quais decisoes, riscos ou limites importam.