#!/bin/bash -e
#
############################################################

export DEPLOYMENT=$1
export PORT=22
export SERVER=spinoza.brightblock.org
export DOCKER_NAME=txtxflow_api_production
export TARGET_ENV=linode-production
export DOCKER_ID_USER='mijoco'

printf "\n==================================="
printf "\nBuilding image: mijoco/txtxflow_api."
printf "\nConnecting to: $SERVER on ssh port $PORT"
printf "\nDeploying container: $DOCKER_NAME."
printf "\nDeploying target: $TARGET_ENV."
printf "\n\n"

#docker build -t mijoco/txtxflow_api .

docker buildx create --use
docker buildx build --platform linux/amd64 -t mijoco/txtxflow_api .
docker tag mijoco/txtxflow_api mijoco/txtxflow_api
docker push mijoco/txtxflow_api:latest


  ssh -i ~/.ssh/id_rsa -p $PORT bob@$SERVER "
    source ~/.profile;
    docker login;
    docker pull mijoco/txtxflow_api;
    docker rm -f txtxflow_api  
    docker run -d -t -i --network host --env-file ~/.env --name txtxflow_api -p 6060:6060 mijoco/txtxflow_api
  ";

printf "Finished....\n"
printf "\n-----------------------------------------------------------------------------------------------------\n";

exit 0;

#-e btcRpcUser=${AIFLOW_BTC_RPC_USER} -e btcRpcPwd=${AIFLOW_BTC_RPC_PWD} -e btcNode=${AIFLOW_BTC_NODE} -e mongoDbUrl=${AIFLOW_MONGO_URL} -e mongoDbName=${AIFLOW_MONGO_DBNAME} -e mongoUser=${AIFLOW_MONGO_USER} -e mongoPwd=${AIFLOW_MONGO_PWD} -e sbtcContractId=${AIFLOW_SBTC_CONTRACT_ID} -e poxContractId=${POX_CONTRACT_ID} -e stacksApi=${AIFLOW_STACKS_API} -e bitcoinExplorerUrl=${AIFLOW_BITCOIN_EXPLORER_URL} -e mempoolUrl=${AIFLOW_MEMPOOL_URL} -e blockCypherUrl=${AIFLOW_BLOCK_CYPHER_URL} -e publicAppName=${AIFLOW_PUBLIC_APP} -e publicAppVersion=${AIFLOW_PUBLIC_APP_VERSION} -e host=${AIFLOW_HOST} -e port=${AIFLOW_PORT} -e walletPath=${AIFLOW_WALLET_PATH}