pkg-base:
  pkg.installed:
    - names:
      - lrzsz
      - MySQL-python
      - python-openstackclient
      - ntpdate

ntp-service:
  file.managed:
    - name: /etc/chrony.conf
    - source: salt://openstack/init/files/chrony.conf
    - user: root
    - group: root
    - mode: 644
  pkg.installed:
    - name: chrony
  service.running:
    - name: chronyd
    - enable: True
    - reload: True
  cmd.run:
    - name: timedatectl set-timezone Asia/Shanghai && chronyc sources

yum_repo_release:
  pkg.installed:
    - sources:
      - epel-release-7-5.noarch.rpm: http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm 
    - unless: rpm -qa | epel-release-7-5.noarch.rpm

epel_repo:
  file.managed:
    - name: /etc/yum.repos.d/epel.repo
    - source: salt://openstack/init/files/epel.repo
    - user: root
    - group: root
    - mode: 644

openstack_repo:
  file.managed:
    - name: /etc/yum.repos.d/CentOS-OpenStack-liberty.repo
    - source: salt://openstack/init/files/CentOS-OpenStack-liberty.repo
    - user: root
    - group: root
    - mode: 644

centos_repo:
  file.managed:
    - name: /etc/yum.repos.d/CentOS-Base.repo
    - source: salt://openstack/init/files/CentOS-Base.repo
    - user: root
    - group: root
    - mode: 644

rdo_repo:
  file.managed:
    - name: /etc/yum.repos.d/rdo-release.repo
    - source: salt://openstack/init/files/rdo-release.repo
    - user: root
    - group: root
    - mode: 644
