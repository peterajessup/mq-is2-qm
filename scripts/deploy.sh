#!/bin/bash
oc project mq 
set +e
# Remove the runnning queue manager instance (if any)

oc delete QueueManager mq2

# Delete the route object and secret for the QueueManager keystore (if any), and the mqsc configMap
oc delete route mq2route
oc delete secret mq2key
oc delete configMap mq2-mqsc
oc delete persistentvolumeclaim data-mq2-ibm-mq-0 
set -e
# Create the route and the keystore secret and mqsc configMap
oc apply -f mq2Route.yaml
oc create secret tls mq2key --cert=./tls/tls.crt --key=./tls/tls.key
oc create -f mqsc/mqsc.yaml

set -e
oc apply -f mqDeploy.yaml
