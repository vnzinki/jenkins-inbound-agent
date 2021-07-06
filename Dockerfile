FROM jenkins/inbound-agent

USER root

RUN  curl -sSL https://get.docker.com/ | sh && \
  curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh && \
  chmod 700 get_helm.sh && \
  ./get_helm.sh && \
  helm plugin install https://github.com/f3lan/helm-diff && \
  rm -f get_helm.sh && \
  curl -sSL https://github.com/roboll/helmfile/releases/download/v0.135.0/helmfile_linux_amd64 > helmfile && \
  chmod +x helmfile && \
  mv helmfile /usr/local/bin/helmfile && \
  curl -sSL https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl > kubectl && \
  chmod 755 kubectl && \
  mv kubectl /usr/local/bin/kubectl && \
  rm -rf /var/lib/apt/lists/*

USER jenkins
WORKDIR /home/jenkins
