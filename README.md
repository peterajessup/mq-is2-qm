# cp4idemomq

This repository is to be used for creating a NativeHA MQ Queue Manager on OCP, version 4.6.x, with IBM's Cloudpak for Integration Installed (verison 2021.1.1 or higher).

The artifacts include an MQ QueueManager Object Custom resource definition and
a route object associated with the channel created for access to the queue manager from outside the cluster, as well as an MQSC source yaml used to create a config-map object used for configuring the queue manager. 

In addition, a tls key and cert is provided for the queue manager's keystore, and a secret is created 
using these artifacts. These files should also be used to create a keystore for the MQ client to connect, for simplicity.
Alternatively you can fork this repository and use your own certs and keys.

A sample script for the full deployment is as follows:
Note the script is written to ignore deletion errors of objects on the target cluster 
```
oc project mq 
set +e
# Remove the runnning queue manager instance (if any)

oc delete QueueManager mq1

# Delete the route object and secret for the QueueManager keystore (if any), and the mqsc configMap
oc delete route mq1route
oc delete secret mq1key
oc delete configMap ivt-mqsc
set -e
# Create the route and the keystore secret and mqsc configMap
oc apply -f mq1Route.yaml
oc create secret tls mq1key --cert=./tls/tls.crt --key=./tls/tls.key
oc create -f mqsc/mqsc.yaml

set -e
oc apply -f mqDeploy.yaml
```
