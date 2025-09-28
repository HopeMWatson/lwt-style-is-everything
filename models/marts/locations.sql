with

locations as (

    select 
        location_id,
        location_name,
        tax_rate
    from {{ ref('stg_locations') }}

)

select * from locations
