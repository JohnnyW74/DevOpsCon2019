Istio
===

```
bin/istioctl manifest apply --set profile=demo
kubectl get svc -n istio-system
```
```
kubectl label namespace default istio-injection=enabled
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
```

[zurück](https://github.com/JohnnyW74/DevOpsCon2019/blob/master/doc/06-metallb.md) [weiter](https://github.com/JohnnyW74/DevOpsCon2019/blob/master/doc/08-examples.md)
