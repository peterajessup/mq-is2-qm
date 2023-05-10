oc project mq
oc  wait -n mq pod --for=condition=Ready -l testTarget=mq2
oc apply -f test/app-subscriber-service.yaml
oc apply -f test/mq-tester.yaml
