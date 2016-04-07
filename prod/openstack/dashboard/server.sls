dashboard-install:
  pkg.installed:
    - names:
      - openstack-dashboard 

/etc/openstack-dashboard/local_settings:
  file.managed:
    - source: salt://openstack/dashboard/config/local_settings
    - user: apache
    - group: apache
    - template: jinja
    - defaults:
      DASHBOARD_HOST: {{ pillar['dashboard']['DASHBOARD_HOST'] }}
  cmd.run:
    - name: systemctl restart httpd
    - require:
      - pkg: dashboard-install
