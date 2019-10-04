{{
    config(
        materialized = 'ephemeral'
    )
}}
select 
    {{ dbt_extend.get_local_time() }} as currently,
    {{ dbt_extend.today() }} as today,
    {{ dbt_extend.yesterday() }} as today,
    {{ dbt_extend.tomorrow() }} as tomorrow,
    {{ dbt_extend.convert_timezone('currently') }} as the_converted_time,
    {{ dbt_extend.convert_timezone('today') }} as the_converted_date