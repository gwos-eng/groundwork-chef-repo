#! /usr/bin/env bash
sudo knife ec2 server create -I ami-3d4ff254 -f m1.small -x ubuntu --region 'us-east-1' -Z 'us-east-1a' -G quick-start-1 -N groundworkos -i ../.chef/demo.pem -S demo -r 'recipe[groundwork::before_install]'
sudo knife ssh name:groundworkos -x ubuntu -i ../.chef/demo.pem "sudo chef-client && sudo reboot"
sleep 180
knife node run_list remove groundworkos 'recipe[groundwork::before_install]'
knife node run_list add groundworkos 'recipe[groundwork]'
sudo knife ssh name:groundworkos -x ubuntu -i ../.chef/demo.pem "sudo chef-client"
