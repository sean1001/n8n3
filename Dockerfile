FROM n8nio/n8n:latest

ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER
ARG ENCRYPTION_KEY

ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD
ENV N8N_ENCRYPTION_KEY=$ENCRYPTION_KEY

USER root

# Install Python, curl, and other dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    curl \
    nodejs \
    npm

# Install the community node
RUN cd /usr/local/lib/node_modules/n8n


USER node

CMD ["n8n start"]
