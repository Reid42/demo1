export OS_TOKEN="{{KEYSTONE_ADMIN_TOKEN}}" 
export OS_URL="{{KEYSTONE_AUTH_URL}}"
export OS_IDENTITY_API_VERSION="{{KEYSTONE_API_VERSION}}"

openstack project create --domain default --description "Admin Project" admin
openstack user create --domain default --password=admin admin
openstack role create admin
openstack role add --project admin --user admin admin

openstack project create --domain default --description "Demo Project" demo
openstack user create --domain default --password=demo demo
openstack role create user
openstack role add --project demo --user demo user
openstack project create --domain default --description "Service Project" service


#Keystone Service and Endpoint                                     
openstack service create --name keystone --description "OpenStack Identity" identity
openstack endpoint create --region RegionOne identity public "http://{{KEYSTONE_IP}}:5000/v2.0"
openstack endpoint create --region RegionOne identity internal "http://{{KEYSTONE_IP}}:5000/v2.0"
openstack endpoint create --region RegionOne identity admin "http://{{KEYSTONE_IP}}:35357/v2.0"

unset OS_TOKEN
unset OS_URL


/bin/cp /srv/salt/prod/openstack/keystone/files/admin-openrc.sh /usr/local/bin/
/bin/cp /srv/salt/prod/openstack/keystone/files/demo-openrc.sh /usr/local/bin/
echo "*/5 * * * * /usr/sbin/ntpdate ntp1.aliyun.com >/dev/null 2>&1" >>/var/spool/cron/root
source /usr/local/bin/admin-openrc.sh
openstack token issue
