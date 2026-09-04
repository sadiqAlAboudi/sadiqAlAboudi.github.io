{{- $lang := .Site.Language.Lang -}}
{{- $dir := .Site.Language.Direction -}}
{{- $resume := index hugo.Data.resume $lang -}}
{{- with $resume -}}
#set page(
  paper: "a4",
  margin: (x: 1.5cm, top: 1.5cm, bottom: 1.5cm),
)

#set text(
  font: "Cairo",
  size: 9.5pt,
  lang: "{{ $lang }}",
  dir: {{ if eq $dir "rtl" }}rtl{{ else }}ltr{{ end }},
  fill: rgb("#1e293b"),
)

#set par(justify: false, leading: 0.65em)

// --- Header ---
#align(center)[
  #text(size: 18pt, weight: "bold", fill: rgb("#0f172a"))[{{ i18n "title" }}] \
  #v(-2pt)
  #text(size: 10.5pt, weight: "bold", fill: rgb("#2563eb"))[{{ default (i18n "job_title") .job_title }}] \
  #v(2pt)
  #text(size: 8.5pt, fill: rgb("#475569"))[
    {{- range $i, $c := .contact_links -}}
      {{- if $i }} #text(fill: rgb("#94a3b8"))[•] {{ end -}}
      #link("{{ $c.url }}")[{{ default $c.name $c.label }}]
    {{- end }}
    #text(fill: rgb("#94a3b8"))[•] {{ default (i18n "location") .location }}
  ]
]

#v(2pt)
#line(length: 100%, stroke: 1.2pt + rgb("#0f172a"))
#v(4pt)

{{ with .bio }}
#text(size: 8.8pt, fill: rgb("#334155"))[{{ . }}]
#v(2pt)
#line(length: 100%, stroke: (dash: "dashed", thickness: 0.5pt, paint: rgb("#cbd5e1")))
#v(4pt)
{{ end }}

// --- Section Header Macro ---
#let section-title(title) = {
  v(8pt)
  text(size: 10.5pt, weight: "bold", fill: rgb("#0f172a"))[#upper(title)]
  v(-3pt)
  line(length: 100%, stroke: 0.5pt + rgb("#cbd5e1"))
  v(3pt)
}

{{ with .education }}
#section-title("{{ i18n "education" }}")
{{ range . }}
#block(width: 100%, breakable: false)[
  #grid(
    columns: (1fr, auto),
    [*{{ .degree }}*],
    [#text(size: 8.2pt, fill: rgb("#64748b"))[{{ .grade }}]]
  )
  #text(size: 8.8pt)[{{ .institution }} — *{{ .honors }}*]
  {{ with .leadership }}\ #text(size: 8.5pt, fill: rgb("#475569"))[{{ . }}]{{ end }}
]
#v(4pt)
{{ end }}
{{ end }}

{{ with .experience }}
#section-title("{{ i18n "experience" }}")
{{ range . }}
#block(width: 100%, breakable: false)[
  #grid(
    columns: (1fr, auto),
    [*{{ .role }}*],
    [#text(size: 8.2pt, fill: rgb("#64748b"))[{{ .period }}]]
  )
  #text(size: 8.8pt)[*{{ .organization }}* {{ with .team }}#text(fill: rgb("#64748b"))[({{ . }})]{{ end }}]
  {{ range .highlights }}
  - {{ . }}
  {{ end }}
]
#v(4pt)
{{ end }}
{{ end }}

{{ with .skills }}
#section-title("{{ i18n "skills" }}")
#block(width: 100%, breakable: false)[
  {{ range . }}
  *{{ .category }}:* #text(fill: rgb("#475569"))[{{ delimit .items " • " }}] \
  {{ end }}
]
{{ end }}

{{ with .projects }}
#section-title("{{ i18n "projects" }}")
{{ range . }}
#block(width: 100%, breakable: false)[
  #grid(
    columns: (1fr, auto),
    [*#link("{{ .url }}")[{{ .name }}]*],
    [{{ with .tag }}#text(fill: rgb("#2563eb"), weight: "bold", size: 8.2pt)[{{ . }}]{{ end }}]
  )
  #text(size: 8.8pt, fill: rgb("#475569"))[{{ .desc }}]
]
#v(3pt)
{{ end }}
{{ end }}

{{ with .contributions }}
#section-title("{{ i18n "contributions" }}")
{{ range . }}
#block(width: 100%, breakable: false)[
  #grid(
    columns: (1fr, auto),
    [*#link("{{ .contribution_url | default .project_url }}")[{{ .project }}]*],
    [{{ with .tag }}#text(fill: rgb("#2563eb"), weight: "bold", size: 8.2pt)[{{ . }}]{{ end }}]
  )
  #text(size: 8.8pt, fill: rgb("#475569"))[{{ .desc }}]
]
#v(3pt)
{{ end }}
{{ end }}

{{ with .note }}
#v(8pt)
#line(length: 100%, stroke: (dash: "dashed", thickness: 0.5pt, paint: rgb("#cbd5e1")))
#v(2pt)
#text(size: 7.5pt, fill: rgb("#64748b"))[{{ . }}]
{{ end }}

{{- end -}}