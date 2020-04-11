FROM golang

LABEL maintainer="potato" \
        org.label-schema.name="hexo-web"

ENV LANG=C.UTF-8

RUN apt-get update
RUN apt-get install -y git ssh rsync

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get update && apt-get install -y nodejs

RUN mkdir -p /app/hook \
    && mkdir -p /app/source \
    && mkdir -p /app/output \
    && mkdir -p /root/.ssh \
    && go get github.com/adnanh/webhook

COPY hooks.json /app/hook/hooks.json
COPY webhook.sh /app/hook/webhook.sh
COPY entrypoint.sh /app/hook/entrypoint.sh


WORKDIR /app/hook

RUN chmod +x /app/hook/webhook.sh

EXPOSE 9000

ENTRYPOINT ["sh", "/app/hook/entrypoint.sh"]
