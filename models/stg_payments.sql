SELECT 
    ID AS Payment_ID,
    OrderID AS order_id,
    PaymentMethod,
    (Amount/100) AS Amount,
    Status,
    Created AS Created_At,
    _Batched_At
FROM {{ source('stripe', 'payment') }}