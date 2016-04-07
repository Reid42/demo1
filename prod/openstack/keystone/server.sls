include:
  - openstack.keystone.init

keystone-install:
  pkg.installed:
    - names:
      - openstack-keystone
      - httpd
      - mod_wsgi
      - memcached
      - python-memcached

memcache:
  service.running:
    - name: httpd
    - enable: True
    - reload: True
    - require:
      - pkg: keystone-install

apache:
  file.managed:
    - name: /etc/httpd/conf.d/wsgi-keystone.conf
    - source: salt://openstack/keystone/files/wsgi-keystone.conf
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: httpd
    - enable: True
    - reload: True
    - require:
      - pkg: keystone-install
      - file: apache-a

apache-a:
   file.managed:
    - name: /etc/httpd/conf/httpd.conf
    - source: salt://openstack/keystone/files/httpd.conf
    - user: root
    - group: root
    - mode: 644

/etc/keystone:
  file.recurse:
    - source: salt://openstack/keystone/files/config
    - user: keystone
    - group: keystone

keystone-db-sync:
  cmd.run:
    - name: su -s /bin/sh -c "keystone-manage db_sync" keystone && touch /etc/keystone-data 
    - require:
      - pkg: keystone-install
    - unless: test -f /etc/keystone-data

