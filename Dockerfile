FROM harbor-repo.vmware.com/esback/tpb-scratch-core:latest AS tpb

FROM node:16

COPY --from=tpb ./core ./

COPY tpb-config.yaml ./tpb-config.yaml

RUN yarn install
RUN yarn tsc
RUN yarn build

EXPOSE 8080