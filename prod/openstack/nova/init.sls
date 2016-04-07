nova-init:
  file.managed:
    - name: /usr/local/bin/nova_init.sh
    - source: salt://openstack/nova/files/nova_init.sh
    - mode: 755
    - user: root
    - group: root
    - template: jinja
    - defaults:
      NOVA_IP: {{ pillar['nova']['NOVA_IP'] }}
  cmd.run:
    - name: bash /usr/local/bin/nova_init.sh && touch /etc/nova-datainit.lock
    - require:
      - file: nova-init
    - unless: test -f /etc/nova-datainit.lock
