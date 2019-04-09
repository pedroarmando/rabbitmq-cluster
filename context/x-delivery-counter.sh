#!/bin/bash

rabbitmq-plugins enable x_delivery_counter

/opt/rabbitmq/rabbitmqadmin declare exchange --vhost=/ name=topic type=x-delivery-counter
/opt/rabbitmq/rabbitmqadmin declare queue --vhost=/ name=subscription durable=true 
/opt/rabbitmq/rabbitmqadmin declare binding --vhost=/ source=topic destination=subscription routing_key='#' 'arguments={"routingKey": "1 = 1"}'
