select
    loan_id,
    customer_id,
    branch_id,
    loan_product,
    sanctioned_amt,
    disbursed_amt,
    disbursed_date,
    tenure_months,
    interest_rate,
    loan_status
from {{ source('lending','raw_loans') }}