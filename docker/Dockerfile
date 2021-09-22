ARG DISTRO
FROM ${DISTRO} as build
ENV DISTRO = ${DISTRO}
WORKDIR /opt/tang
COPY .github/workflows/install-dependencies /tmp/install-dependencies
RUN set -eu \
  ;chmod +x /tmp/install-dependencies \
  ;/tmp/install-dependencies \
  ;

# FROM ${FROM} as final
