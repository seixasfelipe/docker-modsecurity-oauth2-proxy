FROM owasp/modsecurity-crs:nginx-alpine as base

ARG OAUTH2_PROXY_VERSION=7.4.0

ADD nginx/njs /etc/nginx/njs

WORKDIR /etc/nginx/templates
COPY nginx/templates/nginx.conf.template ./

RUN mkdir -p /etc/oauth2-proxy
COPY oauth2-proxy/oauth2-proxy.conf /etc/oauth2-proxy/

# Installs Oauth2-proxy
RUN mkdir -p /tmp/oauth2-proxy-v$OAUTH2_PROXY_VERSION.linux-amd64/ && cd /tmp/ && \
    curl -SsLf https://github.com/oauth2-proxy/oauth2-proxy/releases/download/v7.4.0/oauth2-proxy-v$OAUTH2_PROXY_VERSION.linux-amd64.tar.gz -O && \
    curl -SsLf https://github.com/oauth2-proxy/oauth2-proxy/releases/download/v7.4.0/oauth2-proxy-v$OAUTH2_PROXY_VERSION.linux-amd64-sha256sum.txt --output oauth2-proxy-v$OAUTH2_PROXY_VERSION.linux-amd64.tar.gz.sha256 && \
    tar -zxf "oauth2-proxy-v$OAUTH2_PROXY_VERSION.linux-amd64.tar.gz" --no-same-owner && \
    sha256sum -c "oauth2-proxy-v$OAUTH2_PROXY_VERSION.linux-amd64.tar.gz.sha256" && \
    mv oauth2-proxy-v$OAUTH2_PROXY_VERSION.linux-amd64/oauth2-proxy /etc/oauth2-proxy/ && \
    rm -rf oauth2-proxy-v$OAUTH2_PROXY_VERSION.linux-amd64*

RUN chown -R 101:101 /etc/oauth2-proxy

WORKDIR /etc/oauth2-proxy
RUN ./oauth2-proxy --config=/etc/oauth2-proxy/oauth2-proxy.conf