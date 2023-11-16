{{/*
Mina peers arguments
*/}}
{{- define "ocaml-test-node.peers.args" -}}
{{- range .Values.peers }}
"--peer", {{ include "mina-common.peers.multiAddress" (merge $ (dict "Peer" .)) | trim | quote}},
{{- end }}
{{- end -}}
