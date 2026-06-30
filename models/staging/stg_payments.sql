select
    payment_id,
    loan_id,
    due_date,
    paid_date,
    emi_amount,
    amount_paid,
    days_past_due,
    case when days_past_due > 90 then true else false end as is_npa
from {{ source('lending','raw_payments') }}