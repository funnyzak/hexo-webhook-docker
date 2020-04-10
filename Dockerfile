FROM golang

LABEL maintainer="potato" \
        org.label-schema.name="hexo-web"

ENV LANG=C.UTF-8
ENV GITHUB_REPO=https://github.com/hexojs/site.git
ENV GITHUB_EMAIL=hey@me.com

RUN apt-get update
RUN apt-get install -y git ssh rsync

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get update && apt-get install -y nodejs

RUN mkdir -p /app \
    && mkdir -p /source \
    && mkdir -p /output \
    && mkdir -p /root/.ssh \
    && go get github.com/adnanh/webhook

COPY hooks.json /app/hooks.json
COPY webhook.sh /app/webhook.sh
COPY entrypoint.sh /app/entrypoint.sh


WORKDIR /app

RUN chmod +x webhook.sh

EXPOSE 9000

ENTRYPOINT ["sh", "/app/entrypoint.sh"]
