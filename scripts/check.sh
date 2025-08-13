#!/bin/bash
set -euo pipefail

install_if_missing() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Installing $1..."
        case "$1" in
            docker)
                sudo apt-get update && sudo apt-get install -y docker.io
                ;;
            kind)
		[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.29.0/kind-linux-amd64
		chmod +x ./kind
		sudo mv ./kind /usr/local/bin/kind
		kind
                ;;
            kubectl)
		export os="$(uname | tr '[:upper:]' '[:lower:]')/$(uname -m)"
		curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/$os/kubectl"
		chmod +x ./kubectl
		sudo mv ./kubectl /usr/local/bin/kubectl
		kubectl version --client
                ;;
            helm)
                curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
                ;;
            helmfile)
                curl -Lo helmfile.tar.gz https://github.com/helmfile/helmfile/releases/latest/download/helmfile_$(uname -s)_$(uname -m).tar.gz
                tar -xzf helmfile.tar.gz && sudo mv helmfile /usr/local/bin/
                ;;
            *)
                echo "Unknown dependency: $1"
                exit 1
                ;;
        esac
    else
        echo "$1 already installed"
    fi
}

install_if_missing docker
install_if_missing kind
install_if_missing kubectl
install_if_missing helm

echo "all dependencies installed"
