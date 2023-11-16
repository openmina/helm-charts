{{/*
Mina ports
*/}}
{{- define "ocaml-test-node.ports" }}
{{ include "ocaml-test-node.ports.external" . }}
{{- end }}

{{/*
Mina external port
*/}}
{{- define "ocaml-test-node.ports.external" }}
- name: external
  containerPort: 8302
{{- end }}
