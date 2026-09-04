{{- $lang := .Site.Language.Lang -}}
{{- $dir := .Site.Language.Direction -}}
{{- $resume := index hugo.Data.resume $lang -}}
{{- with $resume -}}
#set page(
  paper: "a4",
  margin: (x: 1.5cm, top: 1.5cm, bottom: 1.5cm),
)

#set text(
  font: ("Cairo", "Liberation Sans", "sans-serif"),
  size: 9.5pt,
  lang: "{{ $lang }}",
  dir: {{ if eq $dir "rtl" }}rtl{{ else }}ltr{{ end }},
  fill: rgb("#1e293b"),
)

#set par(justify: false, leading: 0.65em)

#let esc(raw-json) = {
  let val = json.decode(raw-json)
  if type(val) == str {
    val.replace("<", "\<")
       .replace(">", "\>")
       .replace("@", "\@")
       .replace("$", "\$")
       .replace("#", "\#")
  } else {
    val
  }
}

// --- Header ---
#align(center)[
  #text(size: 18pt, weight: "bold", fill: rgb("#0f172a"))[#esc({{ i18n "title" | jsonify }})] \
  #v(-2pt)
  #text(size: 10.5pt, weight: "bold", fill: rgb("#2563eb"))[#esc({{ default (i18n "job_title") .job_title | jsonify }})] \
  #v(2pt)
  #text(size: 8.5pt, fill: rgb("#475569"))[
    {{- range $i, $c := .contact_links -}}
      {{- if $i }} #text(fill: rgb("#94a3b8"))[•] {{ end -}}
      #link(json.decode({{ $c.url | jsonify }}))[#esc({{ default $c.name $c.label | jsonify }})]
    {{- end }}
    #text(fill: rgb("#94a3b8"))[•] #esc({{ default (i18n "location") .location | jsonify }})
  ]
]

#v(2pt)
#line(length: 100%, stroke: 1.2pt + rgb("#0f172a"))
#v(4pt)

{{ with .bio }}
#text(size: 8.8pt, fill: rgb("#334155"))[#esc({{ . | jsonify }})]
#v(2pt)
#line(length: 100%, stroke: (dash: "dashed", thickness: 0.5pt, paint: rgb("#cbd5e1")))
#v(4pt)
{{ end }}

// --- Section Header Macro ---
#let section-title(raw-json) = {
  v(8pt)
  text(size: 10.5pt, weight: "bold", fill: rgb("#0f172a"))[#upper(esc(raw-json))]
  v(-3pt)
  line(length: 100%, stroke: 0.5pt + rgb("#cbd5e1"))
  v(3pt)
}

{{ with .education }}
#section-title({{ i18n "education" | jsonify }})
{{ range . }}
#block(width: 100%, breakable: false)[
  #grid(
    columns: (1fr, auto),
    [*#esc({{ .degree | jsonify }})*],
    [#text(size: 8.2pt, fill: rgb("#64748b"))[#esc({{ .grade | jsonify }})]]
  )
  #text(size: 8.8pt)[#esc({{ .institution | jsonify }}) — *#esc({{ .honors | jsonify }})*]
  {{ with .leadership }}\ #text(size: 8.5pt, fill: rgb("#475569"))[#esc({{ . | jsonify }})]{{ end }}
]
#v(4pt)
{{ end }}
{{ end }}

{{ with .experience }}
#section-title({{ i18n "experience" | jsonify }})
{{ range . }}
#block(width: 100%, breakable: false)[
  #grid(
    columns: (1fr, auto),
    [*#esc({{ .role | jsonify }})*],
    [#text(size: 8.2pt, fill: rgb("#64748b"))[#esc({{ .period | jsonify }})]]
  )
  #text(size: 8.8pt)[*#esc({{ .organization | jsonify }})* {{ with .team }}#text(fill: rgb("#64748b"))[(#esc({{ . | jsonify }}))]{{ end }}]
  {{ range .highlights }}
  - #esc({{ . | jsonify }})
  {{ end }}
]
#v(4pt)
{{ end }}
{{ end }}

{{ with .skills }}
#section-title({{ i18n "skills" | jsonify }})
#block(width: 100%, breakable: false)[
  {{ range . }}
  *#esc({{ .category | jsonify }}):* #text(fill: rgb("#475569"))[#esc({{ delimit .items " • " | jsonify }})] \
  {{ end }}
]
{{ end }}

{{ with .projects }}
#section-title({{ i18n "projects" | jsonify }})
{{ range . }}
#block(width: 100%, breakable: false)[
  #grid(
    columns: (1fr, auto),
    [*#link(json.decode({{ .url | jsonify }}))[#esc({{ .name | jsonify }})]*],
    [{{ with .tag }}#text(fill: rgb("#2563eb"), weight: "bold", size: 8.2pt)[#esc({{ . | jsonify }})]{{ end }}]
  )
  #text(size: 8.8pt, fill: rgb("#475569"))[#esc({{ .desc | jsonify }})]
]
#v(3pt)
{{ end }}
{{ end }}

{{ with .contributions }}
#section-title({{ i18n "contributions" | jsonify }})
{{ range . }}
#block(width: 100%, breakable: false)[
  #grid(
    columns: (1fr, auto),
    [*#link(json.decode({{ .contribution_url | default .project_url | jsonify }}))[#esc({{ .project | jsonify }})]*],
    [{{ with .tag }}#text(fill: rgb("#2563eb"), weight: "bold", size: 8.2pt)[#esc({{ . | jsonify }})]{{ end }}]
  )
  #text(size: 8.8pt, fill: rgb("#475569"))[#esc({{ .desc | jsonify }})]
]
#v(3pt)
{{ end }}
{{ end }}

{{ with .note }}
#v(8pt)
#line(length: 100%, stroke: (dash: "dashed", thickness: 0.5pt, paint: rgb("#cbd5e1")))
#v(2pt)
#text(size: 7.5pt, fill: rgb("#64748b"))[#esc({{ . | jsonify }})]
{{ end }}

{{- end -}}