# cp4idemomq

This repository is to be used for creating an MQ Queue Manager on OCP, version 4.4.x, with IBM's Cloudpak for Integration Installed (verison 202.2.1 or higher).

The artifacts include a BuildConfig, an MQ QueueManager Object Custom resource definition, a Dockerfile for the image build, and
a route object associated with the channel created for access to the queue manager from outside the cluster.

In addition, a tls key and cert is provided for the queue manager's keystore, and a secret should be created 
using these artifacts. These files should also be used to create a keystore for the MQ client to connect, for simplicity.
Alternatively you can fork this repository and use your own certs and keys.

The configuration assumes an ImageStream object named mqivt exists on the cluster, in the mq namespace

A sample script for the full deployment is as follows:
Note the script is written to ignore deletion errors of objects on the target cluster 
```
#set the namespace (project) name
oc project mq 
set +e
# remove the existing (if any) build config
oc delete BuildConfig mqivt
set -e
# Create the BuildConfig object
oc create -f mqBuildConfig.yaml 

# Start the build
oc start-build mqivt
set +e
# Delete the route object and secret for the QueuManager keystore (if any)
oc delete route mq1route
oc delete secret mq1key
set -e
# Create the route and the keystore secret
oc apply -f mq1Route.yaml
oc create secret tls mq1key --cert=./tls/tls.crt --key=./tls/tls.key

set +e
# Remove the runnning queue manager instance (if any)
oc delete QueueManager mq1
set -e
oc apply -f mqDeploy.yaml
```
