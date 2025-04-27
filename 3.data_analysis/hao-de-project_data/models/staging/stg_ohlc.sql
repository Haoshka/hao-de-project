with 

source as (

    select * from {{ source('staging', 'test_data') }}

),

renamed as (

    select
        TIMESTAMP(timestamp) AS ts,
        CAST(open AS FLOAT64) AS open,
        CAST(high AS FLOAT64) AS high,
        CAST(low AS FLOAT64) AS low,
        CAST(close AS FLOAT64) AS close,

    from source

)

select * from renamed
