with payments as (
    select * from {{ ref('stg_payments') }}
),
loans as (
    select * from {{ ref('stg_loans') }}
)
select
    p.payment_id,
    l.loan_id,
    l.customer_id,
    l.branch_id,
    l.loan_product,
    l.disbursed_amt,
    l.disbursed_date,
    p.due_date,
    p.paid_date,
    p.emi_amount,
    p.amount_paid,
    p.days_past_due,
    p.is_npa
from payments p
join loans l on p.loan_id = l.loan_id