set -e

PROTOS_PATH=$(realpath "$PWD/../../proto")
PROTOC_GEN_TS_PATH="$PWD/node_modules/.bin/protoc-gen-ts"

rm -rf ./dist ./src
mkdir -p ./dist ./src

find $PROTOS_PATH \
  -name '*.proto' \
  -exec \
    grpc_tools_node_protoc \
      --proto_path $PROTOS_PATH \
      --plugin=protoc-gen-ts=./node_modules/.bin/protoc-gen-ts \
      --ts_out=service=grpc-node,mode=grpc-js:./src \
      --ts_opt=no_namespace,unary_rpc_promise=true \
      {} \;

tsc

cp ./package.json ./dist/package.json
