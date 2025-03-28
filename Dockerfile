FROM nginx:latest

ARG STACK_VERSION
ARG ENDPOINT_VERSION
ENV ARTIFACT_DOWNLOAD_BASE_URL=https://artifacts.elastic.co/downloads

ARG http_proxy
ARG https_proxy
ARG no_proxy

COPY server.crt /opt/nginx/ssl/server.crt
COPY server.key /opt/nginx/ssl/server.key

ENV http_proxy=${http_proxy}
ENV https_proxy=${https_proxy}

RUN apt-get update && \
    apt-get install -y wget curl jq unzip && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/elastic-package/elastic && \
    mkdir -p usr/share/nginx/elastic

COPY download-artifacts.sh /usr/local/bin/download-artifacts.sh
RUN chmod +x /usr/local/bin/download-artifacts.sh

COPY nginx.conf /etc/nginx/conf.d/elastic-nginx.conf
WORKDIR /opt/elastic-package/elastic

ENV DOWNLOAD_BASE_DIR=/opt/elastic-package/elastic

RUN /usr/local/bin/download-artifacts.sh

RUN mv /opt/elastic-package/elastic/* /usr/share/nginx/html/elastic

RUN chmod -R 755 /usr/share/nginx/html/elastic

EXPOSE 443

CMD ["nginx", "-g", "demon off;"]
    


