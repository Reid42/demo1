include:
  - openstack.neutron.config-compute

neutron-link:
  cmd.run:
    - name: ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini  && touch /etc/neutron-link.lock
    - require:
      - pkg: neutron-agent
    - unless: test -f /etc/neutron-link.lock


neutron-agent:
  pkg.installed:
    - names:
      - openstack-neutron
      - openstack-neutron-linuxbridge
      - ebtables
      - ipset
  file.managed:
    - name: /usr/lib/systemd/system/neutron-linuxbridge-agent 
    - mode: 755
    - user: root
    - group: root
  service.running:
    - name: neutron-linuxbridge-agent
    - enable: True
    - watch:
      - file: /etc/neutron/neutron.conf
    - require:
      - pkg: neutron-agent
