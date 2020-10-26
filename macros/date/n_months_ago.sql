{%- macro n_months_ago(n, tz=None) -%}
{{ deprecation_warning('n_months_ago', 'dbt_date.n_months_ago()') }}
{{ dbt_date.n_months_ago(n, tz) }}
{%- endmacro -%}