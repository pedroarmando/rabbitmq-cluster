#!/bin/sh

## CONFIGURE RABBITMQ

## rabbitmq-plugins --offline enable rabbitmq_peer_discovery_etcd 
## 
## cat >/etc/rabbitmq.conf << EOF
## cluster_formation.peer_discovery_backend = rabbit_peer_discovery_etcd
## cluster_formation.etcd.host = etcd
## cluster_formation.etcd.port = 2379
## cluster_formation.etcd.scheme = http
## EOF

## CREATE DEFAULT USERS

( sleep 10 ; \
    rabbitmqctl add_user admin admin 2>/dev/null ; \
    rabbitmqctl set_user_tags admin administrator ; \
    rabbitmqctl set_permissions -p / admin ".*" ".*" ".*" ; \
    \
    rabbitmqctl add_user pub pub 2>/dev/null ; \
    rabbitmqctl set_permissions -p / pub ".*" ".*" ."*" ; \
    rabbitmqctl add_user sub sub 2>/dev/null ; \
    rabbitmqctl set_permissions -p / sub ".*" ".*" ."*" ;
) &

( sleep 30 ; \
    wget http://127.0.0.1:15672/cli/rabbitmqadmin ; \
    mv --force rabbitmqadmin /opt/rabbitmq ; \
    chmod +x /opt/rabbitmq/rabbitmqadmin ;
) &
##    \
##    /opt/rabbitmq/rabbitmqadmin declare exchange --vhost=/ name=topic type=x-delivery-counter ; \
##    /opt/rabbitmq/rabbitmqadmin declare queue --vhost=/ name=subscription durable=true ; \
##    /opt/rabbitmq/rabbitmqadmin declare binding --vhost=/ source=topic destination=subscription routing_key='#' 'arguments={"routingKey": "1 = 1"}'; \
##    \
##    /opt/rabbitmq/rabbitmqadmin declare exchange --vhost=/ name=topic_amp_filter type=amqp-filter ; \
##    /opt/rabbitmq/rabbitmqadmin declare queue --vhost=/ name=subscription_amqp_filter durable=true ; \
##    /opt/rabbitmq/rabbitmqadmin declare binding --vhost=/ source=topic_amqp_filter destination=subscription_amqp_filter routing_key='#' 'arguments={"routingKey": "1 = 1"}';
##) &

## START RABBITMQ SERVER

rabbitmq-server $@