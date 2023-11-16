{{/*
Full block production key path
*/}}
{{- define "ocaml-test-node.blockProducerKey.path" -}}
{{- include "ocaml-test-node.blockProducerKey.volumeMount.path" . }}/{{ include "ocaml-test-node.blockProducerKey.name" . }}
{{- end }}

{{/*
Mount point of block production keys
*/}}
{{- define "ocaml-test-node.blockProducerKey.volumeMount.path" -}}
/keys
{{- end }}

{{/*
Block production key file name
*/}}
{{- define "ocaml-test-node.blockProducerKey.name" -}}
.block-producer
{{- end }}

{{/*
Block producer key init containers (none)
*/}}
{{- define "ocaml-test-node.blockProducerKey.initContainers" }}{{ end -}}

{{/*
Block producer volume mount
*/}}
{{- define "ocaml-test-node.blockProducerKey.volumeMounts" }}
{{- if .Values.blockProducerKey.secret }}
- name: {{ include "ocaml-test-node.blockProducerKey.volume.name" }}
  mountPath: {{ include "ocaml-test-node.blockProducerKey.volumeMount.path" . }}
{{- end }}
{{- end }}

{{/*
Block producer key volume
*/}}
{{- define "ocaml-test-node.blockProducerKey.volume.name" }}block-producer-key{{ end }}

{{/*
Block producer key volume
*/}}
{{- define "ocaml-test-node.blockProducerKey.volume" }}
{{- if .Values.blockProducerKey.secret }}
- name: {{ include "ocaml-test-node.blockProducerKey.volume.name" }}
  secret:
    secretName: {{ .Values.blockProducerKey.secret }}
    items:
    - key: key
      path: {{ .Values.blockProducerKey.file.name }}
{{- end }}
{{- end }}
