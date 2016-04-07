nova:
  MYSQL_SERVER: 192.168.56.11
  NOVA_IP: 192.168.56.11
  NOVA_DB_NAME: nova
  NOVA_DB_USER: nova
  NOVA_DB_PASS: nova
  DB_ALLOW: nova.*
  HOST_ALLOW: 192.168.56.%
  RABBITMQ_HOST: 192.168.56.11
  RABBITMQ_PORT: 5672
  RABBITMQ_USER: openstack
  RABBITMQ_PASS: openstack
  AUTH_KEYSTONE_HOST: 192.168.56.11
  AUTH_KEYSTONE_PORT: 35357
  AUTH_KEYSTONE_PROTOCOL: http
  AUTH_NOVA_ADMIN_TENANT: service
  AUTH_NOVA_ADMIN_USER: nova
  AUTH_NOVA_ADMIN_PASS: nova
  GLANCE_HOST: 192.168.56.11
  AUTH_KEYSTONE_URI: http://192.168.56.11:5000
  NEUTRON_URL: http://192.168.56.11:9696
  NEUTRON_ADMIN_USER: neutron
  NEUTRON_ADMIN_PASS: neutron
  NEUTRON_ADMIN_TENANT: service
  NEUTRON_ADMIN_AUTH_URL: http://192.168.56.22:5000/v2.0
  NOVNCPROXY_BASE_URL: http://192.168.56.11:6080/vnc_auto.html
  AUTH_URI: http://192.168.56.11:5000
  AUTH_URL: http://192.168.56.11:35357
