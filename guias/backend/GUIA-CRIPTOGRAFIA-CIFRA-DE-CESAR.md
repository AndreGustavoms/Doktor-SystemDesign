# Guia Criptografia Cifra de Cesar

> **O que **: Um guia reutilizvel para estruturar sistemas de **cifra tradicional**, **cifra numrica**, **normalizao de acentos** e **interface web interativa** baseados na Cifra de Csar.
>
> **De onde vem**: Este padro foi extrado do projeto **Cifra de Csar em Python**.
>
> **Qual  o propsito dentro de `guias/`**: Registrar os subsistemas tcnicos reaproveitveis do projeto como blocos prontos para uso em outros produtos educacionais, ferramentas de codificao e interfaces web leves.
>
> **Quando usar**: Apps de aprendizado de criptografia, mini-backends de transformao de texto, exerccios de segurana bsica, demos web com Python no navegador e ferramentas de encode/decode para uso interno.
>
> **Origem da implementao**: Os caminhos citados abaixo pertencem ao repositrio original e so usados aqui como rastreabilidade tcnica.
>
> **Leitura correta deste documento**: Isto no  uma spec hipottica;  a consolidao de sistemas reais j implementados e testados em uso prtico.

Este documento isola os sistemas que mais agregam reuso no projeto de origem, separando domnio de criptografia, contrato de transformao, normalizao textual e camada de interface.

---

## 1. Origem, Contexto e Escopo de Reuso

### 1.1 Fontes principais da implementao de origem

- `src/cifra_tradicional/cifra_cesar_completa.py`
- `src/cifra_tradicional/decodificador_cifra_tradicional.py`
- `src/cifra_numerica/codificador_decodificador_numerico.py`
- `src/cifra_numerica/decodificador_mensagem_numerica.py`
- `src/ferramentas/utils_normalizacao.py`
- `src/ferramentas/deslocamento_alfabeto_interativo.py`
- `docs/index.html`

### 1.2 Sistemas extrados para reuso

1. **Sistema de cifra tradicional** (texto -> texto cifrado -> texto original).
2. **Sistema de cifra numrica** (texto -> lista numrica -> texto original).
3. **Sistema de normalizao de acentos** (compatibilidade com alfabeto base `a-z`).
4. **Sistema de interface web integrada** com mltiplas ferramentas na mesma tela.

### 1.3 O que pode ser reaproveitado quase sem mudana

- Funes de deslocamento de alfabeto.
- Fluxo de cifrar/decifrar com chave.
- Contrato de codificao numrica com preservao de espao, dgitos e pontuao.
- Normalizao de texto acentuado para base latina simples.
- Estrutura de UI por abas para cifrar/decifrar/codificar/decodificar/consultar.

---

## 2. Sistema 1: Cifra Tradicional Reutilizvel

### 2.1 Papel

Realiza substituio alfabtica por deslocamento, mantendo espaos e pontuao.

### 2.2 Fluxo padro

```text
mensagem
  -> normalizar_texto()
  -> deslocar_alfabeto(chave)
  -> mapear cada letra pelo alfabeto deslocado
  -> sada cifrada
```

### 2.3 Contratos teis

- `deslocar_alfabeto(deslocamento: int) -> str`
- `cifrar_mensagem(mensagem: str, alfabeto_deslocado: str) -> str`
- `decifrar_mensagem(mensagem_cifrada: str, alfabeto_deslocado: str) -> str`

### 2.4 Quando aplicar

- Exerccios de criptografia clssica.
- Jogos com mensagens secretas.
- Mdulos introdutrios de segurana da informao.

### 2.5 Implementao de referncia (copiar e colar)

Cumpre os contratos da seo 2.3 e preserva espaos, dgitos e pontuao. Verificada por testes (seo 6-A). A entrada deve passar antes por `normalizar_texto` (seo 4.5).

```python
import string

ALFABETO_BASE = string.ascii_lowercase  # a-z


def deslocar_alfabeto(deslocamento: int) -> str:
    """Retorna o alfabeto a-z deslocado. Ex.: 3 -> 'defghi...abc'."""
    d = deslocamento % 26
    return ALFABETO_BASE[d:] + ALFABETO_BASE[:d]


def cifrar_mensagem(mensagem: str, alfabeto_deslocado: str) -> str:
    """Substitui cada letra pela posio equivalente no alfabeto deslocado."""
    mapa = dict(zip(ALFABETO_BASE, alfabeto_deslocado))
    return "".join(mapa.get(c, c) for c in mensagem)


def decifrar_mensagem(mensagem_cifrada: str, alfabeto_deslocado: str) -> str:
    """Operao inversa de `cifrar_mensagem`, com o mesmo alfabeto deslocado."""
    mapa_inverso = dict(zip(alfabeto_deslocado, ALFABETO_BASE))
    return "".join(mapa_inverso.get(c, c) for c in mensagem_cifrada)
```

Exemplo de uso:

```python
alfabeto = deslocar_alfabeto(3)
cifrada = cifrar_mensagem("ataque ao amanhecer", alfabeto)   # "dwdtxh dr dpdqkhfhu"
original = decifrar_mensagem(cifrada, alfabeto)              # "ataque ao amanhecer"
```

---

## 3. Sistema 2: Cifra Numrica Reutilizvel

### 3.1 Papel

Converte texto em sequncia numrica com alfabeto deslocado e consegue reconstruir a mensagem original.

### 3.2 Contrato de codificao observado

| Tipo de entrada | Sada |
|---|---|
| Letras | `1..26` (conforme alfabeto deslocado) |
| Espao | `0` |
| Dgitos | `-0` at `-9` (string) |
| Smbolos/pontuao | `-(100 + ord(char))` (string) |

### 3.3 Fluxo padro

```text
texto
  -> normalizar_texto()
  -> criar_ordem_personalizada(chave)
  -> conversao()
  -> lista mista (int + string)

lista mista + chave
  -> criar_alfabeto_deslocado(chave)
  -> criar_mapeamento_inverso()
  -> decodificar_numeros()
  -> texto original
```

### 3.4 Valor de reuso

- Boa base para protocolos simples de troca de mensagens.
- Mantm fidelidade de formatao (espaos, nmeros e smbolos).
- Facilita debug por exibir converso item a item.

### 3.5 Implementao de referncia (copiar e colar)

Implementa exatamente o contrato da tabela 3.2  o detalhe mais fcil de errar  a distino entre `int` (letras e espao) e `str` (dgitos e smbolos). Depende de `deslocar_alfabeto` (seo 2.5) e `normalizar_texto` (seo 4.5). Verificada por testes de ida e volta (seo 6-A).

```python
def codificar_numerico(texto: str, chave: int) -> list:
    """Converte texto em lista mista (int + str) conforme o contrato 3.2."""
    alfabeto = deslocar_alfabeto(chave)
    saida = []
    for c in normalizar_texto(texto):
        if c == " ":
            saida.append(0)
        elif c.isdigit():
            saida.append(f"-{c}")
        elif c in alfabeto:
            saida.append(alfabeto.index(c) + 1)
        else:
            saida.append(str(-(100 + ord(c))))
    return saida


def decodificar_numerico(codigos: list, chave: int) -> str:
    """Reconstri o texto original a partir da lista mista e da chave."""
    alfabeto = deslocar_alfabeto(chave)
    saida = []
    for codigo in codigos:
        if isinstance(codigo, int):
            saida.append(" " if codigo == 0 else alfabeto[codigo - 1])
        else:
            valor = int(codigo)  # strings: "-7" (dgito) ou "-133" (smbolo)
            if -9 <= valor <= 0:
                saida.append(str(-valor))
            else:
                saida.append(chr(-valor - 100))
    return "".join(saida)
```

---

## 4. Sistema 3: Normalizao de Acentos Reutilizvel

### 4.1 Papel

Garante compatibilidade entre entrada em portugus/espanhol e algoritmos baseados em `a-z`.

### 4.2 Contratos

- `normalizar_texto(texto: str) -> str`
- `mostrar_conversoes(texto_original: str) -> tuple[str, list[str]]`

### 4.3 Mapa principal coberto

- Vogais acentuadas (``, ``, ``, ``, ``, etc.) -> vogais base.
- `` -> `c`
- `` -> `n`
- Entrada convertida para minsculas.

### 4.4 Uso recomendado

- Sempre aplicar antes de cifrar/decifrar quando o algoritmo depender de alfabeto latino simples.
- Mostrar feedback de converso para transparncia com usurio final.

### 4.5 Implementao de referncia (copiar e colar)

```python
MAPA_ACENTOS = {
    "": "a", "": "a", "": "a", "": "a", "": "a",
    "": "e", "": "e", "": "e", "": "e",
    "": "i", "": "i", "": "i", "": "i",
    "": "o", "": "o", "": "o", "": "o", "": "o",
    "": "u", "": "u", "": "u", "": "u",
    "": "c", "": "n",
}


def normalizar_texto(texto: str) -> str:
    """Converte para minsculas e troca caracteres acentuados pela base a-z."""
    return "".join(MAPA_ACENTOS.get(c, c) for c in texto.lower())


def mostrar_conversoes(texto_original: str) -> tuple[str, list[str]]:
    """Normaliza e lista cada converso feita, para feedback ao usurio."""
    conversoes = []
    resultado = []
    for c in texto_original.lower():
        novo = MAPA_ACENTOS.get(c, c)
        if novo != c:
            conversoes.append(f"{c} -> {novo}")
        resultado.append(novo)
    return "".join(resultado), conversoes
```

---

## 5. Sistema 4: Interface Web Integrada (Brython)

### 5.1 Papel

Entrega as funcionalidades principais em uma nica interface por abas:

1. Cifrar tradicional
2. Decifrar tradicional
3. Codificar numrico
4. Decodificar numrico
5. Consultar alfabeto deslocado

### 5.2 Caractersticas arquiteturais

- Pgina nica (`docs/index.html`) com HTML/CSS/Brython.
- Lgica de criptografia executada no navegador.
- Feedback imediato de validao e resultados.
- Suporte a tema claro/escuro e uso responsivo.

### 5.3 Quando reaproveitar

- Prototipagem de ferramentas educacionais.
- Demos sem dependncia de backend.
- Produtos que precisem de laboratrio interativo de texto.

---

## 6. Blueprint de extrao para outros projetos

```text
src/
  crypto/
    caesar.py
    numeric_codec.py
  text/
    normalization.py
  ui/
    web_playground/
tests/
  unit/
  integration/
```

Separao recomendada:

- `crypto/`: regras de domnio (puras).
- `text/`: transformao e saneamento de entrada.
- `ui/`: camada de interao (CLI/web).

Mapeamento das implementaes de referncia deste guia para o blueprint:

| Seo | Funes | Destino sugerido |
|-------|---------|------------------|
| 2.5 | `deslocar_alfabeto`, `cifrar_mensagem`, `decifrar_mensagem` | `crypto/caesar.py` |
| 3.5 | `codificar_numerico`, `decodificar_numerico` | `crypto/numeric_codec.py` |
| 4.5 | `normalizar_texto`, `mostrar_conversoes` | `text/normalization.py` |

---

## 6-A. Testes prontos (verificados)

Sute mnima para `tests/unit/`, executada e aprovada contra as implementaes das sees 2.5, 3.5 e 4.5.

```python
def test_deslocar_alfabeto():
    assert deslocar_alfabeto(3) == "defghijklmnopqrstuvwxyzabc"
    assert deslocar_alfabeto(29) == deslocar_alfabeto(3)  # mdulo 26


def test_cifrar_e_decifrar_preserva_original():
    alfabeto = deslocar_alfabeto(3)
    cifrada = cifrar_mensagem("ataque ao amanhecer", alfabeto)
    assert cifrada == "dwdtxh dr dpdqkhfhu"
    assert decifrar_mensagem(cifrada, alfabeto) == "ataque ao amanhecer"


def test_cifra_preserva_espacos_digitos_pontuacao():
    assert cifrar_mensagem("sala 42!", deslocar_alfabeto(5)) == "xfqf 42!"


def test_normalizar_texto():
    assert normalizar_texto("Ao  Noite") == "acao a noite"
    assert normalizar_texto("El Nio") == "el nino"


def test_codificacao_numerica_contrato():
    # chave 0: a=1 ... z=26; espao=0; dgito="-N"; smbolo="-(100+ord)"
    assert codificar_numerico("ab 7!", 0) == [1, 2, 0, "-7", str(-(100 + ord("!")))]


def test_codificacao_numerica_ida_e_volta():
    original = "mensagem secreta 123, ok!"
    assert decodificar_numerico(codificar_numerico(original, 11), 11) == original


def test_codificacao_numerica_com_acentos():
    # a normalizao  irreversvel: "Ao" volta como "acao"
    assert decodificar_numerico(codificar_numerico("Ao", 4), 4) == "acao"
```

---

## 7. Riscos e limites do padro

1. Cifra de Csar  fraca para segurana real (poucas chaves possveis).
2. Normalizao remove acento de forma irreversvel.
3. Duplicao de lgica entre mdulos pode surgir se no houver extrao para funes compartilhadas.

Para uso real com dados sensveis, tratar este sistema como educacional e combinar com criptografia moderna.

---

## 8. Resumo Executivo

Os sistemas da **Cifra de Csar em Python** formam um pacote reaproveitvel com quatro blocos claros: cifra tradicional, cifra numrica, normalizao de acentos e interface web integrada. Em conjunto, eles servem como referncia slida para construir ferramentas educacionais de criptografia, playgrounds web e utilitrios de transformao textual com boa experincia de uso e baixo custo de adoo.

---
