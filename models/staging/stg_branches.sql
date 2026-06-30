select
    branch_id,
    branch_name,
    region,
    manager_name
from {{ source('lending','raw_branches') }}