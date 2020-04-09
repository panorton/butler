unzip:
  pkg.installed: []

agent:
  archive.extracted:
    - name: /opt/consul/agent
    - source: https://releases.hashicorp.com/consul/1.7.2/consul_1.7.2_linux_amd64.zip
    - source_hash: 5ab689cad175c08a226a5c41d16392bc7dd30ceaaf90788411542a756773e698
    - archive_format: zip
    - enforce_toplevel: False

/opt/consul/agent/consul:
  file.managed:
    - user: root
    - group: root
    - mode: 744
    - create: False

/usr/bin/consul:
  file.symlink:
    - target: /opt/consul/agent/consul
    - user: root
    - group: root
    - mode: 744
    - require:
      - file: /opt/consul/agent/consul

/var/consul:
  file.directory:
    - user: root
    - group: root
    - mode: 744
    - makedirs: True
    
/var/run/consul:
  file.directory:
    - user: root
    - group: root
    - mode: 744
    - makedirs: True

/etc/opt/consul.d:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

# /etc/opt/consul.d/:
#  file.recurse:
#    - source: salt://consul/config/host-level-checks
#    - user: root
#    - group: root
#    - dir_mode: 755
#    - file_mode: 644

/etc/opt/consul.d/consul-config.json:
  file.managed:
    - source: salt://consul/config/consul-config.json
    - user: root
    - group: root
    - mode: 644
    - template: jinja

/usr/lib/systemd/system/consul.service:
  file.managed:
    - source: salt://consul/config/consul.service
    - user: root
    - group: root
    - mode: 644
  
consul:
  service.running:
    - enable: True
    - watch:
      - file: /etc/opt/consul.d/*
