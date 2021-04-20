{{config

    (
        materialized = 'table'
    )

}}


with Orders as (

    select * from {{ ref('stg_orders') }}

),

Payments as (

    select * from {{ ref('stg_payments') }}

),

Order_Payments AS(

    SELECT 
        SUM(Amount) AS Amount,
        order_id
    FROM Payments
    WHERE
        Status <> 'FAIL'
    Group BY
        order_id

), 

Final AS(

    SELECT 
        O.customer_id,
        O.order_id,
        O.status,
        OP.Amount,
        O.order_date
    FROM 
        Orders O
        LEFT JOIN Order_Payments OP 
            ON O.order_id = OP.order_id

)

SELECT * FROM Final
