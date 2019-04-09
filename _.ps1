function up { docker stack deploy --compose-file docker-compose.yml rabbitmq }
function down { docker stack rm rabbitmq }
function mk {
    docker rmi moskitos.azurecr.io/rabbitmq-node:3.7.13
    Remove-Item .\context\*ez
    Copy-Item E:\Projects\RabbitMQ\x-delivery-counter\plugins\*ez .\context
    Copy-Item E:\Projects\RabbitMQ\amqp-filter-exchange\plugins\*ez .\context
    docker build --tag moskitos.azurecr.io/rabbitmq-node:3.7.13 --file rabbitmq-node.Dockerfile .\context 
    Remove-Item .\context\*ez
}

function d { docker ps -a }
function prune { docker container prune --force }