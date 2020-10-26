{%- macro yesterday(tz=None) -%}
{{ deprecation_warning('yesterday', 'dbt_date.yesterday()') }}
{{ dbt_date.yesterday(tz) }}
{%- endmacro -%}
