{{/*
Multiaddress of a peer
*/}}
{{- define "mina-common.peers.multiAddress" }}
{{- $name := include "mina-common.peers.dnsName" . }}
{{- $port := default "8302" .Peer.port }}
{{- $peerid := .Peer.peerId }}
{{- printf "/dns4/%s/tcp/%s/p2p/%s" $name $port $peerid }}
{{- end }}

{{/*
Peer DNS name (usually service name).
Assumes that the peer description is in .Values.Peer
*/}}
{{- define "mina-common.peers.dnsName" }}
{{- if .Peer.fullName }}
{{- .Peer.fullName -}}
{{- else }}
{{- include "mina-common.qname" (list .Peer.name .) | trim }}
{{- end }}
{{- end }}
