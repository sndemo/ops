#needs to be called first
.install-secret:
	kubectl create -n istio-system secret tls istio-ingressgateway-certs --key certs/sndemo.com.key.pem --cert certs/sndemo.com.cert.pem
.delete-secret:
	kubectl delete --ignore-not-found=true -n istio-system secret istio-ingressgateway-certs

.install-ms-gateway:
	kubectl apply -f gateway/ms-gateway.yaml
.delete-ms-gateway:
	kubectl delete -f gateway/ms-gateway.yaml

.install-argocd-gateway:
	kubectl apply -f gateway/argocd-gateway.yaml
.delete-argocd-gateway:
	kubectl delete -f gateway/argocd-gateway.yaml

.install-k8s-gateway:
	kubectl apply -f gateway/k8s-gateway.yaml
	kubectl create serviceaccount demo-dashboard-sa
	kubectl create clusterrolebinding demo-dashboard-sa --clusterrole=cluster-admin --serviceaccount=default:demo-dashboard-sa
	kubectl describe secret
	echo "run kubectl describe secret <secret name> to get the token"

.delete-k8s-gateway:
	kubectl delete -f gateway/k8s-gateway.yaml
	kubectl delete serviceaccount demo-dashboard-sa
	kubectl delete clusterrolebinding demo-dashboard-sa

# for services exposed by istio: prometheus, servicegraph, jaeger-query, grafana
.install-istio-gateway:
	kubectl apply -f gateway/istio-gateway.yaml
.delete-istio-gateway:
	kubectl delete -f gateway/istio-gateway.yaml

.install-all-gateways: .install-secret .install-ms-gateway .install-k8s-gateway .install-istio-gateway

.delete-all-gateways: .delete-ms-gateway .delete-k8s-gateway .delete-istio-gateway .delete-secret 
