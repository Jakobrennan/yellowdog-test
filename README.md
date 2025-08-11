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

