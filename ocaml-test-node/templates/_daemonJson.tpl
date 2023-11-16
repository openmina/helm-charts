{{/*
Path to daemon.json config file
*/}}
{{- define "ocaml-test-node.daemonJson.path" -}}
{{ include "ocaml-test-node.daemonJson.volumeMount.path" . }}/{{ include "ocaml-test-node.daemonJson.file.name" . }}
{{- end }}

{{/*
Mount point of block production keys
*/}}
{{- define "ocaml-test-node.daemonJson.volumeMount.path" -}}
/config
{{- end }}

{{/*
Block production key file name
*/}}
{{- define "ocaml-test-node.daemonJson.file.name" -}}
daemon.json
{{- end }}

{{/*
Init containers for daemon.json
*/}}
{{- define "ocaml-test-node.daemonJson.initContainers" -}}
{{- include "ocaml-test-node.daemonJson.fetchContainer" . }}
{{- end }}

{{/*
Init container for daemon.json
*/}}
{{- define "ocaml-test-node.daemonJson.fetchContainer" }}
{{- if .Values.daemonJson.remote }}
- name: daemon-json-download
  image: alpine
  command: [ "sh", "-c" ]
  args:
    - curl -o {{ include "ocaml-test-node.daemonJson.path" . }} {{ .Values.daemonJson.remote.url }}
  volumeMounts:
    - name: {{ include "ocaml-test-node.daemonJson.volume.name" . }}
      mountPath: {{ include "ocaml-test-node.daemonJson.volumeMount.path" . }}
{{- else if .Values.daemonJson.local }}
- name: daemon-json-copy
  image: {{ include "ocaml-test-node.image" . }}
  command: [ "sh", "-c" ]
  args:
    - cp {{ .Values.daemonJson.local.path }} {{ include "ocaml-test-node.daemonJson.path" . }}
  volumeMounts:
    - name: {{ include "ocaml-test-node.daemonJson.volume.name" . }}
      mountPath: {{ include "ocaml-test-node.daemonJson.volumeMount.path" . }}
{{- end }}
{{- end }}


{{/*
Config volume mount
*/}}
{{- define "ocaml-test-node.daemonJson.volumeMounts" }}
- name: {{ include "ocaml-test-node.daemonJson.volume.name" . }}
  mountPath: {{ include "ocaml-test-node.daemonJson.volumeMount.path" . }}
{{- end }}

{{/*
Config volume (containing daemon.json)
*/}}
{{- define "ocaml-test-node.daemonJson.volume.name" }}daemon-json{{ end }}

{{/*
Config volume (containing daemon.json)
*/}}
{{- define "ocaml-test-node.daemonJson.volume" }}
- name: {{ include "ocaml-test-node.daemonJson.volume.name" . }}
{{- if .Values.daemonJson.secret }}
  secret:
    name: {{ .Values.daemonJson.secret }}
    items: [ daemon.json ]
{{- else }}
  emptyDir: {}
{{- end }}
{{- end }}
