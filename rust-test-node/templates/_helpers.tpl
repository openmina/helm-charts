{{/*
Expand the name of the chart.
*/}}
{{- define "rust-test-node.name" -}}
{{- include "mina-common.name" . }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rust-test-node.fullname" -}}
{{- include "mina-common.fullname" . }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rust-test-node.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rust-test-node.labels" -}}
helm.sh/chart: {{ include "rust-test-node.chart" . }}
{{ include "rust-test-node.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
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
app.kubernetes.io/name: {{ include "rust-test-node.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
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
