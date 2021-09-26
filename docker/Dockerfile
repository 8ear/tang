# added to choose the correct image
ARG DISTRO
FROM ${DISTRO} as build
# Must be added second time for the ARG in the build
ARG DISTRO
COPY .github/workflows/install-dependencies /tmp/install-dependencies
RUN /tmp/install-dependencies

WORKDIR /opt/build
COPY . .
RUN set -eu \
  ;mkdir -p build && cd build \
  ;export ninja=$(command -v ninja) \
  ;[ -z "${ninja}" ] && export ninja=$(command -v ninja-build) \
  ;meson .. --prefix=/opt/tang || cat meson-logs/meson-log.txt >&2 \
  ;${ninja} \
  ;${ninja} install \
  ;

# Final build without build tools
FROM ${DISTRO} as final
ARG DISTRO
WORKDIR /opt/tang
ENV PATH=${PATH}:/opt/tang
COPY --from=build /opt/tang /opt/tang
COPY .github/workflows/install-dependencies /tmp/install-dependencies
RUN \
  export SKIP_ADDITIONAL_PACKAGES="yes" \
  ;/tmp/install-dependencies \
  ; rm -Rf /tmp/install-dependencies
# Install s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /
ENTRYPOINT ["/init"]
