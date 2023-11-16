{{/*
Mina arguments
*/}}
{{- define "ocaml-test-node.args" -}}[
{{ include "ocaml-test-node.args.common" . }}
{{ include "ocaml-test-node.peers.args" . }}
{{ include "ocaml-test-node.args.demoMode" . }}
{{ include "ocaml-test-node.args.blockProducer" . }}
{{ include "ocaml-test-node.args.values" . }}
]
{{- end }}

{{/*
Common Mina arguments
*/}}
{{- define "ocaml-test-node.args.common" -}}
"--log-level", "Debug",
"--insecure-rest-server",
"--config-file", {{ include "ocaml-test-node.daemonJson.path" . | quote }},
"--libp2p-keypair", {{ include "ocaml-test-node.libp2p.path" . | quote }},
{{- if .Values.isSeed }}
"--seed",
{{- end }}
"--external-ip", {{ include "mina-common.service-external-ip" . | quote }},
{{- end -}}

{{/*
Mina arguments for demo mode
*/}}
{{- define "ocaml-test-node.args.demoMode" -}}
{{- if .Values.demoMode -}}
--demo-mode,
{{- end -}}
{{- end -}}

{{/*
Mina arguments for block production mode
*/}}
{{- define "ocaml-test-node.args.blockProducer" -}}
{{- if .Values.blockProducer -}}
--blockProductionKey, {{ include "ocaml-test-node.blockProducerKey.path" . }}
{{- end -}}
{{- end -}}

{{/*
Mina arguments specified in .Values
*/}}
{{- define "ocaml-test-node.args.values" }}
{{- range .Values.args }}
{{ . | quote }},
{{- end }}
{{- end }}

{{/*
Mina external
*/}}
