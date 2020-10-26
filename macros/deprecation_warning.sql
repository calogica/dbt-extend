{% macro deprecation_warning(macro_name, new_macro_name=None) %}
{% set msg %}
The '{{ macro_name }}' macro is deprecated and will be removed in future version. 
{% if new_macro_name -%}
Please use '{{ new_macro_name }}' instead
{%- endif %}
{% endset %}
{{ log(msg, info=var('show_deprecation_warning')) }}
{% endmacro %}
