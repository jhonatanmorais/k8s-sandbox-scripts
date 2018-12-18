#!/bin/sh

NAMESPACE=monitoring
INTERVAL=90s

for svcmon in $(kubectl get servicemonitor -n $NAMESPACE --no-headers | awk '{print $1}'); do     
	kubectl get servicemonitor $svcmon -n $NAMESPACE -o yaml > $svcmon.yml; 
	sed 's/interval:\ [0-9]\+[s|m]$/'interval:\ $INTERVAL'/g' $svcmon.yml > new_$svcmon.yml;
	kubectl apply -f new_$svcmon.yml;
done
