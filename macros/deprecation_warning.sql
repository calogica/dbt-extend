{% macro deprecation_warning(macro_name, new_macro_name) %}
{% set msg %}
The '{{ macro_name }}' macro is deprecated and will be removed in future version. 
Please use '{{ new_macro_name }}' instead
{% endset %}
{{ log(msg, info=var('show_deprecation_warning')) }}
{% endmacro %}
