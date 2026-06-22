# Checklist de Publicacao

Use este checklist antes de tornar o Doktor System-Design publico, divulgar como referencia ou instalar em outros projetos.

## Identidade

- [x] Definir autor publico: Andre Gustavo Melo da Silva / AndreGustavoms.
- [x] Confirmar nome publico: `Doktor System-Design`.
- [x] Confirmar stack como baseline tecnica do repositorio, nao preferencia pessoal publica.
- [x] Manter atribuicao da origem em `NOTICE.md` e `LICENSE`.

## Conteudo

- [x] Revisar `README.md` como porta de entrada.
- [x] Revisar `AGENTS.md` como roteiro de uso por IA.
- [x] Revisar `docs/STACK-E-ARQUITETURA.md` como baseline tecnica.
- [x] Revisar `docs/DECISOES-DE-IDENTIDADE.md` e remover pendencias que ja foram decididas.
- [x] Criar guia rapido de uso pratico.
- [x] Criar templates copiaveis de README, IA, deploy, seguranca e ADR.
- [x] Criar checklist de projeto pronto.
- [x] Revisar guias backend opcionais principais para melhorar escrita e remover texto herdado.
- [ ] Revisar guias novos/importados futuros conforme `docs/CURADORIA-DOS-GUIAS.md`.

## Scripts

- [ ] Validar `scripts/powershell/install-doktor-powershell.ps1` no PowerShell. Parser conferido; falta teste de instalacao real.
- [ ] Validar `scripts/cmd/install-doktor-cmd.cmd` e `scripts/cmd/doktor-command.cmd` no CMD. Help e uninstall conferidos; falta teste de instalacao real.
- [ ] Validar `scripts/bash-zsh/install-doktor-bash-zsh.sh` em Bash/Zsh real.
- [ ] Rodar o comando `doktor` em uma pasta temporaria e confirmar que sincroniza sem apagar arquivos fora do destino.
- [x] Registrar roteiro e estado em `docs/VALIDACAO-SCRIPTS.md`.

## Qualidade

- [x] Rodar varredura por identidade herdada fora de `LICENSE` e `NOTICE.md`.
- [x] Rodar varredura por texto quebrado ou caracteres de substituicao.
- [x] Conferir links relativos em documentos principais.
- [x] Confirmar que `IA.md` reflete o estado atual.
- [x] Adicionar validador local `scripts/validate-repo.ps1`.
- [x] Adicionar CI simples em GitHub Actions.
- [ ] Fazer commit coeso com mensagem `docs: ...`, `feat: ...` ou `chore: ...`.

## Publicacao

- [ ] Conferir remoto Git correto.
- [ ] Conferir branch atual.
- [ ] Fazer push.
- [ ] Abrir o README no GitHub e verificar renderizacao das tabelas e links.
- [ ] Criar tag `v0.1.0` apos confirmar remoto correto.
