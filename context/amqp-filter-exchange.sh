#!/bin/bash

rabbitmq-plugins enable amqp_filter_exchange

/opt/rabbitmq/rabbitmqadmin declare exchange --vhost=/ name=topic_filter type=amqp-filter
/opt/rabbitmq/rabbitmqadmin declare queue --vhost=/ name=subscription_filter durable=true 
/opt/rabbitmq/rabbitmqadmin declare binding --vhost=/ source=topic_filter destination=subscription_filter routing_key='#' 'arguments={"routingKey": "1 = 1"}'

