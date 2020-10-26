{%- macro periods_since(date_col, period_name='day', tz=None) -%}
{{ deprecation_warning('periods_since', 'dbt_date.periods_since()') }}
{{ dbt_date.periods_since(date_col, period_name, tz) }}
{%- endmacro -%}