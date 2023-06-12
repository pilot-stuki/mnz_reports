{{ config(materialized='source') }}

{% set db_table = 'orders' %}

{% set source_name_cust %}
    {{ generate_database_name('inventory_orders') }}
{% endset %}

{% if execute %}
    {% set conn_info_kafka =  kafka_connection("kafka_connection","redpanda:9092") %}
{% endif %}

{% if execute %}
    {% set conn_info_csr =  csr_connection("csr_connection","http://redpanda:8081") %}
{% endif %}

CREATE SOURCE {{ source_name_cust }}
FROM KAFKA CONNECTION kafka_connection (TOPIC '{{ var('dbsrv') }}.{{ var('db') }}.{{ db_table }}') 
FORMAT AVRO USING CONFLUENT SCHEMA REGISTRY CONNECTION csr_connection
ENVELOPE DEBEZIUM
WITH (SIZE = '32');