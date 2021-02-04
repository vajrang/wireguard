#!/bin/bash

# https://docs.aws.amazon.com/cli/latest/reference/ec2/run-instances.html
# AMI used is Ubuntu 20.10 arm64 to go with the arm64 (t4g) instance
# the security group opens Wireguard port (UDP 51820) & SSH
aws ec2 run-instances \
    --image-id ami-0c5bd9c7ee43d6907 \
    --instance-type t4g.micro \
    --security-group-ids sg-09d86bf4a1e23dcac \
    --key-name admin-key-pair \
    --user-data file://setup-instance.sh \
    --block-device-mappings 'DeviceName=/dev/sda1,Ebs={DeleteOnTermination=true,VolumeType=gp3}'
