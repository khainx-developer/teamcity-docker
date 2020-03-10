# docker build -f agent.dockerfile -t docker-compose-teamcity-agent .
# docker tag docker-compose-teamcity-agent khainx127/docker-compose-teamcity-agent
# docker push khainx127/docker-compose-teamcity-agent
FROM jetbrains/teamcity-agent

RUN curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose && \
    docker-compose -version