{{/*
External service address
*/}}
{{- define "mina-common.service-external-ip" }}
{{- $name := include "mina-common.fullname" . | upper }}
{{- printf "$(%s_SERVICE_HOST)" (regexReplaceAll "[^A-Z_]" $name "_") }}
{{- end }}
