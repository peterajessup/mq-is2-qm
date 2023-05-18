oc project mq
oc  wait -n mq pod --for=condition=Ready -l testTarget=mq2 --timeout=100s
oc apply -f test/app-subscriber-service.yaml
oc apply -f test/mq-tester.yaml --wait
oc  wait -n mq pod --for=condition=Ready -l app=sunscriber --timeout=100s
