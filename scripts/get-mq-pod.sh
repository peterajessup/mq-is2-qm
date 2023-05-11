#!/bin/bash
while true
do
  resource=$(oc get pods | grep mq2 | awk '{print $1;}')
  if [ -z "$resource" ]
  then
      echo "Pod not created yet. Trying again in 5 seconds.."
  else
     if [ $resource == "mq2-ibm-mq-0" ]; then
       echo "Strings are equal"
       break
     else
       echo "This condition should not fire..."
    fi
  fi
  sleep 5
done
