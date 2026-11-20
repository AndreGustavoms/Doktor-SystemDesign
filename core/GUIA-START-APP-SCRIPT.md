# Entrada e Execucao do Projeto

Este guia ajuda a escolher uma entrada de desenvolvimento simples e reproduzivel. Um projeto nao precisa de um launcher extra quando seus comandos nativos ja sao claros.

## 1. Escolha a entrada certa

Use o comando que combina com a forma de distribuir e operar o software:

| Tipo de projeto | Entrada comum |
|---|---|
| Aplicacao web local para desenvolvimento | Script do gerenciador de pacotes, comando do framework ou Makefile |
| Ferramenta CLI | Comando instalado, modulo executavel ou subcomandos documentados |
| Biblioteca ou SDK | Importacao e exemplos; sem launcher de aplicacao |
| Servico/container | Comando de processo, imagem e compose/manifest quando aplicavel |
| Automacao agendada | CLI ou job com configuracao nao interativa |
| App desktop para publico iniciante | Launcher ou instalador com orientacao visual, se reduzir atrito |
| Prototipo local com muitas acoes de setup | Menu interativo opcional |

## 2. Quando criar start_app.py

Um `start_app.py` pode ser util em um projeto Python local com setup ou processos que seriam dificeis de descobrir. Crie-o quando houver uma pessoa usuaria que se beneficia de um menu e quando ele puder orquestrar os comandos sem esconder como o sistema funciona.

Nao crie launcher Python obrigatorio para uma biblioteca, pacote, container, CI, worker ou script simples. Nao substitua uma CLI programavel por um menu que impede automacao. Evite instalar dependencias ou alterar o ambiente silenciosamente.

Se houver menu, explique cada acao, mostre falhas de modo legivel e ofereca um caminho nao interativo para CI e usuarios avancados. O launcher deve delegar a scripts e comandos mantidos, nao concentrar logica de negocio.

## 3. O que documentar

O README deve apresentar comandos reais e separados por intencao:

- pre-requisitos e setup;
- execucao local;
- configuracao;
- testes e validacao;
- build, deploy ou publicacao quando aplicavel;
- diagnostico de problemas comuns.

Prefira o gerenciador de pacotes ou ferramenta ja adotada no projeto. Mantenha os comandos cross-platform quando o publico e multiplataforma; se diferirem, mostre cada variante.

## Checklist de entrada

- [ ] A primeira forma de executar combina com o tipo de projeto.
- [ ] Setup, execucao e validacao podem ser repetidos em ambiente limpo.
- [ ] O README mostra comandos existentes e nao presume interface visual.
- [ ] Um launcher adicional reduz atrito suficiente para justificar sua manutencao.
- [ ] CI e usuarios avancados podem executar comandos sem interacao.