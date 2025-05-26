INSERT
    INTO
        ${catalog}.${database}.web_sales 
    SELECT /*+ REPARTITION(80, ws_sold_date_sk) */
        *
    FROM
        ${external_catalog}.${external_database}.web_sales;
