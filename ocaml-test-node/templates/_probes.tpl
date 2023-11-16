{{/*
OCaml node readiness probe
*/}}
{{- define "ocaml-test-node.readinessProbe" }}
{{- with include "mina-common.readinessProbe" . }}
readinessProbe:
  {{- if (eq . "P2PSocket") }}
  tcpSocket:
    port: "external"
  {{- else }}
  {{- fail (printf "unknown readiness probe kind: '%s'" .) }}
  {{- end }}
{{- end }}
{{- end }}
