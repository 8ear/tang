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
ENV TANG_CACHE_PATH="/var/cache/tang"
COPY --from=build /opt/tang /opt/tang
COPY .github/workflows/install-dependencies /tmp/install-dependencies
RUN \
  export SKIP_ADDITIONAL_PACKAGES="yes" \
  ;/tmp/install-dependencies \
  ; rm -Rf /tmp/install-dependencies \
  ;useradd -g $GID -u $UID -d $TANG_CACHE_PATH -ms /bin/bash tang \
  ;
COPY --chown=tang:tang docker/entrypoint.sh /entrypoint.sh
USER tang
ENTRYPOINT ["/entrypoint.sh"]
