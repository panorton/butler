install_wheel:
  pip.installed: 
    - name: wheel
    - upgrade: True

install_cwltool:
  pip.installed: 
    - name: cwlref-runner
    - upgrade: True
    
install_schema_salad:
  pip.installed:
    - name: schema-salad
    - upgrade: True