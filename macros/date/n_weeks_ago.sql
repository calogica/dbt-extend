{%- macro n_weeks_ago(n, tz=None) -%}
{{ deprecation_warning('n_weeks_ago', 'dbt_date.n_weeks_ago()') }}
{{ dbt_date.n_weeks_ago(n, tz) }}
{%- endmacro -%}