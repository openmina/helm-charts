{{/*
Expand the name of the chart.
*/}}
{{- define "ocaml-test-node.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ocaml-test-node.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ocaml-test-node.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ocaml-test-node.labels" -}}
helm.sh/chart: {{ include "ocaml-test-node.chart" . }}
{{ include "ocaml-test-node.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
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
app.kubernetes.io/name: {{ include "ocaml-test-node.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
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
