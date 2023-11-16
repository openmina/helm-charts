{{/*
Path to libp2p key file
*/}}
{{- define "ocaml-test-node.libp2p.path" -}}
{{- include "ocaml-test-node.libp2p.volumeMount.path" .}}/{{- include "ocaml-test-node.libp2p.keyFile.name" .}}
{{- end }}

{{/*
Mount path for libp2p directory
*/}}
{{- define "ocaml-test-node.libp2p.volumeMount.path" -}}
/libp2p
{{- end }}

{{/*
Libp2p key file name
*/}}
{{- define "ocaml-test-node.libp2p.keyFile.name" -}}
key
{{- end }}

{{/*
Libp2p secret name
*/}}
{{- define "ocaml-test-node.libp2p.secret.name" -}}
{{- printf "%s-%s" .Release.Name .Values.libp2p.secret }}
{{- end }}


{{/*
Libp2p init containers
*/}}
{{- define "ocaml-test-node.libp2p.initContainers"}}
{{- include "ocaml-test-node.libp2p.initContainers.generateKeypair" . }}
{{- include "ocaml-test-node.libp2p.initContainers.copyKeypair" . }}
{{- include "ocaml-test-node.libp2p.initContainers.fixPermissions" . }}
{{- end }}

{{/*
Init container for libp2p key generation
*/}}
{{- define "ocaml-test-node.libp2p.initContainers.generateKeypair" }}
{{- if (not .Values.libp2p.secret) }}
- name: generate-libp2p-keys
  image: {{ include "ocaml-test-node.image" . }}
  command: [ "mina", "libp2p", "generate-keypair", "--privkey-path", {{ include "ocaml-test-node.libp2p.path" . | quote }} ]
  env: [{ name: "MINA_LIBP2P_PASS", value: "" }]
  volumeMounts:
    - name: {{ include "ocaml-test-node.libp2p.volume.name" . }}
      mountPath: {{ include "ocaml-test-node.libp2p.volumeMount.path" .  }}
{{- end }}
{{- end }}

{{/*
Init container to copy libp2p key from secret volume
*/}}
{{- define "ocaml-test-node.libp2p.initContainers.copyKeypair" }}
{{- if .Values.libp2p.secret }}
- name: copy-secret-libp2p-keys
  image: busybox
  command: [ "sh", "-c" ]
  args:
    - |
      cp -r /libp2p-secret/. {{ include "ocaml-test-node.libp2p.volumeMount.path" . }}
  volumeMounts:
    - name: libp2p-secret
      mountPath: /libp2p-secret
    - name: {{ include "ocaml-test-node.libp2p.volume.name" . }}
      mountPath: {{ include "ocaml-test-node.libp2p.volumeMount.path" .  }}
{{- end }}
{{- end }}

{{/*
Init container for fixing permissions for libp2p dir/files
*/}}
{{- define "ocaml-test-node.libp2p.initContainers.fixPermissions" }}
- name: fix-libp2p-permissions
  image: busybox
  command: [ "chmod", "-R", "0700", {{ include "ocaml-test-node.libp2p.volumeMount.path" . | quote }} ]
  volumeMounts:
    - name: {{ include "ocaml-test-node.libp2p.volume.name" . }}
      mountPath: {{ include "ocaml-test-node.libp2p.volumeMount.path" . }}
{{- end }}

{{/*
Libp2p volume mount
*/}}
{{- define "ocaml-test-node.libp2p.volumeMounts" }}
- name: {{ include "ocaml-test-node.libp2p.volume.name" . }}
  mountPath: {{ include "ocaml-test-node.libp2p.volumeMount.path" . }}
{{- end }}

{{/*
Volume name for libp2p key
*/}}
{{- define "ocaml-test-node.libp2p.volume.name" -}}
libp2p-key
{{- end }}

{{/*
Volume for secret with libp2p key
*/}}
{{- define "ocaml-test-node.libp2p.secret.volume" }}
{{- if .Values.libp2p.secret }}
- name: libp2p-secret
  secret:
    secretName: {{ include "ocaml-test-node.libp2p.secret.name" . }}
{{- end }}
{{- end }}

{{/*
Volume containing libp2p key
*/}}
{{- define "ocaml-test-node.libp2p.volume" }}
- name: {{ include "ocaml-test-node.libp2p.volume.name" . }}
  emptyDir: {}
{{- end }}
