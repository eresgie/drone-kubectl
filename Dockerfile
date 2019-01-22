FROM alpine:3.8
LABEL name="drone-kubectl-plugin"
LABEL maintainer="eresgie <eresgie@gmail.com>"
LABEL version=1

ENV KUBECTL_VERSION="v1.13.2"

RUN \
  apk add --update ca-certificates && \
  apk add -t deps curl bash && \
  apk add bash

RUN \
  curl -Lo /usr/local/bin/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
  chmod +x /usr/local/bin/kubectl && \
  apk del --purge deps && \
  rm /var/cache/apk/*

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]