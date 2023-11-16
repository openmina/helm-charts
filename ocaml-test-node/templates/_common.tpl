{{/*
Mina image
*/}}
{{- define "ocaml-test-node.image" -}}
{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end }}
