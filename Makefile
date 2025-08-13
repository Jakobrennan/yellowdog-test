.ONESHELL:
.DEFAULT_GOAL := help

KIND_NAME := yellowdog
GRAFANA_NS := grafana
ALLOY_NS := alloy
MIMIR_NS := mimir
LOKI_NS := loki
TRIVY_NS := trivy

help: ## show help
	printf "up - brings everything up\ngrafana - sets up grafana in isolation\n"

up: preflight 

preflight: ./scripts/check.sh
	./scripts/check.sh

dependencies: docker kind kubectl helm nvm

docker:
	sudo apt-get update && sudo apt-get install -y docker.io

kind:
	[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.29.0/kind-linux-amd64
	chmod +x ./kind
	sudo mv ./kind /usr/local/bin/kind
	kind

kubectl:
	export os="$(uname | tr '[:upper:]' '[:lower:]')/$(uname -m)"
	curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/$os/kubectl"
	chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/kubectl
	kubectl version --client

helm:
	curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helmfile:
	curl -Lo helmfile.tar.gz https://github.com/helmfile/helmfile/releases/latest/download/helmfile_$(uname -s)_$(uname -m).tar.gz
	tar -xzf helmfile.tar.gz && sudo mv helmfile /usr/local/bin/

nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
	source ~/.bashrc
	nvm use --lts

setup: create_clusters

create_clusters:
	kind create cluster
	kubectl create ns $(GRAFANA_NS)
	kubectl create ns $(ALLOY_NS)
	kubectl create ns $(MIMIR_NS)
	kubectl create ns $(LOKI_NS)
	kubectl create ns $(TRIVY_NS)

install_grafana:
#,g	helm repo add grafana https://grafana.github.io/helm-charts
#,g	helm repo update
#,g	helm install $(GRAFANA_NS) grafana/grafana --namespace $(GRAFANA_NS)
#,g	echo "PASSWORD=" 
#,g	kubectl get secret --namespace $(GRAFANA_NS) $(GRAFANA_NS) -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
	POD_NAME=$(kubectl get pods --namespace $(GRAFANA_NS) -l "app.kubernetes.io/name=$(GRAFANA_NS)-o jsonpath="{.items[0].metadata.name}") 
	echo $$POD_NAME
	kubectl --namespace $(GRAFANA_NS) port-forward $$POD_NAME 3000


clean:
	kind delete cluster
