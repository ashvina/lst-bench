INSERT
    INTO
        ${catalog}.${database}.catalog_sales 
    SELECT /*+ REPARTITION(80, cs_sold_date_sk) */
        *
    FROM
        ${external_catalog}.${external_database}.catalog_sales;
