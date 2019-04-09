#!/bin/sh

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

## START RABBITMQ SERVER

rabbitmq-plugins --offline enable rabbitmq_peer_discovery_etcd 

cat >/etc/rabbitmq.conf << EOF
cluster_formation.peer_discovery_backend = rabbit_peer_discovery_etcd
cluster_formation.etcd.host = etcd
cluster_formation.etcd.port = 2379
cluster_formation.etcd.scheme = http
EOF

rabbitmq-server $@