# Referencias Tecnicas

Esta lista aponta para fontes primarias usadas nos criterios do Doktor System-Design. Ela e uma rota de consulta, nao uma bibliografia para ler inteira. Abra a secao relacionada a tarefa e confirme a versao atual antes de implementar.

Ultima revisao das fontes: 2026-11-20.

## Acessibilidade e responsividade

| Fonte | Use para |
|---|---|
| [WCAG 2.2, recomendacao W3C](https://www.w3.org/TR/WCAG22/) | Criterios normativos de acessibilidade web. Leia o criterio completo e as excecoes. |
| [WCAG 2.2: Target Size (Minimum)](https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum) | Alvos interativos, espacamento e excecoes do criterio 2.5.8. |
| [WCAG 2 at a Glance](https://www.w3.org/WAI/standards-guidelines/wcag/glance/) | Resumo para orientar a leitura; nao substitui o padrao. |
| [Responsive web design - MDN](https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/CSS_layout/Responsive_Design) | Layouts flexiveis, breakpoints baseados no conteudo e tecnologias CSS responsivas. |
| [Using media queries for accessibility - MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/Guides/Media_queries/Using_for_accessibility) | Preferencias do sistema, incluindo movimento reduzido. |

## Performance web

| Fonte | Use para |
|---|---|
| [Web Vitals - web.dev](https://web.dev/articles/vitals) | Definicao e medidas atuais de Core Web Vitals. |
| [Como os limites foram definidos - web.dev](https://web.dev/articles/defining-core-web-vitals-thresholds) | Alvos de LCP, INP e CLS e avaliacao no percentil 75. |
| [Medicao de campo - web.dev](https://web.dev/articles/vitals-field-measurement-best-practices) | Interpretar dados de uso real, segmentacao e percentis. |

## Seguranca

| Fonte | Use para |
|---|---|
| [OWASP Top 10:2025](https://owasp.org/www-project-top-ten/) | Conscientizacao dos riscos mais comuns em aplicacoes web. Nao e uma certificacao. |
| [OWASP ASVS](https://asvs.owasp.org/) | Requisitos verificaveis para revisar controles tecnicos conforme o risco. |
| [OWASP API Security Top 10:2023](https://api-security.owasp.org/editions/2023/en/0x00-header/) | Riscos especificos de APIs, como autorizacao por objeto e consumo de recursos. |

## Contratos HTTP

| Fonte | Use para |
|---|---|
| [HTTP Semantics - RFC 9110](https://www.rfc-editor.org/rfc/rfc9110.html) | Semantica de metodos, status, seguranca e idempotencia. |
| [Problem Details for HTTP APIs - RFC 9457](https://www.rfc-editor.org/rfc/rfc9457.html) | Formato de erro HTTP interoperavel, quando adequado ao contrato. |

## Como manter esta lista

- Prefira padroes publicados e documentacao mantida pelo projeto oficial.
- Registre versao ou data quando uma referencia tiver edicoes.
- Atualize o documento que usa o criterio e esta lista quando uma fonte mudar de forma relevante.
- Nao copie trechos extensos, componentes ou identidade visual de uma fonte; adapte o principio e respeite a licenca.
- Se uma fonte nao puder ser acessada, nao alegue que ela foi revisada.