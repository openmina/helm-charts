{{/*
Environment variables for Rust node
*/}}
{{- define "rust-test-node.env" }}
- name: "VERBOSITY"
  value: "debug"
{{- with .Values.secretKey -}}
- name: "OPENMINA_P2P_SEC_KEY"
  value: {{ . | quote }}
{{- end }}
{{- end }}
