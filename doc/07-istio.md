Istio
===

curl -L https://istio.io/downloadIstio | sh -
cd istio-1.4.0
bin/istioctl manifest apply --set profile=demo


kubectl get svc -n istio-system

kubectl delete namespaces istio-system
bin/istioctl manifest apply --set profile=demo | kubectl delete -f -

kubectl label namespace default istio-injection=enabled

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

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



[zurück](https://github.com/JohnnyW74/DevOpsCon2019/blob/master/doc/06-metallb.md) [weiter](https://github.com/JohnnyW74/DevOpsCon2019/blob/master/doc/08-examples.md)
