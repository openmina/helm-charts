{{/*
Liveness probe: openmina node is alive when its statemachine progresses.
*/}}
{{- define "rust-test-node.livenessProbe" }}
{{- if .Values.probes.liveness }}
livenessProbe:
  initialDelaySeconds: 20
  periodSeconds: 10
  failureThreshold: 60
  httpGet:
    path: /healthz
    port: 3000
{{- end }}
{{- end }}

{{/*
Readiness probe: openmina node considered ready when it is in sync with the network.
*/}}
{{- define "rust-test-node.readinessProbe" }}
{{- if .Values.probes.readiness }}
readinessProbe:
  initialDelaySeconds: 60
  periodSeconds: 20
  failureThreshold: 60
  httpGet:
    path: /readyz
    port: 3000
{{- end }}
{{- end }}
