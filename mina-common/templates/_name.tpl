{{/*
Expand the name of the chart.
*/}}
{{- define "mina-common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name. Usually this is used as a deployment or service name.
*/}}
{{- define "mina-common.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Creates a DNS-compatible name qualified with the release name
*/}}
{{- define "mina-common.qname" }}
{{ $name := index . 0 }}
{{ $ := index . 1 }}
{{ printf "%s-%s" $.Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
