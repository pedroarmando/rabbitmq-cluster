function up { docker stack deploy --compose-file docker-compose.yml rabbitmq }
function down { docker stack rm rabbitmq }
function mk { docker build --tag moskitos.azurecr.io/rabbitmq-node:3.7.13 --file rabbitmq-node.Dockerfile .\context }
function d { docker ps -a }
function prune { docker container prune --force }