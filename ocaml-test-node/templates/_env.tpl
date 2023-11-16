{{/*
Mina env
*/}}
{{- define "ocaml-test-node.env" }}
- name: "MINA_LIBP2P_PASS"
  value: ""
- name: "MINA_PRIVKEY_PASS"
  value: ""
{{- end }}
