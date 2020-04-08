patch_app_module:
  file.managed:
    - source: salt://airflow/config/app.py
    - name: /usr/local/lib/python3.6/site-packages/airflow/www/app.py
    - user: root
    - group: root
    - mode: 644