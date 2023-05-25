WITH nation AS (

  SELECT * 
  
  FROM {{ ref('nation')}}

),

customer AS (

  SELECT * 
  
  FROM {{ source('samples.tpch', 'customer') }}

),

join_on_nation_id AS (

  SELECT 
    nation.n_nationkey AS n_nationkey,
    nation.n_name AS n_name,
    nation.n_regionkey AS n_regionkey,
    nation.n_comment AS n_comment,
    customer.c_custkey AS c_custkey,
    customer.c_name AS c_name,
    customer.c_address AS c_address,
    customer.c_nationkey AS c_nationkey,
    customer.c_phone AS c_phone,
    customer.c_acctbal AS c_acctbal,
    customer.c_mktsegment AS c_mktsegment,
    customer.c_comment AS c_comment
  
  FROM nation
  INNER JOIN customer
     ON nation.n_nationkey = customer.c_nationkey

),

Aggregate_1 AS (

  SELECT 
    any_value(n_name) AS country,
    any_value(n_nationkey) AS country_code,
    count(c_custkey) AS total_customers
  
  FROM join_on_nation_id AS in0
  
  GROUP BY n_nationkey

)

SELECT *

FROM Aggregate_1
