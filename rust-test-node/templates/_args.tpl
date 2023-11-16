{{/*
Openmina command arguments
*/}}
{{- define "rust-test-node.args" }}
{{- include "rust-test-node.peers.args" . }}
{{- if .Values.record }}
- "--work-dir=/record"
- "--record=state-with-input-actions"
{{- end }}
{{- end }}
