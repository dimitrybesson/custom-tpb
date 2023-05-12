FROM harbor-repo.vmware.com/esback/tpb-scratch-core:latest AS tpb

FROM harbor-repo.vmware.com/dockerhub-proxy-cache/library/node:16.17-bullseye-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends libsqlite3-dev python3 build-essential && \
    rm -rf /var/lib/apt/lists/* && \
    yarn config set python /usr/bin/python3

COPY --from=tpb ./core ./

COPY tpb-config.yaml ./tpb-config.yaml

RUN yarn install
RUN yarn tsc
RUN yarn build

EXPOSE 8080