# cp4idemomq

This repository is to be used for creating an MQ Queue Manager on OCP, version 4.10.x, with IBM's Cloudpak for Integration Installed (verison 2022.2.1 or higher).

The artifacts include an MQ QueueManager Object Custom resource definition and
a route object associated with the channel created for access to the queue manager from outside the cluster, as well as an MQSC source yaml used to create a config-map object used for configuring the queue manager. 

In addition, a tls key and cert is provided for the queue manager's keystore, and a secret is created 
using these artifacts. These files can also be used to create a keystore for the MQ client to connect, for simplicity.
Alternatively you can fork this repository and use your own certs and keys.

