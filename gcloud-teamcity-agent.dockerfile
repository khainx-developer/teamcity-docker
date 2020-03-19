# docker build -f gcloud-teamcity-agent.dockerfile -t gcloud-teamcity-agent .
# docker tag gcloud-teamcity-agent khainx127/gcloud-teamcity-agent
# docker push khainx127/gcloud-teamcity-agent
FROM jetbrains/teamcity-agent

RUN curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose && \
    docker-compose -version

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get install -y apt-transport-https ca-certificates gnupg
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install -y google-cloud-sdk

RUN apt-get update && apt-get install -y apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl

RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
RUN apt install -y nodejs
RUN node --version
RUN npm --version

RUN echo "\nauto_authorize=true" >> /opt/buildagent/conf_dist/buildAgent.dist.properties
RUN echo "\nautoManage=true" >> /opt/buildagent/conf_dist/buildAgent.dist.properties
RUN echo "\nautoAuthorize=true" >> /opt/buildagent/conf_dist/buildAgent.dist.properties
# RUN cat /opt/buildagent/conf_dist/buildAgent.dist.properties
