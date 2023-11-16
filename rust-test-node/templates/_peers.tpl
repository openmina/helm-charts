{{/*
Openmina peers env
*/}}
{{- define "rust-test-node.peers.env" }}
{{- with .Values.peers }}
- name: "PEERS"
  value: |
    {{- range . }}
    {{ include "mina-common.peers.multiAddress" (merge $ (dict "Peer" .)) }}
    {{- end }}
{{- end }}
{{- end -}}

{{/*
Openmina env vars related to peers
*/}}
{{- define "rust-test-node.peers.args" }}
{{- if .Values.peers }}
"--peers",
{{- range .Values.peers }}
{{- include "mina-common.peers.multiAddress" (merge $ (dict "Peer" .)) | trim | quote }},
{{- end }}
{{- end }}
{{- end }}
