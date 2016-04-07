include:
  - openstack.glance.init
glance-install:
  pkg.installed:
    - names:
      - openstack-glance 
      - python-glanceclient
      - python-glance

/etc/glance:
  file.recurse:
    - source: salt://openstack/glance/files/config
    - user: glance
    - group: glance
    - template: jinja
    - defaults:
      MYSQL_SERVER: {{ pillar['keystone']['MYSQL_SERVER'] }}
      GLANCE_DB_PASS: {{ pillar['glance']['GLANCE_DB_PASS'] }}
      GLANCE_DB_USER: {{ pillar['glance']['GLANCE_DB_USER'] }}
      GLANCE_DB_NAME: {{ pillar['glance']['GLANCE_DB_NAME'] }}
      GLANCE_IP: {{ pillar['glance']['GLANCE_IP'] }}
      AUTH_GLANCE_ADMIN_USER: {{ pillar['glance']['AUTH_GLANCE_ADMIN_USER'] }}
      AUTH_GLANCE_ADMIN_PASS: {{ pillar['glance']['AUTH_GLANCE_ADMIN_PASS'] }}

glance-db-sync:
  cmd.run:
    - name: touch /etc/glance-datasync.lock && su -s /bin/sh -c "glance-manage db_sync" glance 
    - require:
      - pkg: glance-install
    - unless: test -f /etc/glance-datasync.lock

openstack-glance-api:
  file.managed:
    - name: /usr/lib/systemd/system/openstack-glance-api
    - mode: 755
    - user: root
    - group: root
  service:
    - running
    - enable: True
    - watch: 
      - file: /etc/glance
    - require:
      - pkg: glance-install
      - cmd: glance-db-sync

openstack-glance-registry:
  file.managed:
    - name: /usr/lib/systemd/system/openstack-glance-registry
    - mode: 755
    - user: root
    - group: root
  service:
    - running
    - enable: True
    - watch:
      - file: /etc/glance
    - require:
      - pkg: glance-install
      - cmd: glance-db-sync
