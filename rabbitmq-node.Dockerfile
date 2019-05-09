FROM rabbitmq:3.7.13

# Prerequisites for .NET Core on Linux
# RUN apt-get update \
#  && apt-get install -y liblttng-ust0 libcurl4 libssl1.0.0 libkrb5-3 zlib1g libicu60 

RUN echo '[rabbitmq_management].' \
  > /etc/rabbitmq/enabled_plugins

ENV RABBITMQ_VERSION 3.7.13
ENV RABBITMQ_HOME=/opt/rabbitmq
ENV RABBITMQ_DATA_DIR=/var/lib/rabbitmq
ENV RABBITMQ_CONFIG_FILE=/etc/rabbitmq

# Add RabbitMQ to PATH, send all logs to TTY
ENV PATH=$RABBITMQ_HOME/sbin:$PATH RABBITMQ_LOGS=- RABBITMQ_SASL_LOGS=-

ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8
EXPOSE 4369 5671 5672 25672 

ADD init-rabbitmq-server.sh /var/lib/rabbitmq/init-rabbitmq-server.sh
# COPY pub/ /var/pub/
# COPY sub/ /var/sub/

CMD ["/var/lib/rabbitmq/init-rabbitmq-server.sh"]

## BUILD THIS IMAGE WITH
## docker build --tag moskitos.azurecr.io/rabbitmq-node:3.7.13 --file rabbitmq-node.Dockerfile .\context