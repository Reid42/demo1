#!/bin/bash
FLAT_IP=192.168.56.0/24
START_IP=192.168.56.100
END_IP=192.168.56.200
GATEWAY=192.168.56.2
NET_ID=$(neutron net-list | awk 'NR==4{print $2}') 
source /usr/local/bin/admin-openrc.sh
neutron net-create flat --shared --provider:physical_network physnet1 --provider:network_type flat
neutron subnet-create flat ${FLAT_IP} --name flat=subnet --allocation-pool start=${START_IP},end=${END_IP} --dns-nameserver ${GATEWAY} --gateway ${GATEWAY}

##NOTE:shutdown dhcp first
source /usr/local/bin/demo-openrc.sh
ssh-keygen -q -N ""
nova keypair-add --pub-key /root/.ssh/id_rsa.pub mykey 
nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0 
nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
nova boot --flavor m1.tiny --image cirros --nic net-id=${NET_ID} --security-group default --key-name mykey hello-instance
