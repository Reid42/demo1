include:
  - openstack.neutron.config

neutron-linuxbridge-agent:
  pkg.installed:
    - names:
      - openstack-neutron
      - openstack-neutron-linuxbridge
      - python-neutronclient
      - openstack-neutron-ml2
  file.managed:
    - name: /usr/lib/systemd/system/neutron-linuxbridge-agent 
    - mode: 755
    - user: root
    - group: root
  service.running:
    - name: neutron-linuxbridge-agent
    - enable: True
    - watch:
      - file: /etc/neutron
      - file: neutron-linuxbridge-agent
    - require:
      - pkg: neutron-linuxbridge-agent
