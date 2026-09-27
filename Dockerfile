ARG CADVISOR_VERSION=0.60.6

FROM ghcr.io/google/cadvisor:${CADVISOR_VERSION}

ARG CADVISOR_VERSION

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"
LABEL org.opencontainers.image.title="cAdvisor"
LABEL org.opencontainers.image.description="Thin republish of ghcr.io/google/cadvisor for Dockette"
LABEL org.opencontainers.image.version="${CADVISOR_VERSION}"
LABEL org.opencontainers.image.source="https://github.com/dockette/cadvisor"
