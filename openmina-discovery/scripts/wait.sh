#!/usr/bin/env sh

kubectl wait --for=condition=available --timeout=5m deployment $(for app in $*; do echo "$INSTANCE-$app"; done)
