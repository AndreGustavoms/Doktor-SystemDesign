# Guia Scraping Multiformato

## Quando usar

Use este guia quando um projeto precisar transformar paginas, feeds ou APIs heterogeneas em dados estruturados com auditoria, limites operacionais e testes.

Casos comuns:

- catalogos;
- comparadores;
- ETLs;
- importadores;
- inventarios tecnicos;
- monitoramento de precos;
- captura de dados publicos autorizados;
- consolidacao de fontes que alternam HTML, JSON, RSS/Atom e paginas renderizadas por JavaScript.

## Quando nao usar

Nao use este padrao para:

- contornar autenticacao;
- reutilizar cookies, sessoes ou tokens sem autorizacao;
- coletar dados pessoais sem base legitima;
- ignorar termos de uso, limites ou robots quando aplicavel;
- burlar bloqueios agressivamente;
- salvar HTML sensivel em repositorio;
- criar scraper sem limite de paginas, tempo, bytes e itens.

## Resultado esperado

Ao aplicar este guia, o projeto deve ter:

- DTO puro;
- adapter por fonte;
- parser offline testavel;
- pipeline com fallback;
- fixtures sanitizadas;
- dry-run por padrao;
- checkpoint para coletas longas;
- persistencia idempotente;
- URL publica segura separada da URL de coleta;
- logs sem segredos;
- criterios objetivos de pronto.

## Atalho de leitura

Este guia e um catalogo de metodos, nao uma leitura unica obrigatoria. Leia os contratos gerais e somente o caminho que corresponde a tarefa:

| Preciso resolver | Leia |
|---|---|
| Delimitar escopo, limites e arquitetura | Secoes 1-7 e 17-20 |
| Obter HTML/JSON estatico | Secoes 8, 10 e 12-14 |
| Consumir API oficial, feed ou quota | Secoes 10-D a 10-G e 13-18 |
| Usar endpoint JSON nao documentado | Secao 10-A somente com autorizacao e termos permitidos |
| Renderizacao JavaScript, scroll ou captura manual | Secoes 9, 10-B, 10-C e 11 |
| Persistencia, retomada e auditoria | Secoes 10-G e 13-20 |

Nao leia os exemplos de todos os metodos quando a tarefa usa apenas um.

## Regra central

Scraping de qualidade nao e "pegar HTML de qualquer jeito". E uma arquitetura auditavel, testavel, limitada por guardrails, respeitosa com autorizacoes e preparada para falhar de forma segura.

## 1. Escopo do padrao

Este guia cobre:

- coleta via HTTP simples;
- consumo de API oficial documentada (JSON) com paginacao por numero de pagina;
- consumo de endpoint JSON nao documentado somente quando autorizado e permitido pelos termos da fonte;
- coleta de feed RSS/Atom (XML) com parser offline e zero dependencia externa;
- autenticacao em APIs oficiais: API key, OAuth Client Credentials, com segredos so do ambiente;
- gestao de quota e rate-limit (`Retry-After`, backoff exponencial, escolha de endpoint barato);
- coleta retomavel por checkpoint apos interrupcao/estouro de quota;
- resolucao de URL publica para entidade interna (endpoint `/resolve`);
- paginacao por cursor (`next_href` / `linked_partitioning`) e resolucao em duas etapas (item so com id);
- navegacao com Playwright;
- coleta por scroll infinito com botao "carregar mais" (Selenium ou Playwright);
- parsers offline com BeautifulSoup ou equivalente;
- leitura de JSON embutido em paginas modernas;
- adapter strategy por fonte/layout;
- pipeline com fallback entre metodos (mais facil -> mais caro) e falha segura;
- importacao de HTML salvo;
- captura manual assistida por navegador real;
- normalizacao de URLs publicas;
- persistencia idempotente;
- historico de mudancas;
- testes com fixtures sanitizadas;
- limites operacionais, seguranca e auditoria.

Este guia nao cobre:

- contorno agressivo de bloqueios;
- bypass de autenticacao;
- uso de cookies, sessoes ou tokens sem autorizacao;
- coleta de dados pessoais sem base legitima;
- armazenamento de HTML sensivel em repositorio;
- dependencia de seletores fragilizados sem teste.

---

## 2. Stack recomendada

```text
Versao de Python suportada pelo projeto e pelas bibliotecas escolhidas
urllib (stdlib) ou Requests/httpx para I/O HTTP
Playwright (ou Selenium) para navegador real
BeautifulSoup4 para parser de HTML
json (stdlib) para parser de API/JSON embutido
xml.etree.ElementTree (stdlib) para feeds RSS/Atom
base64 (stdlib) para credenciais Basic em OAuth Client Credentials
Django ORM ou camada de persistencia equivalente
PostgreSQL em producao
SQLite como fallback local
pytest/unittest
fixtures HTML/JSON reais sanitizadas
Tampermonkey/userscript opcional
Servidor HTTP local para captura assistida
```

Regra pratica (do metodo mais barato para o mais caro):

- Use **API oficial documentada** quando ela existir - e a fonte mais estavel e respeitosa; pagina por numero ou cursor e pode exigir autenticacao (ver secoes 10-D e 10-F).
- Use **feed RSS/Atom (XML)** quando a fonte publicar um feed publico - parser offline, sem credenciais, zero dependencia (ver secao 10-E).
- Use endpoint JSON nao documentado somente quando houver autorizacao e os termos permitirem automacao. O front-end da pagina usar o endpoint nao concede, por si so, permissao nem estabilidade de contrato (ver secao 10-A).
- Use **requests/httpx + parser offline** quando o HTML ja trouxer os dados.
- Use **JSON embutido na pagina** quando o DOM vier vazio mas os dados estiverem em `__NEXT_DATA__`, JSON-LD ou payload serializado.
- Use **Playwright/Selenium** quando a pagina depender de JavaScript, lazy loading, popup, scroll infinito, paginacao dinamica ou interacao humana.
- Use **captura manual assistida** quando a coleta automatica for instavel, proibida pelo contexto operacional ou depender de acao humana autorizada.
- Use **persistencia idempotente** sempre que o resultado puder ser reprocessado.

Sempre que houver mais de um metodo possivel, organize-os num **pipeline com fallback** (secao 10-C): tenta o mais barato primeiro e so cai para o proximo se ele nao trouxer resultado.

---

## 3. Arquitetura de pastas

```text
scraper_module/
  main.py
  requirements.txt
  README.md
  src/
    config.py
    models.py
    browser.py
    registry.py
    flows/
      listing.py
      pagination.py
      product_page.py
    adapters/
      base.py
      official_api.py    # API oficial documentada em JSON (paginacao/auth)
      rss_feed.py        # feed RSS/Atom (XML) com parser offline, sem credencial
      authorized_json.py # endpoint JSON permitido pela fonte (sem navegador)
      browser.py         # navegador real (Selenium/Playwright) como fallback
      example_source.py
    pipeline.py          # orquestra os metodos com fallback e falha segura
    checkpoint.py        # estado de retomada (fora do controle de versao)
    manual_html/
      importer.py
    html_capture/
      capture_server.py
      userscript.js
    persistence.py
    public_url_resolver.py
    parsing/
      prices.py
      json_payloads.py
      text.py
    reports/
      summary.py
  tests/
    fixtures/
      example_source/
        listing.html
        listing.meta.json
    test_adapters_example_source.py
    test_manual_importer.py
    test_capture_server.py
    test_public_url_resolver.py
    test_persistence.py
```

Responsabilidades:

| Camada | Responsabilidade |
|---|---|
| `config` | Env vars, limites, modo headless/headed, fontes ativas, dry-run e paths |
| `models` | DTOs puros, sem ORM e sem dependencia de framework |
| `browser` | Context manager Playwright, timeouts, user agent, lifecycle e screenshots de debug |
| `flows` | Fluxos comuns de navegacao, descoberta, popup, paginacao e fallback |
| `adapters` | Um adapter por fonte/metodo (JSON autorizado, HTTP, navegador), todos sob a mesma interface |
| `pipeline` | Ordem de tentativa dos metodos (mais barato -> fallback) e falha segura |
| `manual_html` | Importacao offline de HTML salvo em disco |
| `html_capture` | Servidor local e userscript para captura manual autorizada |
| `persistence` | Unica ponte com ORM/banco, upsert, dedupe e historico |
| `public_url_resolver` | URL canonica segura para exibicao externa |
| `tests` | Fixtures sanitizadas e validacao offline dos contratos |

---

## 4. Contrato de DTO

DTO e o contrato entre coleta, parser, persistencia e consumidor. Ele deve ser puro.

```python
from dataclasses import dataclass, field
from decimal import Decimal


@dataclass
class ProductDTO:
    external_id: str
    title: str
    product_url: str
    price: Decimal
    public_url: str = ""
    image_url: str = ""
    original_price: Decimal | None = None
    discount_percent: Decimal | None = None
    rating: Decimal | None = None
    review_count: int | None = None
    coupon_code: str = ""
    coupon_discount: Decimal | None = None
    category_hint: str = ""
    source_slug: str = ""
    capture_source: str = ""
    extras: dict = field(default_factory=dict)
```

Regras obrigatorias:

1. DTO nao importa Django, SQLAlchemy, Playwright, BeautifulSoup, API externa nem camada de UI.
2. `external_id` precisa ser estavel por produto dentro da fonte.
3. `product_url` guarda a URL usada/coletada e pode conter tracking ou contexto sensivel.
4. `public_url` guarda a URL segura para exibicao externa.
5. Se nao houver URL publica segura, `public_url` deve ficar vazia e o produto deve ser bloqueado para publicacao.
6. Campos opcionais devem continuar opcionais para permitir fontes heterogeneas.
7. `extras` so deve guardar dados nao essenciais; nao use como lixeira para contrato mal definido.

---

## 5. Interface Strategy para adapters

Cada fonte/layout deve implementar uma interface unica. O nucleo nao deve saber detalhes de seletores, JSON interno ou regras de URL de cada site.

```python
from abc import ABC, abstractmethod


class SourceAdapter(ABC):
    slug: str = ""
    display_name: str = ""

    @abstractmethod
    def extract_products(self, page, listing_url: str, limit: int) -> list[ProductDTO]:
        """Extrai produtos usando navegador real quando necessario."""

    def extract_products_from_html(
        self,
        html: str,
        base_url: str,
        limit: int,
    ) -> list[ProductDTO]:
        """Parser offline para fixtures, HTML salvo e fallback manual."""
        raise NotImplementedError

    def extract_single_product(self, page, product_url: str) -> list[ProductDTO]:
        """Opcional: paginas que apontam direto para um produto."""
        page.goto(product_url, wait_until="domcontentloaded", timeout=30000)
        return self.extract_products_from_html(page.content(), product_url, 1)

    def derive_public_url(self, source_url: str) -> str:
        """Retorna URL canonica segura para publicacao externa. Vazio = bloqueado."""
        return ""
```

Beneficio:

- adicionar fonte nova exige criar adapter novo e registrar no registry;
- o nucleo permanece fechado para modificacao frequente;
- os testes podem validar cada parser offline sem browser;
- seletores quebrados ficam isolados na fonte afetada.

---

## 6. Registry de fontes

Use um registry explicito para evitar `if/else` espalhado.

```python
from src.adapters.example_source import ExampleSourceAdapter


ADAPTERS = {
    ExampleSourceAdapter.slug: ExampleSourceAdapter(),
}


def get_adapter(slug: str):
    try:
        return ADAPTERS[slug]
    except KeyError as exc:
        known = ", ".join(sorted(ADAPTERS))
        raise ValueError(f"Fonte desconhecida: {slug}. Fontes: {known}") from exc
```

Regras:

1. `slug` e identificador tecnico estavel.
2. `display_name` e nome humano.
3. Adapter novo precisa de fixture e teste offline.
4. O registry deve ser o unico ponto de descoberta das fontes suportadas.

---

## 7. Configuracao e limites

Centralize configuracao em `config.py`.

```python
from dataclasses import dataclass
import os
from pathlib import Path


@dataclass(frozen=True)
class ScraperConfig:
    headless: bool = os.getenv("SCRAPER_HEADLESS", "1") != "0"
    max_products: int = int(os.getenv("SCRAPER_MAX_PRODUCTS", "100"))
    max_pages: int = int(os.getenv("SCRAPER_MAX_PAGES", "5"))
    page_size: int = int(os.getenv("SCRAPER_PAGE_SIZE", "50"))          # itens por pagina na API
    timeout_ms: int = int(os.getenv("SCRAPER_TIMEOUT_MS", "30000"))
    scroll_rounds: int = int(os.getenv("SCRAPER_SCROLL_ROUNDS", "5"))   # rodadas sem novidade ate parar (navegador)
    scroll_pause_s: float = float(os.getenv("SCRAPER_SCROLL_PAUSE_MS", "4000")) / 1000.0
    dry_run: bool = os.getenv("SCRAPER_DRY_RUN", "1") != "0"
    debug_dir: Path = Path(os.getenv("SCRAPER_DEBUG_DIR", "debug_html"))
    manual_html_dir: Path = Path(os.getenv("SCRAPER_MANUAL_HTML_DIR", "manual_html"))
```

Todo pipeline deve ter:

- limite de paginas (paginacao por numero **e** por cursor);
- limite de produtos/itens;
- limite de tempo (timeout por requisicao/navegacao);
- limite de rodadas de scroll para o navegador;
- limite de bytes para captura manual;
- modo dry-run por padrao em importadores;
- logs objetivos com contadores, incluindo o metodo de coleta usado;
- saida em JSON para auditoria quando fizer sentido.

---

## 8. HTML estatico com parser offline

Use parser offline quando o HTML ja trouxer cards completos.

Boas praticas:

1. Use seletor primario especifico.
2. Tenha fallback por links, atributos semanticos ou JSON-LD.
3. Normalize preco em funcao separada.
4. Descarte item sem titulo, URL ou preco.
5. Deduplicate por `external_id`.
6. Resolva URLs relativas com `urljoin`.
7. Guarde fixture HTML sanitizada para teste.

Exemplo:

```python
from bs4 import BeautifulSoup
from urllib.parse import urljoin


class ExampleSourceAdapter(SourceAdapter):
    slug = "example"
    display_name = "Example Source"

    def extract_products(self, page, listing_url: str, limit: int) -> list[ProductDTO]:
        page.goto(listing_url, wait_until="domcontentloaded", timeout=30000)
        return self.extract_products_from_html(page.content(), listing_url, limit)

    def extract_products_from_html(
        self,
        html: str,
        base_url: str,
        limit: int,
    ) -> list[ProductDTO]:
        soup = BeautifulSoup(html, "html.parser")
        products: list[ProductDTO] = []

        for card in soup.select("[data-product-card]"):
            title_el = card.select_one("[data-product-title]")
            link_el = card.select_one("a[href]")
            price_el = card.select_one("[data-price]")

            if not title_el or not link_el or not price_el:
                continue

            product_url = urljoin(base_url, link_el["href"])
            external_id = self._derive_external_id(product_url)
            public_url = self.derive_public_url(product_url)

            products.append(
                ProductDTO(
                    external_id=external_id,
                    title=title_el.get_text(" ", strip=True),
                    product_url=product_url,
                    public_url=public_url,
                    price=parse_price(price_el.get_text(" ", strip=True)),
                    source_slug=self.slug,
                    capture_source="html",
                )
            )

            if len(products) >= limit:
                break

        return dedupe_products(products)
```

---

## 9. Paginas client-rendered com Playwright

Use Playwright quando conteudo depender de JavaScript, lazy loading, popup, scroll ou paginacao dinamica.

Boas praticas:

1. Navegue com `domcontentloaded`.
2. Espere seletor relevante quando existir.
3. Use `networkidle` apenas como best-effort.
4. Execute scroll incremental quando houver lazy loading.
5. Capture `page.content()` e reaproveite o parser offline.
6. Salve HTML de debug local quando nenhum item for extraido.
7. Exponha modo `--headed` para diagnostico humano.
8. Nao use Playwright para parsing quando BeautifulSoup resolve.

Exemplo de browser isolado:

```python
from contextlib import contextmanager
from playwright.sync_api import sync_playwright


@contextmanager
def open_browser(config):
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=config.headless)
        context = browser.new_context(
            viewport={"width": 1366, "height": 768},
            ignore_https_errors=False,
        )
        try:
            yield context
        finally:
            context.close()
            browser.close()
```

Fluxo recomendado:

```python
def collect_listing(adapter, listing_url: str, config):
    with open_browser(config) as context:
        page = context.new_page()
        page.goto(listing_url, wait_until="domcontentloaded", timeout=config.timeout_ms)

        try:
            page.wait_for_selector("[data-product-card]", timeout=5000)
        except Exception:
            pass

        scroll_page(page, max_rounds=3)
        html = page.content()
        products = adapter.extract_products_from_html(html, listing_url, config.max_products)

        if not products:
            save_debug_html(config.debug_dir, adapter.slug, listing_url, html)

        return products
```

---

## 10. JSON embutido em paginas modernas

Muitas paginas renderizam DOM vazio, mas embutem dados em scripts.

Fontes comuns:

- `script#__NEXT_DATA__` em Next.js;
- JSON-LD `application/ld+json`;
- payloads de streaming/RSC;
- objetos globais serializados;
- atributos `data-*` com blobs JSON.

Padrao recomendado:

1. Ler HTML bruto.
2. Procurar payloads estruturados antes de depender de classe CSS volatil.
3. Coletar recursivamente objetos com campos caracteristicos.
4. Normalizar para DTO.
5. Usar DOM apenas como complemento quando JSON nao tiver preco, desconto ou imagem.

Exemplo de busca recursiva:

```python
def walk_json(value):
    if isinstance(value, dict):
        yield value
        for child in value.values():
            yield from walk_json(child)
    elif isinstance(value, list):
        for item in value:
            yield from walk_json(item)


def looks_like_product(obj: dict) -> bool:
    keys = {key.lower() for key in obj.keys()}
    return bool({"name", "title"} & keys) and bool({"price", "offers"} & keys)
```

Cuidados:

- JSON embutido pode conter dados demais; extraia apenas o necessario.
- Nao salve payload bruto se houver risco de dados pessoais ou tokens.
- Teste parser de JSON com fixture reduzida e sanitizada.

---

## 10-A. API JSON observada (somente quando autorizada)

A existencia de um endpoint que o front-end usa nao torna seu uso automatizado permitido nem
transforma esse endpoint em contrato estavel. Confirme autorizacao, termos e limites da fonte
antes de enviar requisicoes diretas. Se isso nao estiver claro, nao automatize o endpoint: use
uma API oficial, exportacao autorizada ou captura manual permitida.

Quando o uso estiver autorizado e nao exigir bypass de autenticacao, um endpoint JSON pode reduzir
o custo de parsing. A ordem de preferencia e: **API oficial documentada > feed publicado > endpoint
JSON explicitamente permitido > HTML autorizado > navegador/captura manual autorizados**.

O I/O HTTP pode ser feito so com a stdlib (`urllib`), sem dependencias extras, e **todo o parsing
deve ficar em funcoes puras** (recebem texto/JSON, devolvem dados) para serem testaveis offline.
O `http_get` abaixo e um exemplo minimo. Ele nao aplica politica de redirects: use-o sem credenciais
ou substitua-o por um cliente que valide o destino final e rejeite redirects para outra origem antes
de enviar headers de autenticacao.

```python
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen

def http_get(url: str, headers: dict | None = None, timeout: float = 30.0) -> str | None:
    """GET simples autorizado. Nao simula navegador nem contorna controles de acesso."""
    request_headers = {"Accept": "text/html,application/json"}
    request_headers.update(headers or {})
    req = Request(url, headers=request_headers)
    try:
        with urlopen(req, timeout=timeout) as response:
            return response.read().decode("utf-8", errors="replace")
    except (URLError, HTTPError, TimeoutError):
        return None
```

Use somente a autenticacao descrita pela documentacao ou autorizacao da fonte. Carregue segredos do
ambiente ou de um secret manager e envie-os pelo mecanismo documentado, normalmente um header; nao
extraia `client_id` de bundles nem reutilize credenciais de sessao. Nunca registre tokens, nem mesmo
prefixos. Registre apenas a fonte, o metodo e o estado da coleta.

### Resolucao de URL publica -> identificador do endpoint autorizado (`/resolve`)

A URL informada pode precisar ser convertida para um identificador pelo endpoint autorizado de
`resolve`. Codifique o parametro de query e passe headers de autenticacao conforme a documentacao;
nao inclua credenciais na URL. Sanitize a URL informada antes de encaminha-la e remova dados de
sessao, tokens e contexto privado (secao 14).

```python
import json
from urllib.parse import urlencode, urljoin, urlsplit


def is_allowed_api_url(url: str, allowed_hosts: set[str]) -> bool:
    try:
        parsed = urlsplit(url)
        return (
            parsed.scheme == "https"
            and parsed.hostname in allowed_hosts
            and parsed.username is None
            and parsed.password is None
        )
    except ValueError:
        return False


def resolve_url(public_url: str, headers: dict, timeout: float = 30.0) -> dict | None:
    query = urlencode({"url": public_url})
    api_url = f"https://api.exemplo.com/resolve?{query}"
    if not is_allowed_api_url(api_url, {"api.exemplo.com"}):
        return None
    request_headers = {**headers, "Accept": "application/json"}
    body = http_get(api_url, headers=request_headers, timeout=timeout)
    try:
        data = json.loads(body or "")
    except (ValueError, TypeError):
        return None
    return data if isinstance(data, dict) else None
```

### Paginacao por cursor (`next_href` / `linked_partitioning`)

Diferente da paginacao por numero de pagina (secao "flows"), algumas APIs devolvem um link `next_href`
para a proxima pagina. Este exemplo aceita links absolutos ou relativos e valida o host antes de
reutilizar headers de autenticacao. Para APIs que devolvem um cursor opaco (`next_cursor`, `after`),
monte a URL usando o parametro documentado e codifique-o com `urlencode`; nunca coloque credenciais
no cursor. Pare quando o cursor sumir, ao bater o limite de itens **ou** o limite de paginas.

```python
from urllib.parse import urljoin


def collect_paginated(first_url: str, headers: dict, allowed_hosts: set[str], config, log) -> list[str]:
    items: list[str] = []
    next_href = first_url
    page = 0
    if not is_allowed_api_url(next_href, allowed_hosts):
        log("URL inicial fora da origem autorizada; coleta cancelada.")
        return items
    while next_href and page < config.max_pages and len(items) < config.max_items:
        current_url = next_href
        request_headers = {**headers, "Accept": "application/json"}
        body = http_get(current_url, headers=request_headers, timeout=config.timeout_ms / 1000)
        if not body:
            log("Falha ao carregar pagina; encerrando coleta.")
            break
        page_urls, cursor = parse_collection_page(body)  # parser puro -> ([], None) em erro
        next_href = urljoin(current_url, cursor) if cursor else None
        items.extend(page_urls)
        page += 1
        log(f"Pagina {page}: +{len(page_urls)} (total {len(items)}).")
        if next_href:
            if not is_allowed_api_url(next_href, allowed_hosts):
                log("Cursor fora da origem autorizada; coleta encerrada.")
                break
            time.sleep(0.5)   # cortesia: nao martele a API
    return items[: config.max_items]
```

```python
import json


def parse_collection_page(payload: str) -> tuple[list[str], str | None]:
    """Parser puro. Em payload invalido devolve ([], None) - nunca dado parcial enganoso."""
    try:
        data = json.loads(payload)
    except (json.JSONDecodeError, TypeError):
        return [], None
    if not isinstance(data, dict):
        return [], None
    urls = [
        item["permalink_url"]
        for item in data.get("collection", []) or []
        if isinstance(item, dict) and item.get("permalink_url")
    ]
    cursor = data.get("next_href")
    return urls, cursor if isinstance(cursor, str) and cursor else None
```

### Resolucao em duas etapas (item so com id)

As vezes a listagem traz alguns itens completos e outros so com `id` (sem a URL/permalink). Resolva
os pendentes com uma chamada extra por item - respeitando o teto e parando cedo.

```python
from urllib.parse import quote


direct_urls, pending_ids, title = parse_set(body)     # parser puro
items = list(direct_urls)
for item_id in pending_ids:
    if len(items) >= config.max_items:
        break
    item_url = f"https://api.exemplo.com/items/{quote(item_id, safe='')}"
    if not is_allowed_api_url(item_url, {"api.exemplo.com"}):
        continue
    request_headers = {**headers, "Accept": "application/json"}
    body = http_get(item_url, headers=request_headers, timeout=timeout)
    permalink = parse_item_permalink(body or "")        # parser puro -> str | None
    if permalink:
        items.append(permalink)
```

Cuidados gerais com endpoint JSON autorizado:

- Sempre teto de paginas, itens e tempo; `time.sleep` curto entre chamadas.
- Parser sempre puro e fail-safe: JSON invalido -> lista vazia, nunca excecao vazando nem dado parcial.
- Guarde `capture_source` (ex.: `"http_api"`) no DTO para auditoria de origem.
- Fixtures de teste = JSON real **sanitizado** (sem tokens, ids privados, dados pessoais).

---

## 10-B. Scroll infinito com "carregar mais" (navegador)

Quando nao ha API e a listagem so cresce conforme o usuario rola/clica em "carregar mais", o
navegador precisa simular esse comportamento ate a pagina estabilizar. O padrao vale para Selenium e
Playwright: **clicar nos botoes de "mais", rolar ate o fim e parar quando a contagem nao mudar por N
rodadas** (em vez de um numero fixo de scrolls).

```python
_SHOW_MORE_SELECTORS = [
    "a.showMore", "button.showMore",
    "a[class*='ShowMore']", "button[class*='ShowMore']",
]


def scroll_and_collect(driver, css_selector: str, config):
    """Rola/clica em 'carregar mais' e coleta os elementos ate a contagem estabilizar."""
    from selenium.webdriver.common.by import By

    count = 0
    stable_rounds = 0
    elements = []

    while stable_rounds < config.scroll_rounds:    # para apos N rodadas sem novidade
        for sel in _SHOW_MORE_SELECTORS:
            for btn in driver.find_elements(By.CSS_SELECTOR, sel):
                if btn.is_displayed():
                    try:
                        btn.click()
                        time.sleep(config.scroll_pause_s)
                    except Exception:
                        pass

        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(config.scroll_pause_s)

        elements = driver.find_elements(By.CSS_SELECTOR, css_selector)
        if len(elements) == count:
            stable_rounds += 1
        else:
            count = len(elements)
            stable_rounds = 0      # houve novidade: zera o contador de estabilidade

    return elements
```

Boas praticas:

- Pare por **estabilidade** (contagem nao muda por N rodadas), nao por numero fixo de scrolls.
- Tenha varios seletores de "carregar mais" como fallback; eles mudam com frequencia.
- `scroll_rounds` e `scroll_pause_s` configuraveis por env var (paginas lentas precisam de pausa maior).
- Sempre um teto de itens, alem do teto de rodadas.
- Inicializacao do navegador com varias estrategias de fallback (driver bundled -> manager nativo ->
  manager via pip) torna a coleta robusta entre maquinas e dentro de executaveis empacotados.
- Importe o navegador **preguicosamente** (dentro da funcao): assim ele so e obrigatorio quando o
  fallback de navegador e realmente acionado, e o metodo HTTP/API roda sem ele instalado.

---

## 10-C. Pipeline com fallback entre metodos

Quando ha mais de um metodo de coleta, nao escolha um no `if/else`: organize-os num **pipeline
ordenado do mais barato/robusto para o mais caro** e tente cada um ate obter resultado. Somar um
metodo novo passa a ser so registrar mais um adapter na lista.

```python
def get_pipeline() -> list:
    """Metodos na ordem de tentativa: o mais facil/robusto primeiro."""
    return [AuthorizedJsonAdapter(), SeleniumAdapter()]   # JSON permitido -> navegador autorizado


def collect(target_url: str, spec, config, log) -> CollectResult:
    result = CollectResult()
    for adapter in get_pipeline():
        log(f"Tentando {adapter.display_name}...")
        try:
            items = adapter.collect(target_url, spec, config, log)
        except Exception as exc:
            log(f"{adapter.display_name} falhou: {exc}")
            items = []

        if items:
            urls = dedupe(items)
            result.urls = urls
            result.used_source = adapter.slug
            result.by_source[adapter.slug] = len(items)
            log(f"{adapter.display_name}: {len(urls)} item(ns) apos dedupe.")
            break    # o metodo mais barato ja resolveu; nao precisa do fallback

    if not result.urls:
        log("Nenhum metodo coletou itens.")    # falha segura: result.urls fica vazio
    return result
```

Regras:

1. Ordem explicita em `get_pipeline()` - a politica de fallback fica num unico lugar auditavel.
2. Cada adapter implementa a mesma interface (secao 5) e isola seus seletores/regras.
3. Excecao de um adapter **nao derruba o pipeline**: vira lista vazia e o proximo metodo assume.
4. **Falha segura**: se nenhum metodo coletar, devolve resultado vazio, nunca dado parcial enganoso.
5. Pare no primeiro metodo que trouxer resultado - nao gaste o metodo caro a toa.
6. Registre `used_source` e `by_source` para o resumo/auditoria (qual metodo realmente resolveu).

---

## 10-D. API oficial em JSON com paginacao por numero de pagina

Quando a fonte publica uma **API oficial documentada**, ela e a melhor opcao: estavel, respeitosa
com a fonte e sem depender de classes CSS nem de navegador. Muitas paginam por `page`/`per_page`
(em vez de cursor - secao 10-A): voce avanca a pagina ate vir uma pagina **vazia ou menor que o
tamanho cheio**, que sinaliza o fim.

```python
import json, time, urllib.error, urllib.request

PER_PAGE = 100
SLEEP_BETWEEN = 0.15


def fetch_json(url: str, headers: dict):
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req, timeout=30) as resp:
        return json.loads(resp.read())


def fetch_paginated(url_template: str, headers: dict) -> list:
    """Pagina por numero ate a pagina vir vazia ou menor que PER_PAGE.
    url_template contem {page} e {per_page}."""
    items: list = []
    page = 1
    while True:
        url = url_template.format(page=page, per_page=PER_PAGE)
        try:
            batch = fetch_json(url, headers)
        except urllib.error.HTTPError as e:
            if e.code in (400, 404):   # algumas APIs sinalizam o fim com 404
                break
            raise
        if not batch:
            break
        items.extend(batch)
        if len(batch) < PER_PAGE:      # pagina incompleta = ultima pagina
            break
        page += 1
        time.sleep(SLEEP_BETWEEN)      # cortesia entre paginas
    return items
```

Boas praticas:

- Trate o **fim** por pagina vazia **ou** menor que `per_page` **ou** `4xx` esperado - nunca por um
  numero fixo de paginas adivinhado.
- Para endpoints que devolvem tudo de uma vez, tenha uma variante `fetch_single` com retry/backoff.
- **Degrade com elegancia**: se um endpoint secundario (ex.: programas/categorias) falhar, derive o
  dado dos itens ja coletados em vez de abortar a coleta inteira.
- Quando a documentacao exigir User-Agent, use um identificador verdadeiro do projeto; nao simule um navegador.

---

## 10-E. Feed RSS/Atom (XML) com parser offline

Muitas fontes (podcasts, blogs, releases) publicam um **feed RSS/Atom publico**. E HTTP simples +
XML estatico: da para coletar so com a stdlib (`xml.etree.ElementTree`), **sem credenciais e sem
dependencia externa**, e o parser e totalmente offline/testavel.

Pontos de atencao especificos de feed:

1. **Namespaces** - campos uteis vivem em namespaces (`itunes:`, `content:`, `atom:`, `dc:`).
   Mapeie-os e resolva o nome qualificado ao buscar.
2. **Paginacao Atom** - feeds longos encadeiam paginas via `<atom:link rel="next">`; siga ate sumir
   ou repetir a URL atual (guarda contra loop).
3. **Datas RFC 2822** - `pubDate` vem como `Thu, 18 Apr 2024 10:55:10 GMT`; converta com
   `email.utils.parsedate_to_datetime`.
4. **Duracao heterogenea** - `itunes:duration` pode ser `HH:MM:SS`, `MM:SS` ou segundos inteiros.
5. **Enclosure** - o arquivo de midia esta em `<enclosure url=... type="audio/...">`.
6. **HTML na descricao** - limpe tags e decodifique entidades (`html.unescape`).
7. **Item invalido** (sem guid/titulo) e descartado, nunca vira dado parcial enganoso.

```python
import xml.etree.ElementTree as ET
from email.utils import parsedate_to_datetime

NS = {
    "itunes": "http://www.itunes.com/dtds/podcast-1.0.dtd",
    "content": "http://purl.org/rss/1.0/modules/content/",
    "atom": "http://www.w3.org/2005/Atom",
}


def _text(el: ET.Element, tag: str) -> str:
    """Texto de um filho, com suporte a namespace ('itunes:duration')."""
    if ":" in tag:
        prefix, local = tag.split(":", 1)
        ns = NS.get(prefix)
        child = el.find(f"{{{ns}}}{local}") if ns else el.find(tag)
    else:
        child = el.find(tag)
    return (child.text or "").strip() if child is not None else ""


def next_page_url(root: ET.Element) -> str | None:
    """URL da proxima pagina se o feed usar <atom:link rel='next'>."""
    channel = root.find("channel")
    if channel is None:
        return None
    for link in channel.findall(f"{{{NS['atom']}}}link"):
        if link.get("rel") == "next":
            return link.get("href")
    return None
```

A coleta segue paginas ate `next_page_url` retornar `None` (ou repetir a URL atual), com `time.sleep`
curto entre elas e dedupe por guid.

---

## 10-F. Autenticacao em API oficial: API key, OAuth Client Credentials, quota e rate-limit

Quando a API oficial exige autenticacao, o padrao muda em tres pontos: **credencial, limites e
falhas**. A regra inegociavel: **segredos vem sempre do ambiente** (env var), nunca de arquivo,
argumento de CLI ou commit, e **nunca aparecem em URL, log ou mensagem de erro**.

### API key (chave na query ou header)

```python
import os, urllib.parse, urllib.request

api_key = os.environ.get("PROVIDER_API_KEY", "").strip()
if not api_key:
    raise SystemExit('Defina a chave: export PROVIDER_API_KEY="..."')

# A chave vai na query desta API - por isso a URL NUNCA entra em log/traceback.
url = f"{API_BASE}/items?{urllib.parse.urlencode({**params, 'key': api_key})}"
```

Ao tratar erro, leia o corpo da resposta para uma mensagem objetiva, mas **monte a mensagem sem a
URL** (que carrega a chave):

```python
def safe_error(exc) -> tuple[str, str]:
    """(mensagem, reason) do corpo de erro da API, sem vazar a chave."""
    try:
        body = json.loads(exc.read())
        err = body.get("error", {})
        reason = (err.get("errors") or [{}])[0].get("reason", "")
        return err.get("message", str(exc.reason)), reason
    except Exception:
        return str(exc.reason), ""
```

### OAuth Client Credentials Flow (sem usuario)

Para APIs que entregam um token de aplicacao (sem login de usuario), troque `client_id`+`secret` por
um access token de curta duracao. A credencial vai no header `Authorization: Basic`, **nunca na URL**.

```python
import base64

def get_access_token(client_id: str, client_secret: str) -> str:
    creds = base64.b64encode(f"{client_id}:{client_secret}".encode()).decode()
    data = urllib.parse.urlencode({"grant_type": "client_credentials"}).encode()
    req = urllib.request.Request(
        AUTH_URL, data=data, method="POST",
        headers={"Authorization": f"Basic {creds}",
                 "Content-Type": "application/x-www-form-urlencoded"},
    )
    with urllib.request.urlopen(req, timeout=30) as resp:
        token = json.loads(resp.read()).get("access_token", "")
    if not token:
        raise RuntimeError("Token vazio na resposta de autenticacao.")
    return token
```

Depois, todas as chamadas usam `Authorization: Bearer {token}`. O token expira (ex.: 3600 s); para
uma coleta unica, pegar um no inicio basta.

### Quota diaria e escolha de endpoint barato

APIs com **quota** cobram por chamada/endpoint. Conheca o custo e prefira o caminho barato:

- Liste por um endpoint barato (ex.: a "playlist de uploads" custa 1 unidade/pagina) em vez de um
  endpoint de busca caro (100 unidades/chamada).
- Pegue detalhes **em lote** (ex.: 50 ids por chamada) em vez de 1 chamada por item.
- Documente o custo no topo do script para o proximo dev nao regredir.
- Ao esbarrar na quota, levante uma excecao dedicada (`QuotaExceeded`) que aciona o **checkpoint**
  (secao 10-G) em vez de simplesmente abortar.

### Rate-limit (429) e erros transitorios (5xx)

```python
BACKOFF_BASE, MAX_RETRIES = 2.0, 5

def api_get(url: str, headers: dict):
    req = urllib.request.Request(url, headers=headers)
    for attempt in range(MAX_RETRIES):
        try:
            with urllib.request.urlopen(req, timeout=30) as resp:
                return json.loads(resp.read())
        except urllib.error.HTTPError as exc:
            if exc.code == 429:   # respeita Retry-After; senao, backoff
                wait = int(exc.headers.get("Retry-After", 0)) or int(BACKOFF_BASE ** attempt)
                time.sleep(wait)
                if attempt == MAX_RETRIES - 1:
                    raise RateLimited("Rate-limit esgotado.") from None
                continue
            if exc.code >= 500 and attempt < MAX_RETRIES - 1:
                time.sleep(BACKOFF_BASE ** attempt)   # backoff exponencial
                continue
            raise   # 4xx definitivo: nao adianta repetir
```

Regras: respeite `Retry-After` quando vier; backoff exponencial como fallback; **nao** repita `4xx`
definitivo (exceto 429); cap de tentativas; e nunca martele a API em loop apertado.

---

## 10-G. Coleta retomavel por checkpoint

Coletas longas (muitas paginas, quota diaria, rate-limit, rede instavel) devem **sobreviver a uma
interrupcao**. O padrao: salvar o progresso num arquivo de checkpoint local e, ao rodar o **mesmo
comando** de novo, retomar de onde parou - sem refazer chamadas nem duplicar itens.

Estrutura tipica:

1. **Amarre o checkpoint ao recurso** (id do canal/show/playlist). Ao carregar, se o id nao bater,
   ignore o checkpoint - evita retomar com dados de outro recurso por engano.
2. **Atualize a cada passo barato** (a cada pagina/lote): grave ids ja vistos, proximo token/offset
   e itens ja convertidos.
3. **Ao falhar de forma retomavel** (`QuotaExceeded`, `RateLimited`), salve o checkpoint **e** grave
   os itens parciais ja coletados - o consumidor ja mostra o que deu, mesmo incompleto.
4. **Ao concluir**, descarte o checkpoint.
5. Marque fases concluidas (ex.: `listing_done`) para nao reexecutar e gastar quota a toa.

```python
import json
from pathlib import Path

CHECKPOINT_NAME = ".collect_checkpoint.json"


def load_checkpoint(out_dir: Path, resource_id: str) -> dict:
    path = out_dir / CHECKPOINT_NAME
    if not path.exists():
        return {}
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except (json.JSONDecodeError, OSError):
        return {}
    return data if data.get("resource_id") == resource_id else {}   # so retoma o mesmo recurso


def save_checkpoint(out_dir: Path, checkpoint: dict) -> None:
    out_dir.mkdir(parents=True, exist_ok=True)
    (out_dir / CHECKPOINT_NAME).write_text(
        json.dumps(checkpoint, ensure_ascii=False), encoding="utf-8"
    )


def clear_checkpoint(out_dir: Path) -> None:
    path = out_dir / CHECKPOINT_NAME
    if path.exists():
        path.unlink()
```

No fluxo principal: carregue o checkpoint (vazio em `--dry-run`), passe-o adiante para as fases de
coleta acumularem progresso, e no `except` da falha retomavel grave checkpoint + parciais e oriente
o usuario a rodar o mesmo comando depois. O checkpoint e estado local de execucao: **mantenha-o fora
do controle de versao** (`.gitignore`) e sem segredos.

---

## 11. Captura manual assistida

Use captura manual quando a coleta automatica nao for confiavel ou quando a pagina exigir interacao humana autorizada.

Fluxo:

1. Subir servidor local em `127.0.0.1`.
2. Instalar userscript em navegador real.
3. Abrir a pagina manualmente.
4. Aguardar lazy loading e fechar popups nao essenciais.
5. Converter `href`, `src` e `srcset` para URLs absolutas.
6. Enviar `outerHTML` para o servidor local.
7. Salvar HTML por fonte/categoria/pagina.
8. Gravar `.meta.json` com URL, data, bytes, contagem de imagens/cards e user agent.
9. Rodar importador offline sobre os HTMLs capturados.

O servidor local deve:

- aceitar apenas `127.0.0.1`;
- limitar tamanho do payload;
- sanitizar nomes de arquivo;
- rejeitar path traversal;
- nunca gravar cookies, tokens ou headers sensiveis;
- responder com JSON simples;
- registrar contadores.

Contrato de payload:

```json
{
  "source": "example",
  "category": "categoria-publica",
  "pageUrl": "https://example.com/listing",
  "html": "<html>...</html>",
  "capturedAt": "2026-05-27T12:00:00Z",
  "stats": {
    "cards": 24,
    "images": 24,
    "bytes": 180000
  }
}
```

Metadados salvos:

```json
{
  "source": "example",
  "category": "categoria-publica",
  "pageUrl": "https://example.com/listing",
  "capturedAt": "2026-05-27T12:00:00Z",
  "htmlFile": "listing-001.html",
  "bytes": 180000,
  "cards": 24,
  "images": 24
}
```

---

## 12. Importador offline de HTML salvo

O importador precisa funcionar sem browser e sem rede.

Regras:

1. Varrer subpastas recursivamente.
2. Reconhecer fonte pelo caminho, nome do arquivo ou `.meta.json`.
3. Derivar categoria pela arvore visual quando fizer sentido.
4. Usar o adapter correto.
5. Rodar em preview por padrao.
6. Exigir `--commit` para gravar.
7. Gerar resumo JSON da execucao.
8. Contar criados, atualizados, inalterados, duplicados, ignorados e erros.

CLI esperada:

```bash
python import_saved_html.py --root manual_html
python import_saved_html.py --root manual_html --commit --yes --no-interactive
```

Resumo esperado:

```json
{
  "mode": "preview",
  "files_seen": 12,
  "files_imported": 10,
  "products_seen": 240,
  "created": 0,
  "updated": 0,
  "unchanged": 0,
  "duplicates": 4,
  "ignored": 6,
  "errors": 0
}
```

---

## 13. Persistencia recomendada

Modelo generico:

```text
Source
  slug
  display_name
  source_url
  is_active
  last_scraped_at

Category
  source_id
  name
  listing_url
  last_scraped_at

Product
  source_id
  category_id
  external_id
  title
  product_url
  public_url
  image_url
  original_price
  current_price
  discount_percent
  rating
  review_count
  is_available
  capture_source
  first_seen_at
  last_seen_at

PriceHistory
  product_id
  captured_at
  current_price
  original_price
```

Regras de banco:

1. Upsert idempotente por `(source, external_id)` ou `(category, external_id)`, conforme a granularidade real.
2. Registrar historico somente quando preco mudar ou produto for novo.
3. Marcar como indisponivel produtos nao vistos em uma categoria, sem deletar fisicamente.
4. Separar DTO do ORM.
5. Manter `persistence.py` como unico ponto que importa ORM.
6. Suportar PostgreSQL em producao e SQLite local para desenvolvimento.
7. Gravar `capture_source` para saber se veio de browser, HTTP, JSON ou HTML manual.
8. Salvar timestamps de primeira e ultima visualizacao.

Exemplo de fronteira de persistencia:

```python
def persist_products(source_slug: str, category_name: str, products: list[ProductDTO], commit: bool):
    summary = ImportSummary()

    for dto in products:
        if not dto.public_url:
            summary.blocked += 1
            continue

        if not commit:
            summary.preview += 1
            continue

        upsert_product(source_slug, category_name, dto, summary)

    return summary
```

---

## 14. URL publica, tracking e seguranca

Separe URL de coleta da URL de exibicao.

| Campo | Uso |
|---|---|
| `product_url` | URL original de coleta; pode conter tracking, afiliacao, sessao, cupom, token ou contexto privado |
| `public_url` | URL canonica segura para exibicao externa |

Regras:

1. Nunca publicar `product_url` diretamente.
2. Cada adapter deve saber gerar `public_url`.
3. Se o adapter nao souber, retornar string vazia.
4. O consumidor deve bloquear publicacao quando `public_url` estiver vazia.
5. Remover query string apenas quando isso nao quebrar variante, SKU ou contexto publico necessario.
6. Preservar parametros que identificam variante legitima.
7. Remover parametros de tracking, afiliacao privada, sessao, token e origem interna.

Exemplo:

```python
TRACKING_PARAMS = {
    "utm_source",
    "utm_medium",
    "utm_campaign",
    "utm_term",
    "utm_content",
    "fbclid",
    "gclid",
}
```

Importante: limpeza de URL nao deve ser global e cega. Alguns sites usam query string para SKU, cor, tamanho ou vendedor. A regra segura pertence ao adapter da fonte.

---

## 15. CLI recomendada

Comandos esperados:

```bash
python main.py --help
python main.py --source exemplo --limit 20
python main.py --source exemplo --category "Categoria" --limit 20
python main.py --all-sources --no-interactive
python import_saved_html.py --root manual_html
python import_saved_html.py --root manual_html --commit --yes --no-interactive
python capture_server.py --host 127.0.0.1 --port 8765
```

Regras:

- modo interativo para operacao humana;
- modo nao interativo para cron/CI;
- preview seguro por padrao em importacao;
- `--commit` explicito para gravar;
- `--limit`, `--max-pages` e `--timeout` sempre disponiveis;
- logs objetivos com contadores;
- snapshots de saida para auditoria.

---

## 16. Testes obrigatorios

| Teste | O que valida |
|---|---|
| Parser por adapter | Extrai DTOs corretos de fixture HTML sanitizada |
| Parser de API (JSON) | Coleta itens de fixture JSON sanitizada (pagina, set, cursor) |
| Parser de RSS/Atom | Extrai itens de fixture XML; namespaces, datas, duracao, enclosure |
| Origem do cursor | Rejeita cursores fora da lista de hosts autorizados antes de enviar headers |
| Redirect com autenticacao | Rejeita redirects para origem nao permitida antes de reenviar credenciais |
| Paginacao por numero | Para na pagina vazia/menor que `per_page` e respeita o teto |
| Paginacao por cursor | Segue `next_href` ate o fim e respeita teto de paginas/itens |
| Backoff / rate-limit | Respeita `Retry-After`, faz backoff em 5xx e nao repete 4xx |
| Checkpoint/retomada | Retoma do estado salvo, ignora checkpoint de outro recurso, descarta ao fim |
| Pipeline com fallback | Usa o 2o metodo quando o 1o falha; vazio quando ambos falham |
| Parser de JSON embutido | Coleta produtos de `__NEXT_DATA__`, JSON-LD ou payload textual |
| Parser de preco | Normaliza moeda, separadores, descontos e valores ausentes |
| URL resolver | Gera URL publica correta e bloqueia quando nao sabe resolver |
| Importador manual | Detecta fonte, categoria, caminho, preview e resumo |
| Servidor de captura | Salva HTML/meta, sanitiza paths e limita payload |
| Persistencia | Upsert, dedupe, historico de preco e indisponibilidade |
| CLI | `--help`, args principais e dry-run sem crash |

Checklist minimo:

1. Fixture HTML nao deve conter dado sensivel.
2. Teste offline nao deve depender de rede.
3. Parser deve falhar com lista vazia ou erro controlado, nunca dado parcial enganoso.
4. Todo adapter novo precisa de pelo menos um teste offline.
5. Toda regra de URL publica precisa de teste dedicado.
6. Captura manual precisa validar paths, limite de payload e metadados.
7. Upsert precisa ser idempotente: rodar duas vezes nao duplica produto.

---

## 17. Logs e auditoria

Registre:

- fonte;
- categoria;
- URL de listagem;
- modo de captura;
- quantidade de paginas;
- quantidade de produtos extraidos;
- quantidade de produtos persistidos;
- duplicados;
- bloqueados por falta de `public_url`;
- erros por adapter;
- caminho de HTML de debug local, quando existir.

Nao registre:

- cookies;
- tokens;
- headers sensiveis;
- HTML bruto com dados pessoais;
- URLs privilegiadas em logs publicos;
- respostas inteiras de APIs privadas.

Formato recomendado:

```json
{
  "source": "example",
  "category": "categoria",
  "mode": "browser",
  "products_seen": 40,
  "products_valid": 38,
  "blocked_without_public_url": 2,
  "created": 10,
  "updated": 5,
  "unchanged": 23,
  "errors": 0
}
```

---

## 18. Guardrails operacionais

- Respeitar termos de uso, autorizacoes, limites e robots quando aplicavel. O endpoint usado pelo
  front-end nao e permissao implicita para coletar diretamente.
- **Coleta de dados pessoais exige base legal (LGPD), nao so autorizacao tecnica.** Se o scraper captura dado pessoal, registre finalidade, base legal e retencao - use [`../../templates/PRIVACIDADE-LGPD-template.md`](../../templates/PRIVACIDADE-LGPD-template.md); cuidados tecnicos gerais em [`../../core/DESIGN_SYSTEM_SEGURANCA.md`](../../core/DESIGN_SYSTEM_SEGURANCA.md).
- Preferir APIs oficiais quando existirem e cobrirem o caso. Endpoint nao documentado exige
  autorizacao explicita; na duvida, use outro metodo permitido.
- **Segredos sempre do ambiente** (env var), nunca de arquivo, argumento de CLI ou commit.
- **Nunca colocar credencial/token em URL, log ou mensagem de erro** - monte erros sem a URL quando a chave vai na query.
- Respeitar quota e rate-limit (`Retry-After`, backoff); conhecer e preferir o endpoint mais barato.
- Nao registrar secrets, cookies, tokens ou HTML com dados pessoais em repositorio publico.
- Manter checkpoints e arquivos de progresso fora do controle de versao (`.gitignore`), sem segredos.
- Nao implementar bypass agressivo de bloqueios nem reutilizar sessao/auth de usuario sem autorizacao.
- Se houver desafio humano ou bloqueio, usar fluxo manual autorizado ou fonte oficial.
- Colocar limites de paginas, bytes, produtos e tempo de execucao.
- Salvar HTML de debug localmente e revisar antes de transformar em fixture.
- Sanitizar fixtures antes de commit.
- Separar ambiente de teste, staging e producao.
- Usar dry-run/preview para qualquer importacao manual.
- Registrar fonte, data e arquivo de origem para auditoria.

---

## 19. Receita rapida de reaproveitamento

1. Definir DTO puro.
2. Criar `SourceAdapter` abstrato.
3. Implementar um adapter por fonte/layout e por metodo (API oficial, RSS, JSON autorizado, HTTP, navegador).
4. Priorizar API oficial > feed publicado > JSON explicitamente permitido > HTML autorizado > navegador/captura manual autorizados.
5. Manter o I/O HTTP fino e todo o parsing (HTML, JSON, XML) em funcoes puras e fail-safe.
6. Tirar segredos so do ambiente; nunca em URL, log, argumento ou commit.
7. Tratar paginacao (numero ou cursor), quota, rate-limit (`Retry-After`/backoff) e retomada por checkpoint.
8. Usar BeautifulSoup/DOM como parser offline testavel.
9. Usar Playwright/Selenium apenas para navegacao, scroll, interacao e captura de HTML.
10. Organizar os metodos num pipeline com fallback (mais barato -> mais caro) e falha segura.
11. Criar fallback de captura manual com userscript + servidor local.
12. Persistir com upsert idempotente e historico; gravar `capture_source`.
13. Separar URL de coleta da URL publica.
14. Cobrir cada adapter e cada parser (HTML, JSON, XML) com fixtures sanitizadas e testes offline.

---

## 20. Criterio de pronto

Um scraper so esta pronto quando:

- tem adapter isolado;
- tem DTO puro;
- tem parser offline;
- tem fixture sanitizada;
- tem teste do adapter;
- tem limites operacionais;
- tem dry-run;
- tem persistencia idempotente;
- tem regra de URL publica;
- bloqueia publicacao quando URL segura nao existe;
- registra resumo auditavel;
- nao vaza dado sensivel.

Se uma dessas garantias nao existir, o scraper pode ate funcionar, mas ainda nao e um padrao confiavel para reutilizacao.

## Ideias para quem quiser contribuir

- Adaptador de parser para formatos adicionais (PDF, planilhas) seguindo a mesma interface offline-first.
- Dashboard simples de execucoes (sucesso/falha/tempo) para acompanhar coletas recorrentes.
