CREATE
    TABLE IF NOT EXISTS
        ${catalog}.${database}.income_band(
            ib_income_band_sk INT,
            ib_lower_bound INT,
            ib_upper_bound INT
        )
            USING ${table_format} OPTIONS(
            PATH '${data_path}income_band/'
        ) TBLPROPERTIES(
            'primaryKey' = 'ib_income_band_sk' ${tblproperties_suffix}
        );
