{{/*
Expand the name of the chart.
*/}}
{{- define "rust-test-node.name" -}}
{{- include "mina-common.name" . }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "rust-test-node.fullname" -}}
{{- include "mina-common.fullname" . }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rust-test-node.chart" -}}
{{- include "mina-common.chart" . }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rust-test-node.labels" -}}
{{ include "mina-common.labels" . }}
openmina.com/node-kind: rust
{{- end }}

{{/*
Pod labels
*/}}
{{- define "rust-test-node.podLabels" -}}
openmina.com/node-kind: rust
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rust-test-node.selectorLabels" -}}
{{ include "mina-common.selectorLabels" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rust-test-node.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rust-test-node.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
