-- このテストは、最初の注文日が最後の注文日より後になっている
-- データ不整合レコードを検出します
--
-- 期待動作：
-- - first_order_date <= last_order_date が正常
-- - first_order_date > last_order_date は異常（このクエリで検出される）
--
-- このテストは、以下の場合に失敗します：
-- - 検出されたレコード数 > 0（データ不整合が存在）

select
    customer_key,
    customer_name,
    first_order_date,
    last_order_date,
    customer_lifetime_days

from {{ ref('fct_customer_orders') }}

where first_order_date > last_order_date
