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

# Install yt-dlp
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Install yt-dlp-wrap via npm
RUN npm install -g yt-dlp-wrap

# Install the community node
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install @endcycles/n8n-nodes-youtube-transcript

USER node

CMD ["n8n", "start"]
