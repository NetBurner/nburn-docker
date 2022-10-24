FROM ubuntu:focal AS installer
ARG NNDK_INSTALLER
ARG SERIAL_NUMBER
RUN ["/bin/bash", "-c", ": ${NNDK_INSTALLER:?NNDK_INSTALLER must be set to a local NNDK installer .run file. Set with --build-arg NNDK_INSTALLER=<file location>}"]
RUN ["/bin/bash", "-c", ": ${SERIAL_NUMBER:?SERIAL_NUMBER must be set to valid NNDK Serial Number. Set with --build-arg SERIAL_NUMBER=<plaform>:<key>}"]
COPY $NNDK_INSTALLER /tmp/NNDK-installer.run
RUN chmod +x /tmp/NNDK-installer.run \
    && /tmp/NNDK-installer.run --mode unattended --hwlicense1 y --hwlicense2 y --serialnum0 $SERIAL_NUMBER --installdir /opt/nburn

FROM alpine:latest
COPY --from=installer /opt/nburn /opt/nburn
RUN apk update \
    && apk add --no-cache bash make libc6-compat libstdc++ wget sed netcat-openbsd jq
ENV NNDK_ROOT=/opt/nburn \
    PLATFORM=MODM7AE70 \
    PATH="/opt/nburn/pcbin:/opt/nburn/gcc/bin:$PATH" \
    PS1='\w\$ '
WORKDIR /opt/nburn
CMD /bin/bash
