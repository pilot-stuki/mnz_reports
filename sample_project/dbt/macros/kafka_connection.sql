{% macro kafka_connection(name, broker) %}

{% set conn_query %}
    CREATE CONNECTION IF NOT EXISTS {{ name }} TO KAFKA (BROKER '{{ broker }}' );
{% endset %}

{%- set conn_info = run_query(conn_query) -%}
{{ return(conn_info) }}

{% endmacro %}