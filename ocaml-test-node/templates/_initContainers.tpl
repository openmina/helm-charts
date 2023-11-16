{{/*
All init containers
*/}}
{{- define "ocaml-test-node.initContainers" }}
{{ include "ocaml-test-node.daemonJson.initContainers" . }}
{{ include "ocaml-test-node.libp2p.initContainers" . }}
{{ include "ocaml-test-node.blockProducerKey.initContainers" . }}
{{- if (and (not .Values.seed) (gt (int .Values.seedWaitTimeout) 0))}}
- name: wait
  image: busybox
  command: ["sh", "-c", "sleep {{ .Values.seedWaitTimeout }}"]
{{- end }}
{{- end }}
