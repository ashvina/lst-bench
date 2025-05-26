INSERT
    INTO
        ${catalog}.${database}.store_returns 
    SELECT /*+ REPARTITION(80, sr_returned_date_sk) */
        *
    FROM
        ${external_catalog}.${external_database}.store_returns;
