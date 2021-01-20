# docker build -f teamcity-agent.dockerfile -t teamcity-agent .
# docker tag teamcity-agent khainx127/teamcity-agent
# docker push khainx127/teamcity-agentFROM jetbrains/teamcity-agent:2019.2.3-linux

RUN sudo apt-get update -y && sudo apt-get install -y apt-utils

RUN sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    sudo chmod +x /usr/local/bin/docker-compose && \
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose && \
    docker-compose -version

RUN sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates gnupg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN sudo apt-get update && sudo apt-get install -y google-cloud-sdk

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
RUN sudo apt-get update && sudo apt-get install -y kubectl

RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
# RUN node --version
# RUN npm --version

RUN sudo apt-get install -y gconf-service libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxss1 libxtst6 libappindicator1 libnss3 libasound2 libatk1.0-0 libc6 ca-certificates fonts-liberation lsb-release xdg-utils wget

RUN sudo apt-get remove cmdtest
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update
RUN sudo apt-get install yarn -y
RUN yarn --version
RUN echo "\nauto_authorize=true" >> /opt/buildagent/conf_dist/buildAgent.dist.properties
# RUN echo "\nautoManage=true" >> /opt/buildagent/conf_dist/buildAgent.dist.properties
# RUN echo "\nautoAuthorize=true" >> /opt/buildagent/conf_dist/buildAgent.dist.properties
# RUN cat /opt/buildagent/conf_dist/buildAgent.dist.properties

RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN sudo apt-get install -y apt-transport-https
RUN sudo apt-get update && sudo sudo apt-get install -y dotnet-sdk-3.1
RUN sudo apt-get install -y dotnet-sdk-2.1
RUN sudo apt-get install -y dotnet-sdk-5.0

RUN rm -f packages-microsoft-prod.deb
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install
RUN rm -f awscliv2.zip

RUN sudo apt-get install openjdk-11-jdk -y
RUN dotnet tool install --global dotnet-sonarscanner
RUN dotnet tool install --global coverlet.console 

RUN sudo apt-get upgrade -y
RUN sudo apt-get autoremove -y

