#!/bin/bash
source  /usr/local/bin/admin-openrc.sh

##keystone
openstack user create --domain default --password=nova nova 
openstack role add --project service --user nova admin

##register
openstack service create --name nova --description "OpenStack Compute" compute
openstack endpoint create --region RegionOne compute public http://{{NOVA_IP}}:8774/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute internal http://{{NOVA_IP}}:8774/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute admin http://{{NOVA_IP}}:8774/v2/%\(tenant_id\)s

#check
openstack host list
