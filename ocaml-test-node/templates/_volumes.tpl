{{/*
Mina volumes
*/}}
{{- define "ocaml-test-node.volumes" -}}
{{- include "ocaml-test-node.libp2p.volume" . -}}
{{- include "ocaml-test-node.libp2p.secret.volume" . -}}
{{- include "ocaml-test-node.daemonJson.volume" . -}}
{{- include "ocaml-test-node.blockProducerKey.volume" . -}}
{{- end -}}

{{/*
Mina volume mounts
*/}}
{{- define "ocaml-test-node.volumeMounts" }}
{{- include "ocaml-test-node.libp2p.volumeMounts" . -}}
{{- include "ocaml-test-node.daemonJson.volumeMounts" . -}}
{{- include "ocaml-test-node.blockProducerKey.volumeMounts" . -}}
{{- end }}
