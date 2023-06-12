{% macro csr_connection(name, url) %}

{% set conn_query %}
    CREATE CONNECTION IF NOT EXISTS {{ name }} TO CONFLUENT SCHEMA REGISTRY  (URL '{{ url }}' );
{% endset %}

{%- set conn_info = run_query(conn_query) -%}
{{ return(conn_info) }}

{% endmacro %}