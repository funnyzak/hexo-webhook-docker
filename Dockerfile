FROM funnyzak/git-webhook-node-build

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.vendor="potato<silenceace@gmail.com>" \
    org.label-schema.name="HexoWebhook" \
    org.label-schema.build-date="${BUILD_DATE}" \
    org.label-schema.description="Pull your hexo project Git code into a data volume and trigger automatic packaging via Webhook." \
    org.label-schema.url="https://yycc.me" \
    org.label-schema.schema-version="1.0"	\
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-ref="${VCS_REF}" \
    org.label-schema.vcs-url="https://github.com/funnyzak/hexo-webhook-docker" 

ENV BUILD_COMMAND npm run build
ENV INSTALL_DEPS_COMMAND npm install
ENV OUTPUT_DIRECTORY public/

EXPOSE 80
