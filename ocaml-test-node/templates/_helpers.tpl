{{/*
Expand the name of the chart.
*/}}
{{- define "ocaml-test-node.name" -}}
{{- include "mina-common.name" . }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ocaml-test-node.fullname" -}}
{{- include "mina-common.fullname" . }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ocaml-test-node.chart" -}}
{{- include "mina-common.fullname" . }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ocaml-test-node.labels" -}}
{{ include "mina-common.labels" . }}
openmina.com/node-kind: ocaml
{{- end }}

{{/*
Pod labels
*/}}
{{- define "ocaml-test-node.podLabels" -}}
openmina.com/node-kind: ocaml
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ocaml-test-node.selectorLabels" -}}
{{ include "mina-common.labels" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ocaml-test-node.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ocaml-test-node.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
