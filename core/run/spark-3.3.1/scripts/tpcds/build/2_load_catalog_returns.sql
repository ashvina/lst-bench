INSERT
    INTO
        ${catalog}.${database}.catalog_returns 
    SELECT /*+ REPARTITION(80, cr_returned_date_sk) */
        *
    FROM
        ${external_catalog}.${external_database}.catalog_returns;
