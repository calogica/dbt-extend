{%- macro n_days_ago(n, tz=None) -%}
{{ deprecation_warning('n_days_ago', 'dbt_date.n_days_ago()') }}
{{ dbt_date.n_days_ago(n, tz) }}
{%- endmacro -%}