{%- macro this_week(tz=None) -%}
{{ deprecation_warning('this_week', 'dbt_date.this_week()') }}
{{ dbt_date.this_week(tz) }}
{%- endmacro -%}