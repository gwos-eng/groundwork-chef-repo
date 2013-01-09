#! /usr/bin/env bash
nodename=groundwork_$(date +"%d_%m_%Y-%H.%M.%S")
sudo knife ec2 server create -I ami-3d4ff254 -f m1.small -x ubuntu --region 'us-east-1' -Z 'us-east-1a' -G quick-start-1 -N $nodename -i ../.chef/demo.pem -S demo -r 'recipe[groundwork::before_install]'
sudo knife ssh name:$nodename -x ubuntu -i ../.chef/demo.pem "sudo chef-client && sudo reboot"
sleep 220
knife node run_list remove $nodename 'recipe[groundwork::before_install]'
knife node run_list add $nodename 'recipe[groundwork]'
sudo knife ssh name:$nodename -x ubuntu -i ../.chef/demo.pem "sudo chef-client"
