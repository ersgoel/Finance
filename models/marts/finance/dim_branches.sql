select
    branch_id,
    branch_name,
    region,
    manager_name
from {{ ref('stg_branches') }}