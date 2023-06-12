/*

The purpose of this model is to create an inventory_orders staging model.
Some initial cleaning can happen here & column renaming

 */



{{ config(
    materialized='view'
) }}


WITH source AS (

    SELECT * FROM {{ ref('inventory_orders') }}

),

orders AS (

    SELECT

       order_number::numeric as order_number,
       order_date::date as order_date,
       purchaser::string as purchaser,
       quantity::numeric as quantity,
       product_id::numeric as product_id

    FROM source

)

SELECT * FROM orders
