INSERT
    INTO
        ${catalog}.${database}.inventory 
    SELECT /*+ REPARTITION(80, inv_date_sk) */
        *
    FROM
        ${external_catalog}.${external_database}.inventory;
