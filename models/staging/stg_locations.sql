
with

source as (

    select * from {{ ref('raw_stores') }}

),

renamed as (

    select

        ---------- ids
        id as location_id,

        ---------- properties
        name as location_name,
        case
            when name in ('Brooklyn', 'Philadelphia') then 'Northeast'
            when name = 'Chicago' then 'Midwest'
            when name = 'New Orleans' then 'South'
            when name = 'San Francisco' then 'West'
            else 'Unknown'
        end as region,
        tax_rate,

        ---------- timestamp
        opened_at

    from source

)

select * from renamed
