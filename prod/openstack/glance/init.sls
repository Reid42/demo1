glance-init:
  file.managed:
    - name: /usr/local/bin/glance_init.sh
    - source: salt://openstack/glance/files/glance_init.sh
    - mode: 755
    - user: root
    - group: root
    - template: jinja
    - defaults:
      MYSQL_SERVER: {{ pillar['glance']['MYSQL_SERVER'] }}
      GLANCE_DB_USER: {{ pillar['glance']['GLANCE_DB_USER'] }}
      GLANCE_DB_NAME: {{ pillar['glance']['GLANCE_DB_NAME'] }}
      GLANCE_DB_PASS: {{ pillar['glance']['GLANCE_DB_PASS'] }}
      GLANCE_IP: {{ pillar['glance']['GLANCE_IP'] }}
      AUTH_GLANCE_ADMIN_USER: {{ pillar['glance']['AUTH_GLANCE_ADMIN_USER'] }}
      AUTH_GLANCE_ADMIN_PASS: {{ pillar['glance']['AUTH_GLANCE_ADMIN_PASS'] }}
  cmd.run:
    - name: sleep 10 && bash /usr/local/bin/glance_init.sh && touch /etc/glance-init.lock
    - require:
      - file: glance-init
      - service: openstack-glance-api
      - service: openstack-glance-registry
    - unless: test -f /etc/glance-init.lock
