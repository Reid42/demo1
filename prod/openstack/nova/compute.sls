include:
  - openstack.nova.config-compute

libvirtd:
  pkg.installed:
    - names:
      - libvirt
  service.running:
    - name: libvirtd
    - enable: True

sysfsutils:
  pkg.installed:
    - name: sysfsutils

nova-compute-service:
  pkg.installed:
    - names:
      - openstack-nova-compute
  file.managed:
    - name: /usr/lib/systemd/system/openstack-nova-compute
    - user: root
    - group: root
    - mode: 755
  service.running:
    - name: openstack-nova-compute
    - enable: True
    - watch:
      - file: /etc/nova/nova.conf
      - pkg: nova-compute-service
    - require:
      - service: libvirtd
