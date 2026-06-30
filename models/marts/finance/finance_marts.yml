version: 2

groups:
  - name: finance_team
    owner:
      name: "Finance Analytics Lead"
      email: finance-analytics@company.com

models:
  - name: dim_customers
    config:
      group: finance_team
      access: protected
    columns:
      - name: customer_id
        tests: [unique, not_null]

  - name: dim_branches
    config:
      group: finance_team
      access: protected
    columns:
      - name: branch_id
        tests: [unique, not_null]

  - name: dim_loans
    config:
      group: finance_team
      access: protected
    columns:
      - name: loan_id
        tests: [unique, not_null]

  - name: fact_loan_payments
    config:
      group: finance_team
      access: public
    description: "Grain: one row per payment."
    semantic_model:
      enabled: true
      agg_time_dimension: paid_date
    columns:
      - name: payment_id
        tests: [unique, not_null]
        entity:
          type: primary
          name: payment_id

      - name: loan_id
        tests: [not_null]
        entity:
          type: foreign
          name: loan_id

      - name: customer_id
        entity:
          type: foreign
          name: customer_id

      - name: branch_id
        entity:
          type: foreign
          name: branch_id

      - name: loan_product
        dimension:
          type: categorical

      - name: paid_date
        granularity: day
        dimension:
          type: time

      - name: disbursed_amt
        measure:
          agg: sum
          name: disbursed_amount

      - name: amount_paid
        measure:
          agg: sum
          name: amount_paid

      - name: emi_amount
        measure:
          agg: sum
          name: emi_amount

      - name: is_npa
        tests:
          - accepted_values:
              arguments:
                values: [true, false]
        measure:
          agg: sum
          name: npa_count
          expr: "case when is_npa then 1 else 0 end"

      - name: days_past_due
        measure:
          agg: sum
          name: total_days_past_due

metrics:
  - name: total_disbursed
    label: "Total Disbursed Amount"
    type: simple
    type_params:
      measure: disbursed_amount

  - name: collection_efficiency
    label: "Collection Efficiency %"
    type: ratio
    type_params:
      numerator: amount_paid
      denominator: emi_amount

  - name: npa_ratio
    label: "NPA Ratio %"
    type: ratio
    type_params:
      numerator: npa_count
      denominator: payment_count

  - name: avg_days_past_due
    label: "Avg Days Past Due"
    type: derived
    type_params:
      expr: "total_days_past_due / nullif(payment_count, 0)"
      metrics:
        - total_days_past_due
        - payment_count