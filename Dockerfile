FROM golang

LABEL maintainer="potato" \
        org.label-schema.name="hexo-web"

ENV LANG=C.UTF-8
RUN apt-get update
RUN apt-get install -y git nginx

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get update && apt-get install -y nodejs

RUN mkdir -p /app \
    && mkdir -p /source \
    && go get github.com/adnanh/webhook

COPY hooks.json /app/hooks.json
COPY webhook.sh /app/webhook.sh

WORKDIR /app

RUN chmod +x webhook.sh
ENTRYPOINT /go/bin/webhook -hooks /app/hooks.json -verbose

EXPOSE 4000