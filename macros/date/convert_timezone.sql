{% macro convert_timezone(column, target_tz=None, source_tz=None) %}
{{ deprecation_warning('convert_timezone', 'dbt_date.convert_timezone()') }}
{{ dbt_date.convert_timezone(column, target_tz, source_tz) }}
{% endmacro %}
