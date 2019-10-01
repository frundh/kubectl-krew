FROM golang AS build
ENV GOPATH=/go
RUN go get -u github.com/sysdiglabs/kubectl-dig/cmd/kubectl-dig

FROM ubuntu

ENV KREW_ROOT="/usr/local/.krew"
ENV PATH="$KREW_ROOT/bin:$PATH"

COPY --from=build /go/bin/kubectl-dig /usr/local/bin/kubectl-dig

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates curl git; \
    curl -SL https://storage.googleapis.com/kubernetes-release/release/v1.14.2/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl; \
    curl -SL https://raw.githubusercontent.com/sysdiglabs/kubectl-capture/master/kubectl-capture -o /usr/local/bin/kubectl-capture && chmod +x /usr/local/bin/kubectl-capture; \
    cd "$(mktemp -d)"; \
        curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v0.3.1/krew.{tar.gz,yaml}"; \ 
        tar zxvf krew.tar.gz && ./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" install --manifest=krew.yaml --archive=krew.tar.gz; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*