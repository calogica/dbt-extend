{%- macro to_local_tz(column, target_tz=None, source_tz=None) -%}
{{ deprecation_warning('to_local_tz', 'dbt_date.convert_timezone()') }}
{{ dbt_date.convert_timezone(column, target_tz, source_tz) }}
{%- endmacro -%}