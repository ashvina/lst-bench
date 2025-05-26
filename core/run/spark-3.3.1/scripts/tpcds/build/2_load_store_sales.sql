INSERT
    INTO
        ${catalog}.${database}.store_sales 
    SELECT /*+ REPARTITION(80, ss_sold_date_sk) */
        *
    FROM
        ${external_catalog}.${external_database}.store_sales;
