initscripts:
  pkg.installed: []

fontconfig:
  pkg.installed: []
  
grafana:
  pkgrepo.managed:
    - humanname: Grafana YUM repo
    - baseurl: https://packages.grafana.com/oss/rpm
    - gpgkey: https://packages.grafana.com/gpg.key
  pkg.installed:
    - name: grafana
  service.running:
    - name: grafana-server
    - require:
      - pkg: grafana
    - watch:
      - file: /etc/grafana/grafana.ini
      - file: /var/lib/grafana/dashboards/*

grafana_consul_config:
  file.managed:
    - name: /etc/opt/consul.d/grafana_consul.json
    - source: salt://grafana/config/grafana_consul.json
    - user: root
    - group: root
    - mode: 644 
    - makedirs: True 
  cmd.run:
    - name: systemctl restart consul
       
/etc/grafana/grafana.ini:
  file.managed:
    - source: salt://grafana/config/grafana.ini
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    
{{ pillar['grafana.dashboards'] }}:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644

{{ pillar['grafana.dashboards'] }}/:
  file.recurse:
    - source: salt://grafana/dashboards/
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644


 
