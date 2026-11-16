-- Eval for revenue-by-region answers: every known store has the governed Census region.
with expected as (
    select *
    from (
        values
            ('Brooklyn', 'Northeast'),
            ('Philadelphia', 'Northeast'),
            ('Chicago', 'Midwest'),
            ('New Orleans', 'South'),
            ('San Francisco', 'West')
    ) as mappings (location_name, region)
)

select
    locations.location_name,
    locations.region as actual_region,
    expected.region as expected_region
from {{ ref('stg_locations') }} as locations
left join expected using (location_name)
where locations.region is distinct from expected.region
