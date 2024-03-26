### Introduction
Hi there :sunglasses: My name is Tim, and this repository contains my work on Bayesian growth mixture models ( or GMMs for short ), including their application to country-level terrorism data. The work has been developed in coorporation with Dr. Nalan Basturk as part of my research assistantance in econometrics at Maastricht University.

### Work developed
* The models have been implemented and estimated using Stan and its built-in No-U-Turn Sampler ( or NUTS for short ) via the RStan R package (Stan Development Team, 2024).
* Work in progress

### Repository structure
Work in progress

### References
* Stan Development Team. (2024). *RStan: the R interface to Stan* (Version 2.32.6) [R package].

{{- $p := .Page -}}
{{- range (split .Inner "\n") -}}
  {{- if gt (len .) 0 }}
  <p class="p2">
    {{ . | $p.RenderString }}
  </p>
  {{- end }}
{{- end -}}

{{< biblio-ref >}}
Hugo, Victor. *The Hunchback of Notre-Dame*. Unknown publisher, 1831.
Hugo, Victor. *Les Misérables*. Unknown publisher, 1862.
Hugo, Victor. *Les Travailleurs de la Mer*. Unknown publisher, 1866.
Hugo, Victor. *Quatre-vingt-treize*. Unknown publisher, 1874.
{{< /biblio-ref >}}
