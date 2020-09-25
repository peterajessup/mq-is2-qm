FROM cp.icr.io/cp/ibm-mqadvanced-server-integration:9.2.0.0-r1-amd64
COPY ./mqsc/ivt.mqsc /etc/mqm/ivt.mqsc
