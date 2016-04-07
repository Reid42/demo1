include:
  - openstack.neutron.config
  - openstack.neutron.linuxbridge_agent
  - openstack.neutron.metadata_agent
  - openstack.neutron.dhcp_agent
  - openstack.neutron.init

neutron-db-sync:
  cmd.run:
    - name: su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron &&  ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini  && touch /etc/neutron-dbsync.lock
    - require:
      - pkg: neutron-server
    - unless: test -f /etc/neutron-dbsync.lock

neutron-server:
  pkg.installed:
    - names:
      - openstack-neutron
      - openstack-neutron-linuxbridge
      - ebtables
      - ipset
  file.managed:
    - name: /usr/lib/systemd/system/neutron-server 
    - mode: 755
    - user: root
    - group: root
  service.running:
    - name: neutron-server
    - enable: True
    - watch:
      - file: /etc/neutron
    - require:
      - cmd: neutron-init
      - pkg: neutron-server
