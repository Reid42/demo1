neutron-init:
  file.managed:
    - name: /usr/local/bin/neutron_init.sh
    - source: salt://openstack/neutron/files/neutron_init.sh
    - mode: 755
    - user: root
    - group: root
    - template: jinja
    - defaults:
      NEUTRON_IP: {{ pillar['neutron']['NEUTRON_IP'] }}
  cmd.run:
    - name: bash /usr/local/bin/neutron_init.sh && touch /etc/neutron-datainit.lock
    - require:
      - file: /usr/local/bin/neutron_init.sh
    - unless: test -f /etc/neutron-datainit.lock
