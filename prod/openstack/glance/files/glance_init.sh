source /usr/local/bin/admin-openrc.sh

openstack user create --domain default --password=glance glance
openstack role add --project service --user glance admin 


openstack service create --name glance --description "OpenStack Image service" image
openstack endpoint create --region RegionOne image public http://192.168.56.11:9292
openstack endpoint create --region RegionOne image internal http://192.168.56.11:9292
openstack endpoint create --region RegionOne image admin http://192.168.56.11:9292

glance image-create --name "cirros" \
  --file /srv/salt/prod/openstack/glance/image/cirros-0.3.4-x86_64-disk.img \
  --disk-format qcow2 --container-format bare \
  --visibility public --progress

