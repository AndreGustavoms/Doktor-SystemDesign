# Guia Backend CPF

> **O que **: Um guia reutilizvel para estruturar um backend pequeno, testvel e seguro para **gerao, validao e normalizao de CPF**.
>
> **De onde vem**: Este padro foi extrado da implementao Python do projeto **Gerador de CPF Vlido em Python**.
>
> **Qual  o propsito dentro de `guias/`**: Registrar essa lgica como um bloco backend reaproveitvel do `Doktor System-Design`, separando algoritmo, contratos, testes e guardrails de dados do produto original.
>
> **Quando usar**: APIs, formulrios, scripts, automaes, servios internos ou fluxos de QA que precisem gerar, validar, sanitizar ou testar CPF com segurana.
>
> **Origem da implementao**: Os caminhos e mdulos citados neste documento pertencem  estrutura do projeto original, fora deste repositrio, e aparecem aqui apenas como rastreabilidade tcnica.
>
> **Leitura correta deste documento**: Isto no  uma spec hipottica;  a consolidao de um backend lgico real que pode ser transportado para outros sistemas.

Este documento no tenta explicar todo o projeto original. O foco aqui  isolar o padro de backend para CPF como um artefato reutilizvel, deixando claro o que pode ser reaproveitado, adaptado, testado e protegido em outros contextos.

---

## 1. Origem, Contexto e Reuso

### 1.1 Origem do Documento

Este material foi extrado e consolidado a partir da implementao Python original do projeto **Gerador de CPF Vlido em Python**, fora deste repositrio. O contedo tcnico veio principalmente dos seguintes arquivos na estrutura da implementao-base:

- `Verso no terminal/Gerador de CPF.py`
- `Verso no terminal/Gerador de CPF por Regio.py`
- `Verso no terminal/Validador de CPF.py`

As referncias a esses arquivos neste documento existem apenas para **rastreabilidade da origem**. Elas no indicam que esses caminhos existam dentro do `Doktor System-Design`.

### 1.2 Contexto de Origem

O projeto-base no possui backend web, banco de dados nem API. Ainda assim, ele contm uma camada Python suficientemente clara para ser tratada como backend lgico, porque centraliza:

- regras de negcio;
- clculo determinstico;
- validao de entrada;
- formatao de sada;
- contratos reutilizveis de retorno.

### 1.3 O Que  Reutilizvel em Outros Projetos

Os elementos abaixo podem ser copiados para outro projeto quase sem alterao:

- algoritmo de clculo dos dgitos verificadores;
- regra do 9 dgito para regio fiscal;
- limpeza e validao do CPF;
- contrato de retorno de `validar_cpf()`;
- matriz de testes automatizados;
- guardrails para uso de dados reais.

### 1.4 O Que Deve Ser Adaptado em Outro Projeto

Os elementos abaixo pertencem ao contexto da implementao-base e devem ser renomeados ou adaptados:

- nomes de arquivos e mdulos;
- funes de `print()` e `input()`;
- formato de logs;
- estratgia de persistncia;
- integrao com API, fila, formulrio ou banco;
- poltica de tratamento de dados sensveis.

### 1.5 Estrutura Sugerida para Uso Externo

Ao reaproveitar este padro em outro projeto, a organizao recomendada :

```text
src/
  domain/
    cpf_rules.py
  services/
    cpf_generator.py
    cpf_validator.py
  contracts/
    cpf_result.py
tests/
  unit/
  integration/
  contract/
```

### 1.6 Como Ler Este Documento

- As sees conceituais so genricas e podem ser reutilizadas diretamente.
- As sees com nomes de arquivo representam a **implementao de origem**.
- O ideal  copiar este documento para outro projeto e trocar apenas o mapeamento da implementao.

---

## 2. Viso Geral da Camada Python

### 2.1 Arquivos da Implementao de Origem

| Arquivo | Papel |
|---------|-------|
| `Verso no terminal/Gerador de CPF.py` | Gerao aleatria de CPF vlido |
| `Verso no terminal/Gerador de CPF por Regio.py` | Gerao de CPF vlido com regio fiscal controlada |
| `Verso no terminal/Validador de CPF.py` | Validao de CPF com ou sem formatao |

### 2.2 Arquitetura Lgica

```text
Entrada
  -> preparao dos dados
  -> clculo dos dgitos verificadores
  -> identificao da regio fiscal
  -> formatao ou validao
  -> sada textual
```

### 2.3 Tipos de Funo

- **Puras**: clculo, formatao, limpeza, mapa de regies.
- **Randmicas**: gerao de dgitos com `random.randint`.
- **Orquestradoras**: encadeiam o fluxo completo.
- **I/O**: `print()` e `input()`.

Essa diviso define a estratgia de testes:

- funes puras -> testes unitrios;
- funes orquestradoras -> integrao;
- funes de I/O -> testes com captura de entrada e sada.

---

## 3. Regras de Negcio do CPF

### 3.1 Estrutura

- O CPF final possui **11 dgitos**.
- Os **9 primeiros** so a base numrica.
- O **10** e o **11** so dgitos verificadores.
- O formato final usado no padro  `XXX.XXX.XXX-XX`.

### 3.2 Primeiro Dgito Verificador

1. Multiplicar os 9 primeiros dgitos pelos pesos de `10` at `2`.
2. Somar os resultados.
3. Calcular `resto = soma % 11`.
4. Se `resto < 2`, o dgito  `0`.
5. Caso contrrio, o dgito  `11 - resto`.

### 3.3 Segundo Dgito Verificador

1. Anexar o primeiro verificador aos 9 dgitos base.
2. Multiplicar os 10 valores pelos pesos de `11` at `2`.
3. Somar os resultados.
4. Calcular `resto = soma % 11`.
5. Se `resto < 2`, o dgito  `0`.
6. Caso contrrio, o dgito  `11 - resto`.

### 3.4 Regio Fiscal

O **9 dgito** identifica a regio fiscal:

| Dgito | Regio |
|--------|--------|
| `0` | RS |
| `1` | DF, GO, MT, MS, TO |
| `2` | AC, AM, AP, PA, RO, RR |
| `3` | CE, MA, PI |
| `4` | AL, PB, PE, RN |
| `5` | BA, SE |
| `6` | MG |
| `7` | ES, RJ |
| `8` | SP |
| `9` | PR, SC |

### 3.5 Regras de Validao

- Remover caracteres no numricos antes de validar.
- Exigir exatamente 11 dgitos aps limpeza.
- Rejeitar sequncias repetidas, como `11111111111`.
- Recalcular os verificadores e comparar com os informados.

### 3.6 Invariantes para Testes

- Todo CPF formatado deve casar com `^\d{3}\.\d{3}\.\d{3}-\d{2}$`.
- O gerador por regio deve manter a regio escolhida no 9 dgito.
- `validar_cpf()` deve sempre retornar `(bool, dict)`.

---

## 3-A. Implementao de Referncia (copiar e colar)

Mdulo nico e autossuficiente que implementa todas as regras da seo 3 e os contratos das sees 4 e 5. O cdigo abaixo **passa na matriz de testes da seo 7.3**  copie como `src/domain/cpf.py` (ou equivalente) e adapte apenas nomes e integrao.

```python
"""Mdulo de domnio para CPF: gerao, validao e normalizao."""

import random
import re

REGIOES_FISCAIS = {
    0: "RS (Rio Grande do Sul)",
    1: "DF, GO, MT, MS, TO",
    2: "AC, AM, AP, PA, RO, RR",
    3: "CE, MA, PI",
    4: "AL, PB, PE, RN",
    5: "BA, SE",
    6: "MG (Minas Gerais)",
    7: "ES, RJ",
    8: "SP (So Paulo)",
    9: "PR, SC (Paran, Santa Catarina)",
}


# ---------- Funes puras ----------

def calcular_primeiro_digito(digitos: list[int]) -> int:
    """Calcula o 1 dgito verificador a partir dos 9 dgitos base."""
    soma = sum(d * peso for d, peso in zip(digitos, range(10, 1, -1)))
    resto = soma % 11
    return 0 if resto < 2 else 11 - resto


def calcular_segundo_digito(digitos: list[int], primeiro_digito: int) -> int:
    """Calcula o 2 dgito verificador a partir dos 9 dgitos + 1 verificador."""
    todos = digitos + [primeiro_digito]
    soma = sum(d * peso for d, peso in zip(todos, range(11, 1, -1)))
    resto = soma % 11
    return 0 if resto < 2 else 11 - resto


def identificar_regiao_fiscal(digitos: list[int]) -> tuple[int, str]:
    """L o 9 dgito e retorna (dgito, descrio da regio fiscal)."""
    nono = digitos[8]
    return nono, REGIOES_FISCAIS[nono]


def formatar_cpf(digitos: list[int], digito1: int, digito2: int) -> str:
    """Aplica a mscara XXX.XXX.XXX-XX."""
    base = "".join(str(d) for d in digitos)
    return f"{base[:3]}.{base[3:6]}.{base[6:9]}-{digito1}{digito2}"


def limpar_cpf(cpf: str) -> str:
    """Remove tudo que no for nmero."""
    return re.sub(r"\D", "", cpf)


def validar_formato(cpf_limpo: str) -> tuple[bool, str]:
    """Valida tamanho e rejeita sequncias repetidas como 11111111111."""
    if len(cpf_limpo) != 11:
        return False, "CPF deve ter exatamente 11 dgitos"
    if cpf_limpo == cpf_limpo[0] * 11:
        return False, "CPF com todos os dgitos iguais  invlido"
    return True, ""


# ---------- Funes randmicas ----------

def gerar_nove_digitos() -> list[int]:
    """Gera os 9 dgitos base aleatrios."""
    return [random.randint(0, 9) for _ in range(9)]


def gerar_nove_digitos_com_regiao(regiao_escolhida: int) -> list[int]:
    """Gera 8 dgitos aleatrios e fixa o 9 com a regio fiscal escolhida."""
    return [random.randint(0, 9) for _ in range(8)] + [regiao_escolhida]


# ---------- Orquestradoras ----------

def gerar_cpf_valido(regiao: int | None = None) -> str:
    """Gera um CPF vlido formatado; com `regiao`, fixa a regio fiscal."""
    if regiao is None:
        digitos = gerar_nove_digitos()
    else:
        digitos = gerar_nove_digitos_com_regiao(regiao)
    d1 = calcular_primeiro_digito(digitos)
    d2 = calcular_segundo_digito(digitos, d1)
    return formatar_cpf(digitos, d1, d2)


def validar_cpf(cpf: str) -> tuple[bool, dict]:
    """Valida um CPF (com ou sem mscara). Contrato fixo: (bool, dict)."""
    cpf_limpo = limpar_cpf(cpf)
    formato_ok, erro = validar_formato(cpf_limpo)
    if not formato_ok:
        return False, {"erro": erro}

    digitos = [int(d) for d in cpf_limpo[:9]]
    d1 = calcular_primeiro_digito(digitos)
    d2 = calcular_segundo_digito(digitos, d1)
    informados = cpf_limpo[9:]
    corretos = f"{d1}{d2}"
    if informados != corretos:
        return False, {
            "erro": "Dgitos verificadores invlidos",
            "verificadores_informados": informados,
            "verificadores_corretos": corretos,
        }

    nono, regiao_fiscal = identificar_regiao_fiscal(digitos)
    return True, {
        "cpf_formatado": formatar_cpf(digitos, d1, d2),
        "nove_primeiros": " ".join(cpf_limpo[:9]),
        "primeiro_verificador": d1,
        "segundo_verificador": d2,
        "nono_digito": nono,
        "regiao_fiscal": regiao_fiscal,
    }
```

Opes de adaptao comuns:

- **API REST**: exponha `validar_cpf()` num endpoint e serialize o `dict` do contrato como JSON.
- **Formulrio**: chame `limpar_cpf()` + `validar_cpf()` na entrada do backend, nunca apenas no frontend.
- **Massa de teste**: use `gerar_cpf_valido()` (com ou sem regio) para fixtures sintticas, respeitando os guardrails da seo 8.

---

## 4. Mapeamento da Implementao de Origem

Esta seo documenta a implementao-base de onde o padro foi derivado. Em outro projeto, substitua os nomes de arquivo por seus mdulos equivalentes, mas preserve os contratos e as regras de negcio.

## 4.1 `Verso no terminal/Gerador de CPF.py`

| Funo | Tipo | Responsabilidade | Entrada -> Sada | Foco de teste |
|--------|------|------------------|------------------|---------------|
| `gerar_nove_digitos()` | Randmica | Gera os 9 dgitos base | `None -> list[int]` | tamanho `9`, valores `0-9` |
| `calcular_primeiro_digito(digitos)` | Pura | Calcula o 1 verificador | `list[int] -> int` | caso fixo `123456789 -> 0` |
| `calcular_segundo_digito(digitos, primeiro_digito)` | Pura | Calcula o 2 verificador | `list[int], int -> int` | caso fixo `123456789 + 0 -> 9` |
| `identificar_regiao_fiscal(digitos)` | Pura | L o 9 dgito e retorna a regio | `list[int] -> tuple[int, str]` | `digitos[8]` coerente com o mapa |
| `formatar_cpf(digitos, digito1, digito2)` | Pura | Aplica a mscara do CPF | `list[int], int, int -> str` | `123456789,0,9 -> 123.456.789-09` |
| `exibir_mensagem_geracao(...)` | I/O | Mostra o processo completo no terminal | argumentos -> `None` | captura de `stdout` |
| `gerar_cpf_valido()` | Orquestradora | Executa o fluxo completo e retorna o CPF | `None -> str` | regex final e coerncia interna |

### Fluxo do Mdulo

```text
gerar_nove_digitos
  -> calcular_primeiro_digito
  -> calcular_segundo_digito
  -> formatar_cpf
  -> exibir_mensagem_geracao
```

## 4.2 `Verso no terminal/Gerador de CPF por Regio.py`

| Funo | Tipo | Responsabilidade | Entrada -> Sada | Foco de teste |
|--------|------|------------------|------------------|---------------|
| `obter_regioes_fiscais()` | Pura | Retorna o mapa oficial usado pelo projeto | `None -> dict[int, str]` | 10 chaves, de `0` a `9` |
| `exibir_menu_regioes()` | I/O | Exibe o menu de escolha da regio | `None -> None` | captura de `stdout` |
| `solicitar_regiao()` | I/O | Valida a entrada interativa do usurio | `stdin -> int` | aceitar `0-9`, rejeitar texto e fora da faixa |
| `gerar_oito_digitos_aleatorios()` | Randmica | Gera os 8 dgitos livres | `None -> list[int]` | tamanho `8`, valores `0-9` |
| `gerar_nove_digitos_com_regiao(regiao_escolhida)` | Randmica | Fecha a base com o dgito da regio | `int -> list[int]` | `digitos[8] == regiao_escolhida` |
| `calcular_primeiro_digito(digitos)` | Pura | Calcula o 1 verificador | `list[int] -> int` | mesmo contrato do gerador simples |
| `calcular_segundo_digito(digitos, primeiro_digito)` | Pura | Calcula o 2 verificador | `list[int], int -> int` | mesmo contrato do gerador simples |
| `formatar_cpf(digitos, digito1, digito2)` | Pura | Aplica a mscara | `list[int], int, int -> str` | regex final |
| `exibir_resultado(...)` | I/O | Mostra CPF, regio e detalhes do clculo | argumentos -> `None` | captura de `stdout` |
| `perguntar_gerar_novamente()` | I/O | Controla a repetio do fluxo | `stdin -> bool` | aceitar `S/SIM/Y/YES` e `N/NAO/NO/NO` |
| `gerar_cpf_por_regiao()` | Orquestradora | Coordena o fluxo interativo completo | `None -> None` | integrao com `input()` simulado |

### Fluxo do Mdulo

```text
obter_regioes_fiscais
  -> solicitar_regiao
  -> gerar_nove_digitos_com_regiao
  -> calcular_primeiro_digito
  -> calcular_segundo_digito
  -> formatar_cpf
  -> exibir_resultado
  -> perguntar_gerar_novamente
```

## 4.3 `Verso no terminal/Validador de CPF.py`

| Funo | Tipo | Responsabilidade | Entrada -> Sada | Foco de teste |
|--------|------|------------------|------------------|---------------|
| `limpar_cpf(cpf)` | Pura | Remove tudo que no for nmero | `str -> str` | `123.456.789-09 -> 12345678909` |
| `validar_formato(cpf_limpo)` | Pura | Valida tamanho e repetio | `str -> tuple[bool, str]` | comprimento diferente de `11` e sequncia repetida |
| `calcular_primeiro_digito(digitos)` | Pura | Recalcula o 1 verificador | `list[int] -> int` | caso fixo conhecido |
| `calcular_segundo_digito(digitos, primeiro_digito)` | Pura | Recalcula o 2 verificador | `list[int], int -> int` | caso fixo conhecido |
| `identificar_regiao_fiscal(digitos)` | Pura | Descobre a regio pelo 9 dgito | `list[int] -> tuple[int, str]` | coerncia com o mapa |
| `validar_cpf(cpf)` | Pura de alto nvel | Coordena toda a validao | `str -> tuple[bool, dict]` | entrada limpa e mascarada devem gerar o mesmo resultado |
| `exibir_resultado(cpf_original, valido, informacoes)` | I/O | Exibe sucesso ou falha com explicao | argumentos -> `None` | captura de `stdout` |
| `solicitar_cpf()` | I/O | L o CPF digitado no terminal | `stdin -> str` | preservar o valor informado |
| `perguntar_validar_novamente()` | I/O | Controla repetio do fluxo | `stdin -> bool` | aceitar variantes de sim e no |
| `main()` | Orquestradora | Executa o ciclo completo do validador | `None -> None` | integrao do fluxo completo |

### Contrato de Retorno de `validar_cpf(cpf)`

Formato fixo:

```python
(bool, dict)
```

Casos esperados:

```python
False, {"erro": "..."}  # erro de formato

False, {
    "erro": "Dgitos verificadores invlidos",
    "verificadores_informados": "00",
    "verificadores_corretos": "09"
}

True, {
    "cpf_formatado": "123.456.789-09",
    "nove_primeiros": "1 2 3 4 5 6 7 8 9",
    "primeiro_verificador": 0,
    "segundo_verificador": 9,
    "nono_digito": 9,
    "regiao_fiscal": "PR, SC (Paran, Santa Catarina)"
}
```

### Fluxo do Mdulo

```text
solicitar_cpf
  -> limpar_cpf
  -> validar_formato
  -> calcular_primeiro_digito
  -> calcular_segundo_digito
  -> comparar verificadores
  -> identificar_regiao_fiscal
  -> exibir_resultado
```

---

## 5. Contratos de Dados do Backend

### 5.1 Mapa de Regies

O mapa de regies  uma dependncia central do projeto e aparece em mais de um arquivo. Para fins de System Design, ele deve ser tratado como **contrato de domnio**.

### 5.2 CPF Formatado

Toda sada formatada precisa respeitar:

```text
XXX.XXX.XXX-XX
```

### 5.3 Retorno do Validador

O retorno de `validar_cpf()` deve ser usado como contrato para:

- testes automatizados;
- futuras APIs;
- formulrios que usem essa lgica no backend;
- logs e observabilidade.

---

## 6. Fluxos de Backend

## 6.1 Gerao Aleatria

1. Gerar 9 dgitos.
2. Calcular o primeiro verificador.
3. Calcular o segundo verificador.
4. Formatar o CPF.
5. Identificar a regio fiscal.
6. Exibir e retornar o resultado.

## 6.2 Gerao por Regio

1. Ler a regio escolhida.
2. Gerar 8 dgitos aleatrios.
3. Fixar o 9 dgito com a regio.
4. Calcular os verificadores.
5. Formatar o CPF.
6. Exibir o resultado.

## 6.3 Validao

1. Ler a entrada.
2. Limpar a formatao.
3. Validar tamanho e repetio.
4. Recalcular verificadores.
5. Comparar com os informados.
6. Retornar sucesso ou falha estruturada.

---

## 7. Padro Reutilizvel de Testes Automatizados

### 7.1 Pirmide Recomendada

| Camada | O que validar |
|--------|---------------|
| **Unitrio** | clculo, formatao, limpeza, mapa de regies |
| **Contrato** | formato do retorno de `validar_cpf()` |
| **Integrao** | fluxo completo dos geradores e do validador |
| **I/O** | mensagens e interao com `input()` e `print()` |

### 7.2 Template de Caso de Teste

```markdown
ID:
Funo ou fluxo:
Tipo de teste:
Entrada:
Ao:
Sada esperada:
Regra validada:
```

### 7.3 Casos Base Reutilizveis

| ID | Alvo | Cenrio | Resultado esperado |
|----|------|---------|-------------------|
| `UT-01` | `gerar_nove_digitos()` | gerao bsica | lista com 9 inteiros entre `0` e `9` |
| `UT-02` | `gerar_nove_digitos_com_regiao(8)` | regio fixa | 9 dgito igual a `8` |
| `UT-03` | `calcular_primeiro_digito()` | base `123456789` | retorno `0` |
| `UT-04` | `calcular_segundo_digito()` | base `123456789` + `0` | retorno `9` |
| `UT-05` | `formatar_cpf()` | mscara | `123.456.789-09` |
| `UT-06` | `limpar_cpf()` | entrada com pontuao | somente nmeros |
| `UT-07` | `validar_formato()` | CPF curto | invlido |
| `UT-08` | `validar_formato()` | sequncia repetida | invlido |
| `CT-01` | `validar_cpf()` | CPF vlido | `(True, dict)` com chaves obrigatrias |
| `CT-02` | `validar_cpf()` | dgitos verificadores errados | `(False, dict)` com comparativo |
| `IT-01` | `gerar_cpf_valido()` | fluxo completo | string final formatada |
| `IT-02` | `validar_cpf("123.456.789-09")` | entrada mascarada | mesmo resultado da entrada limpa |

### 7.4 Exemplo de Teste Unitrio

```python
def test_formatar_cpf():
    digitos = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert formatar_cpf(digitos, 0, 9) == "123.456.789-09"
```

### 7.5 Exemplo de Assert Estrutural para Aleatoriedade

```python
assert len(digitos) == 9
assert all(0 <= d <= 9 for d in digitos)
assert re.match(r"^\d{3}\.\d{3}\.\d{3}-\d{2}$", cpf)
```

### 7.6 Sute Pronta (pytest)

Cobertura completa da matriz da seo 7.3, pronta para `tests/unit/test_cpf.py`. Verificada contra a implementao da seo 3-A.

```python
"""Matriz de testes do backend de CPF (UT, CT e IT)."""

import re

from cpf import (
    calcular_primeiro_digito,
    calcular_segundo_digito,
    formatar_cpf,
    gerar_cpf_valido,
    gerar_nove_digitos,
    gerar_nove_digitos_com_regiao,
    limpar_cpf,
    validar_cpf,
    validar_formato,
)

FORMATO = r"^\d{3}\.\d{3}\.\d{3}-\d{2}$"
BASE = [1, 2, 3, 4, 5, 6, 7, 8, 9]


def test_ut01_gerar_nove_digitos():
    digitos = gerar_nove_digitos()
    assert len(digitos) == 9
    assert all(0 <= d <= 9 for d in digitos)


def test_ut02_gerar_com_regiao():
    assert gerar_nove_digitos_com_regiao(8)[8] == 8


def test_ut03_primeiro_digito():
    assert calcular_primeiro_digito(BASE) == 0


def test_ut04_segundo_digito():
    assert calcular_segundo_digito(BASE, 0) == 9


def test_ut05_formatar_cpf():
    assert formatar_cpf(BASE, 0, 9) == "123.456.789-09"


def test_ut06_limpar_cpf():
    assert limpar_cpf("CPF: 123.456.789-09 ") == "12345678909"


def test_ut07_formato_curto():
    assert validar_formato("1234567890")[0] is False


def test_ut08_sequencia_repetida():
    assert validar_formato("11111111111")[0] is False


def test_ct01_cpf_valido():
    valido, info = validar_cpf("123.456.789-09")
    assert valido is True
    assert info["cpf_formatado"] == "123.456.789-09"
    assert info["regiao_fiscal"].startswith("PR, SC")


def test_ct02_verificadores_errados():
    valido, info = validar_cpf("123.456.789-00")
    assert valido is False
    assert info["verificadores_informados"] == "00"
    assert info["verificadores_corretos"] == "09"


def test_it01_fluxo_completo():
    cpf = gerar_cpf_valido()
    assert re.match(FORMATO, cpf)
    assert validar_cpf(cpf)[0] is True


def test_it02_mascarada_equivale_limpa():
    assert validar_cpf("123.456.789-09") == validar_cpf("12345678909")
```

---

## 8. Uso de Casos Reais e Preveno com Dados Reais

### 8.1 Casos Reais que Devem Virar Cenrios de Teste

Use casos inspirados em operao real, mas sem expor CPF verdadeiro no repositrio:

| Categoria | Exemplo de entrada | Uso em teste |
|-----------|--------------------|--------------|
| **Entrada mascarada** | `123.456.789-09` | validar limpeza e equivalncia com entrada limpa |
| **Entrada sem mscara** | `12345678909` | validar fluxo bruto |
| **Entrada com espaos** | `123 456 789 09` | validar normalizao |
| **Entrada colada com rudo** | `CPF: 123.456.789-09` | validar remoo de caracteres extras |
| **Erro de digitao** | `123.456.789-00` | validar divergncia de dgitos verificadores |
| **Tamanho incorreto** | `1234567890` | validar rejeio por comprimento |
| **Sequncia repetida** | `11111111111` | validar bloqueio de caso artificial comum |
| **Zeros  esquerda** | base iniciando em `0` | garantir que a lgica no perca posio |

### 8.2 Regra para Uso de Dados Reais

Para testes e preveno, a ordem correta :

1. **Preferir dados sintticos** gerados pelo prprio sistema.
2. Quando precisar de comportamento realista, usar **casos reais sanitizados**.
3. S usar dado real identificvel quando houver necessidade formal, controle de acesso e base legal adequada.

### 8.3 Guardrails para Dados Reais

- Nunca commitar CPF real em `fixtures`, `README`, documentao ou logs.
- Nunca exibir CPF real completo em mensagem de erro, print de monitoramento ou screenshot compartilhado.
- Preferir mascaramento, como `***.***.***-09`, em ambientes no produtivos.
- Se um caso real precisar ser preservado para anlise, tokenizar ou hashear antes de armazenar.
- Limitar acesso a massas sensveis por perfil e ambiente.
- Definir reteno curta para amostras operacionais.
- Seguir a LGPD e a poltica interna de dados da aplicao que consumir essa lgica.

### 8.4 Preveno Operacional para Sistemas que Reutilizarem Este Backend

Se esta lgica for colocada atrs de uma API, fila ou formulrio real, recomenda-se:

- validar e normalizar o CPF na entrada do backend;
- mascarar CPF em logs;
- armazenar somente quando houver necessidade real de negcio;
- separar massa de produo e massa de homologao;
- criar alertas para excesso de tentativas invlidas;
- registrar mtricas agregadas, no documentos completos;
- revisar permisses de quem pode consultar ou exportar dados.

### 8.5 Padro Reutilizvel

```text
caso real observado
  -> sanitizao
  -> transformao em cenrio de teste
  -> execuo automatizada
  -> preveno de vazamento em logs, fixtures e documentao
```

---

## 9. Riscos e Oportunidades Tcnicas

1. **Lgica duplicada**
   - O clculo do CPF est replicado em vrios arquivos.
   - A recomendao  extrair um mdulo compartilhado, como `core/cpf.py`.

2. **Gerador vs. validador**
   - O gerador no bloqueia, explicitamente, sequncias repetidas.
   - O validador rejeita esse caso.
   - Isso deve entrar como observao de robustez em testes futuros.

3. **Reuso em sites e formulrios**
   - O backend atual j est pronto para virar servio, funo compartilhada ou biblioteca interna.
   - O contrato mais importante para esse reuso  `validar_cpf(cpf) -> (bool, dict)`.

---

## 10. Resumo Executivo

Este backend  pequeno, mas j contm um padro completo de domnio:

- gerao de dados;
- clculo determinstico;
- validao estruturada;
- identificao semntica da regio;
- sada formatada e testvel.

Por isso, ele pode ser reutilizado como base para:

- testes automatizados;
- servios internos;
- APIs futuras;
- validaes em sites e formulrios que consumam essa lgica no backend.

---
