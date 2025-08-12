# yellowdog test submission

This is the submission for the test sent.

## initial setup

- vmware ubuntu blank imager
    - ubuntu version 25.05 LTS
- nodejs via [nvm](https://github.com/nvm-sh/nvm)
- then install [mmdc](https://github.com/mermaid-js/mermaid-cli) for diagrams in documentation
- via my local tmux session manager and WSL2 setup, i could ssh onto the vmware server and run multiple installations concurrently to save a minor amount of time. This will give me some time to read a little more later about tools i haven't used yet.

## installing everything 

- `docker`: with ubuntu inital installation, you can select the docker image on install.
    - unfortunately setting up groups was causing issues so i have given the `yellowdog` user root access, this is not advisable in production.
- the rest of the list was just following installation page for:
    - [kubectl](https://kubectl.docs.kubernetes.io/installation/kubectl/binaries/)
    - [kind](https://kind.sigs.k8s.io/docs/user/quick-start)
    - [helm](https://helm.sh/docs/intro/install/)

## setting up a local cluster

- run `kind create cluster`
- wait

## setting up installations of monitoring tools.

- grafana
    - followed the manual steps for installing grafana via kubernetes
    - in hindsight i think i was rushing, using helm should have been easier
    - redoing the setup, keep following output for reference:
```bash
NAME: grafana
LAST DEPLOYED: Tue Aug 12 09:05:58 2025
NAMESPACE: grafana
STATUS: deployed
REVISION: 1
NOTES:
1. Get your 'admin' user password by running:

   kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo


2. The Grafana server can be accessed via port 80 on the following DNS name from within your cluster:

   grafana.grafana.svc.cluster.local

   Get the Grafana URL to visit by running these commands in the same shell:
     export POD_NAME=$(kubectl get pods --namespace grafana -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
     kubectl --namespace grafana port-forward $POD_NAME 3000

3. Login with the password from step 1 and the username: admin
#################################################################################
######   WARNING: Persistence is disabled!!! You will lose your data when   #####
######            the Grafana pod is terminated.                            #####
#################################################################################
```


- mimir
    - running the helm chart commands to install [mimir](https://grafana.com/docs/helm-charts/mimir-distributed/latest/get-started-helm-charts/)
    - 

---

# issues encountered 

- running on a vm machine
    - memory quickly was taken up
    - 20gb did not suffice, then 30 did not
    - attempt to keep things small didn't work

# questions encountered

- how are we handling maintenance of this going forward?
    - do we want to freeze version numbers to prevents os updated from crashing the system?
    -

