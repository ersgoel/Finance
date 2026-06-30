select
    customer_id,
    customer_name,
    city,
    state,
    segment,
    created_at
from {{ source('lending','raw_customers') }}