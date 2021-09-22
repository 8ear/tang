# added to choose the correct image
ARG DISTRO
FROM ${DISTRO} as build
# Must be added second time for the ARG in the build
ARG DISTRO
WORKDIR /opt/tang
COPY .github/workflows/install-dependencies /tmp/install-dependencies
RUN set -eu \
  ;chmod +x /tmp/install-dependencies \
  ; printenv \
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
# ARG DISTRO
