-- このテストは、注文件数が0なのに総購入金額が0でない
-- データ不整合レコードを検出します
--
-- 期待動作：
-- - total_orders = 0 の場合、total_revenue = 0 が正常
-- - total_orders = 0 かつ total_revenue != 0 は異常（このクエリで検出される）
--
-- ビジネスロジック：
-- - 注文が1件もない顧客は、購入金額も0であるべき
-- - 注文件数と購入金額の整合性を確保
--
-- 注意：
-- - fct_customer_orders モデルの定義上、全ての顧客は少なくとも1件の注文を持つため
--   このテストで異常が検出されることは通常ありません
-- - ただし、データパイプラインの異常や集計ロジックのバグを検出するために重要です
--
-- このテストは、以下の場合に失敗します：
-- - 検出されたレコード数 > 0（データ不整合が存在）

select
    customer_key,
    customer_name,
    total_orders,
    total_revenue,
    avg_order_value

from {{ ref('fct_customer_orders') }}

where total_orders = 0
  and total_revenue != 0
