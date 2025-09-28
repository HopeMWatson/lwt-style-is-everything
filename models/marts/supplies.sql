-- change compilation another way
{{
  config(
    materialized = "table",
    tags = ["core"]
  )
}}
with

supplies as (

    select * from {{ ref('stg_supplies') }}

)

select * from supplies
