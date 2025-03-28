# Use offical NGINX image as the base image
FROM nginx:latest

# set environmental vadriable for the Elastic version
ARG STACK_VERSION
ARG ENDPOINT_VERSION
ENV ARTIFACT_DOWNLOAD_BASE_URL=https://artifacts.elastic.co/downloads

# set build arguments for proxy
ARG http_proxy
ARG https_proxy
ARG no_proxy

# cert and key for the secure connection
COPY server.crt /opt/nginx/ssl/server.crt
COPY server.key /opt/nginx/ssl/server.key

# configure environmental variables for proxy 
ENV http_proxy=${http_proxy}
ENV https_proxy=${https_proxy}

# install necessay tools
RUN apt-get update && \
    apt-get install -y wget curl jq unzip && \
    rm -rf /var/lib/apt/lists/*

# Create directories for downloaoding artifacts and serving via NGINX
RUN mkdir -p /opt/elastic-package/elastic && \
    mkdir -p usr/share/nginx/elastic

# Copy the download scripts into the docker image
COPY download-artifacts.sh /usr/local/bin/download-artifacts.sh
RUN chmod +x /usr/local/bin/download-artifacts.sh

# Copy the NGINX configuration into the docker image
COPY nginx.conf /etc/nginx/conf.d/elastic-nginx.conf
WORKDIR /opt/elastic-package/elastic

# set environmental vadriable for the downlaod directoriy
ENV DOWNLOAD_BASE_DIR=/opt/elastic-package/elastic

# Run the download script
RUN /usr/local/bin/download-artifacts.sh

# Move downlaod artifacts to the NGINX directory
RUN mv /opt/elastic-package/elastic/* /usr/share/nginx/html/elastic


RUN chmod -R 755 /usr/share/nginx/html/elastic

# Expose secure port
EXPOSE 443

#  Expose insecure port
EXPOSE 80

# Start the NGINX server
CMD ["nginx", "-g", "demon off;"]
    


