# Use specified Alpine Linux NGINX version image:
FROM ubuntu:22.04

# Pass arguments:
ARG DB_NAME
ARG DB_USERNAME
ARG DB_PASSWORD

# Install wget:
RUN apt update && apt -y upgrade && apt -y install \
        wget \
        nginx \
    && apt -y autoremove \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Install Focalboard through tarball:
RUN wget -c https://github.com/mattermost/focalboard/releases/download/v7.11.3/focalboard-server-linux-amd64.tar.gz -O - | tar -xzC /opt

# Copy Focalboard NGINX configuration in right folder:
COPY focalboard.conf /etc/nginx/sites-available/focalboard

# Enable NGINX configuration:
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/focalboard /etc/nginx/sites-enabled/focalboard
# RUN nginx -t
# RUN /etc/init.d/nginx reload

# Modify Focalboard "config.json" file to use PostgreSQL database:
RUN sed -Ee 's#("dbtype": ").*(")#\1postgres\2#' \
    -e "s#(\"dbconfig\": \").*(\")#\1postgres://${DB_USERNAME}:${DB_PASSWORD}@db/boards?sslmode=disable\&connect_timeout=10\2#" \
    -e "s#(\"postgres_dbconfig\": \"dbname=).*(\ssslmode=disable\")#\1${DB_NAME}\2#" \
    -i /opt/focalboard/config.json

# Run server:
COPY entrypoint.sh /root/entrypoint.sh
WORKDIR /opt/focalboard
ENTRYPOINT [ "/root/entrypoint.sh" ]
