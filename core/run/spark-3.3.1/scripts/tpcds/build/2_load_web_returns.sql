INSERT
    INTO
        ${catalog}.${database}.web_returns 
    SELECT /*+ REPARTITION(80, wr_returned_date_sk) */
        *
    FROM
        ${external_catalog}.${external_database}.web_returns;
