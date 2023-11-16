#!/usr/bin/env sh

get_pod() {
    kubectl get pod -l app.kubernetes.io/instance=$INSTANCE,app.kubernetes.io/name=$1 --output=name
}

get_pod_kind() {
    kubectl get $1 --output=jsonpath="{.metadata.labels['openmina\.com/node-kind']}"
}

run_for_pod_kind() {
    OCAML_CMD=$1
    RUST_CMD=$2
    shift 2
    KIND=$(get_pod_kind $1)
    case $KIND in
        ocaml) $OCAML_CMD "$@" ;;
        rust) $RUST_CMD "$@" ;;
        *) echo "unknown pod kind for $1: $KIND"; exit 1 ;;
    esac
}

get_peers_ip() {
    run_for_pod_kind get_ocaml_peers_ip get_rust_peers_ip $1
}

get_node_ips() {
    run_for_pod_kind get_ocaml_node_ips get_rust_node_ips $1 $2
}

get_ocaml_peers_ip() {
    kubectl exec $1 -c mina -- mina advanced get-peers | awk -v FS=/ '{ print $3 }'
}

get_rust_peers_ip() {
    kubectl exec $1 -- sh -c "curl -s localhost:3000/state | jq -r '.p2p.peers | to_entries | .[] | select(.value.status.Ready != null) | .value.dial_opts'" | awk -v FS=/ '{ print $3 }'
}

get_ocaml_node_ips() {
    echo $(kubectl get $1 --output=jsonpath='{.status.podIP}')
    echo $(kubectl get svc/$INSTANCE-$2 --output=jsonpath='{.spec.clusterIP}')
}

get_rust_node_ips() {
    kubectl get $1 --output=jsonpath='{.status.podIP}'
}

APPS="$*"

for APP in $APPS; do
    echo
    echo "=== app $APP..."
    POD=$(get_pod $APP)
    PEERS=$(get_peers_ip $POD)
    echo "-- peers:"
    echo $PEERS
    for PEER_APP in $APPS; do
        if [ $APP = $PEER_APP ]; then
            continue
        fi
        echo "= peer $PEER_APP..."
        PEER_POD=$(get_pod $PEER_APP)
        IPS=$(get_node_ips $PEER_POD $PEER_APP)
        echo "- IPs:"
        echo "$IPS"
        FOUND=""
        for IP in $IPS; do
            if echo $PEERS | grep -q -F $IP; then
                FOUND=true
                break;
            fi
        done
        if [ -z "$FOUND" ]; then
            echo '!!!!!!!!!!!!!!!!!!!!!!!'
            echo "$PEER_APP's IP is not found in $APP's peers"
            echo "$PEER_APP's IPs: $IPS"
            echo "$APP's peers:"
            echo $PEERS
            return 1
        fi
    done
done
