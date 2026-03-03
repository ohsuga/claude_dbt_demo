{% macro log_deployment_info(status) %}
  {% set sql %}
    INSERT INTO {{ target.database }}.{{ target.schema }}.DEPLOYMENT_HISTORY
    (git_sha, git_branch, deployed_by, dbt_version, status)
    VALUES (
      '{{ env_var("GITHUB_SHA", "unknown") }}',
      '{{ env_var("GITHUB_REF_NAME", "unknown") }}',
      '{{ env_var("GITHUB_ACTOR", "unknown") }}',
      '{{ dbt_version }}',
      '{{ status }}'
    )
  {% endset %}
  {% do run_query(sql) %}
  {% do log("Deployment logged with status: " ~ status, info=True) %}
{% endmacro %}
