#!/bin/bash
source /usr/local/bin/admin-openrc.sh

#register
openstack service create --name neutron --description "OpenStack Networking" network
openstack endpoint create --region RegionOne network public http://{{NEUTRON_IP}}:9696
openstack endpoint create --region RegionOne network internal http://{{NEUTRON_IP}}:9696
openstack endpoint create --region RegionOne network admin http://{{NEUTRON_IP}}:9696

#create user
openstack user create --domain default --password=neutron neutron
openstack role add --project service --user neutron admin
