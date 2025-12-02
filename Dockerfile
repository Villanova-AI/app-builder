FROM registry.access.redhat.com/ubi8/nginx-122:1-18
ARG VERSION
### Required OpenShift Labels
LABEL name="Villanova App Builder" \
      maintainer="dev@evillanova.ai" \
      vendor="Villanova SPA" \
      version="v${VERSION}" \
      release="0.9" \
      summary="Villanova App Builder" \
      description="The Villanova App Builder is the front end environment to interact with the micro frontends, the WCMS, and other Villanova components"

COPY licenses /licenses

EXPOSE 8081
COPY ./build /opt/app-root/src/app-builder
USER root
#RUN yum -y update
RUN fix-permissions /opt/app-root/src/app-builder
COPY ./nginx.conf ${NGINX_CONF_PATH}
USER default
COPY ./docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

