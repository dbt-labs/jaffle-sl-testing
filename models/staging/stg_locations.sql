
with

source as (

    select * from {{ ref('raw_stores') }}

    -- {# data runs to 2026, truncate timespan to desired range, 
    -- current time as default #}
    -- where opened_at <= {{ var('truncate_timespan_to') }}

),

renamed as (

    select

        ----------  ids
        id as location_id,

        ---------- properties
        name as location_name,
        case
            when name in ('Brooklyn', 'Philadelphia') then 'Northeast'
            when name = 'Chicago' then 'Midwest'
            when name = 'New Orleans' then 'South'
            when name = 'San Francisco' then 'West'
        end as region,
        tax_rate,

        ---------- timestamp
        opened_at

    from source

)

select * from renamed
