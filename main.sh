#! /bin/bash

VPC_NAME=$1
VPC_REGION=$2
CIDR=$3


function makevpc () {
    vpc_id=$(aws ec2 create-vpc --cidr-block $CIDR )
}