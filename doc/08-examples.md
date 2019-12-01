Beispiele
===

```
kubectl apply -f samples/httpbin/httpbin.yaml

kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: httpbin-gateway
spec:
  selector:
    istio: ingressgateway # use Istio default gateway implementation
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: httpbin
spec:
  hosts:
  - "*"
  gateways:
  - httpbin-gateway
  http:
  - match:
    - uri:
        prefix: /headers
    route:
    - destination:
        port:
          number: 8000
        host: httpbin
EOF

kubectl get gateway --all-namespaces
```

Browse [http://192.168.122.240/headers](http://192.168.122.240/headers)

> https://istio.io/docs/tasks/traffic-management/ingress/ingress-control/

[zurück](https://github.com/JohnnyW74/DevOpsCon2019/blob/master/doc/07-istio.md) [weiter](https://github.com/JohnnyW74/DevOpsCon2019/blob/master/doc/09-qa.md)
