# dbt-extend
Extension package for [dbt](https://github.com/fishtown-analytics/dbt), including schema tests and validation macros.

## Variables
The following variables need to be defined in your `dbt_project.yml` file:

`'dbt_extend:time_zone': 'America/Los_Angeles'`

You may specify [any valid timezone string](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) in place of `America/Los_Angeles`.
For example, use `America/New_York` for East Coast Time.

## Macros
### Data Type Conversion
#### empty_to_na ([source](macros/data_type/empty_to_na.sql))
Converts an empty value to "(N/A)" or other, if specified.

Usage:

```python
{{ dbt_extend.empty_to_na('my_column') }}
```
or
```python
{{ dbt_extend.empty_to_na('my_column', na_val='(Other NA Value)') }}
```

#### is_email ([source](macros/data_type/is_email.sql))
Returns a boolean indicating if a column value is a proper email address.

Usage:

```python
{{ dbt_extend.is_email('my_column') }}
```

#### slugify ([source](macros/data_type/slugify.sql))
Converts a column value to "slug" format, e.g. "This Product" to "this-product".

Usage:

```python
{{ dbt_extend.slugify('my_column') }}
```

#### strip_html ([source](macros/data_type/strip_html.sql))
Strips html tags from column value.

Usage:

```python
{{ dbt_extend.strip_html('my_column') }}
```

#### to_bool ([source](macros/data_type/to_bool.sql))
Converts column value to boolean based on valid true/false inputs.

Usage:

```python
{{ dbt_extend.to_bool('my_column') }}
```

or 

```python
{{ dbt_extend.to_bool(val='my_column', true_val=1, false_val=0) }}
```

```python
{{ dbt_extend.to_bool(val='my_column', true_val="'y'", false_val="'n'") }}
```

### Date
#### get_local_date ([source](macros/date/get_local_date.sql))
Gets date based on local timezone (specified). Package default is "America/Los_Angeles". The default must be specified in `dbt_project.yml`, in the `'dbt_extend:time_zone'` variable. e.g `'dbt_extend:time_zone': 'America/New_York'`.

Usage:

```python
{{ dbt_extend.get_local_date() }}
```

or, specify a timezone:
```python
{{ dbt_extend.get_local_date('America/New_York') }}
```


#### get_local_time ([source](macros/date/get_local_time.sql))
Gets time based on local timezone (specified). Default is "America/Los_Angeles".

Usage:

```python
{{ dbt_extend.get_local_time() }}
```

or, specify a timezone:

```python
{{ dbt_extend.get_local_time('America/New_York') }}
```

#### n_days_ago ([source](macros/date/n_days_ago.sql))
Gets date _n_ days ago, based on local date.

Usage:

```python
{{ dbt_extend.n_days_ago(7) }}
```

#### n_months_ago ([source](macros/date/n_months_ago.sql))
Gets date _n_ months ago, based on local date.

Usage:

```python
{{ dbt_extend.n_months_ago(12) }}
```

#### n_weeks_ago ([source](macros/date/n_weeks_ago.sql))
Gets date _n_ weeks ago, based on local date.

Usage:

```python
{{ dbt_extend.n_weeks_ago(4) }}
```

#### n_weeks_away ([source](macros/date/n_weeks_away.sql))
Gets date _n_ weeks from now, based on local date.

Usage:

```python
{{ dbt_extend.n_weeks_away(4) }}
```

#### this_week ([source](macros/date/this_week.sql))
Gets current week start date, based on local date.

Usage:

```python
{{ dbt_extend.this_week() }}
```

#### to_local_tz ([source](macros/date/to_local_tz.sql))
Converts timestamp to local timestamp.

Usage:

```python
{{ dbt_extend.to_local_tz('my_column') }}
```

or, specify a timezone:

```python
{{ dbt_extend.to_local_tz('my_column', 'America/New_York') }}
```


#### yesterday ([source](macros/date/yesterday.sql))
Gets yesterday's date, based on local date.

Usage:

```python
{{ dbt_extend.yesterday() }}
```

### Database Admin (Snowflake)
#### recluster ([source](macros/dbt/snowflake/recluster.sql))
Adds clustered key to Snowflake table and enlists table in automatic reclustering (requires Snowflake Enterprise Edition).

```python
{{
    config({
        'materialized': 'incremental',
        'unique_key': 'order_date',
        'post_hook': "{{ dbt_extend.recluster(this, 'order_date') }}"
    })
}}
```

### Schema Tests
#### equal_expression ([source](macros/schema_tests/equal_expression.sql))
This schema test asserts that two expressions are equal.

Parameters:

`expression` : expression using SQL compatible with database platform 

`compare_model` : if specified, a `ref` to another model; otherwise, the same model is assumed

`compare_expression` : if specified, an expression, using SQL compatible with database platform, to apply to the `model` or `comparison_model` (if specified) 

`filter_cond` : if specified, expression to be evaluated in a `where` clause

`compare_filter_cond` : if specified, expression to be evaluated in a `where` clause on the comparison model, defaults to `filter_cond` if not specified

`group_by` : list of columns from `model` to use as group by columns. If specified, evaluates `expression` at the granularity of the `group_by` columns.

`compare_group_by` : if specified, columns to group by the `comparison_model`; otherwise, same column names as specified in `group_by` are assumed.

`tol` : comparison tolerance, in absolute units of `expression`. E.g. `tol: 1000` specifies that only differences between `expression ` and `comparison_expression` greate than or equal to 1,000 are considered test failures. 

Usage:
```yaml
version: 2

models:
  - name: model_name
    tests:
      - dbt_utils.equal_expression:
          expression: count(*)
          compare_model: ref('same_or_other_model_name')
      - dbt_utils.equal_expression:
          expression: count(*)
          compare_model: ref('same_or_other_model_name')
          group_by: [date_col]
      - dbt_utils.equal_expression:
          expression: sum(col_a)
          compare_model: ref('same_or_other_model_name')
      - dbt_utils.equal_expression:
          expression: sum(col_a)
          compare_expression: sum(col_b)
          group_by: [date_col]
      - dbt_utils.equal_expression:
          expression: sum(col_a)
          compare_expression: sum(col_b)
          compare_model: ref('same_or_other_model_name')
          group_by: [date_col]
          tol: 100
      - dbt_utils.equal_expression:
          expression: sum(col_a)
          filter_cond: where date_col > dateadd('day', -7, current_date)
          compare_expression: sum(col_b)
          compare_model: ref('same_or_other_model_name')
          group_by: [date_col]
          tol: 100
```