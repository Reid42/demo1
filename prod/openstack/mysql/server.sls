include:
  - openstack.mysql.init

mariadb-server:
  pkg.installed:
    - name: mariadb-server

  file.managed:
    - name: /etc/my.cnf
    - source: salt://openstack/mysql/files/my.cnf

  service.running:
    - name: mariadb
    - enable: True
    - require:
      - pkg: mariadb-server
    - watch:
      - file: mariadb-server
