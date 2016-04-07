neutron-metadata-agent:
  file.managed:
    - name: /usr/lib/systemd/system/neutron-metadata-agent 
    - mode: 755
    - user: root
    - group: root
  service.running:
    - name: neutron-metadata-agent 
    - enable: True
    - watch:
      - file: /etc/neutron
      - file: neutron-metadata-agent
