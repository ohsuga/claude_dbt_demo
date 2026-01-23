-- このテストは、平均注文金額が総購入金額より大きくなっている
-- データ不整合レコードを検出します
--
-- 期待動作：
-- - avg_order_value <= total_revenue が正常
-- - avg_order_value > total_revenue は異常（このクエリで検出される）
--
-- ビジネスロジック：
-- - 平均注文金額は総購入金額を注文件数で割った値なので、
--   必ず総購入金額以下になるはず
-- - 注文件数が1件の場合、avg_order_value = total_revenue となる
--
-- このテストは、以下の場合に失敗します：
-- - 検出されたレコード数 > 0（データ不整合が存在）

select
    customer_key,
    customer_name,
    total_orders,
    total_revenue,
    avg_order_value,
    (avg_order_value - total_revenue) as difference

from {{ ref('fct_customer_orders') }}

where avg_order_value > total_revenue
