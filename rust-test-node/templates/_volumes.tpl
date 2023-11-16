{{/*
Volumes for Openmina pod
*/}}
{{- define "rust-test-node.volumes" }}
{{- if .Values.record }}
- name: record
  hostPath:
    path: /tmp/record-{{ randAlpha 5 }}
{{- end }}
{{- end }}

{{/*
Volume mounts for Openmina main container
*/}}
{{- define "rust-test-node.volumeMounts" }}
{{- if .Values.record }}
- name: record
  mountPath: /record
{{- end }}
{{- end }}
