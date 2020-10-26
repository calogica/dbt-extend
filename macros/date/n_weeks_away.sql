{%- macro n_weeks_away(n, tz=None) -%}
{{ deprecation_warning('n_weeks_away', 'dbt_date.n_weeks_away()') }}
{{ dbt_date.n_weeks_away(n, tz) }}
{%- endmacro -%}