ARG DISTRO
FROM ${DISTRO} as build
ENV DISTRO=${DISTRO}
WORKDIR /opt/tang
COPY .github/workflows/install-dependencies /tmp/install-dependencies
RUN set -eu \
  ;chmod +x /tmp/install-dependencies \
  ; echo "${DISTRO}" \
  ;/tmp/install-dependencies \
  ;

RUN set -eu \
  ;mkdir -p build && cd build \
  ;export ninja=$(command -v ninja) \
  ;[ -z "${ninja}" ] && export ninja=$(command -v ninja-build) \
  ;meson .. || cat meson-logs/meson-log.txt >&2 \
  ;${ninja} \
  ;

# FROM ${FROM} as final
