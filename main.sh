#! /bin/bash

#VPC_NAME=$1
#VPC_REGION=$2
#CIDR=$3


function makevpc () {
    vpc_id=$(aws ec2 create-vpc --cidr-block $1 --region $2 --query "Vpc.VpcId" --output text)
    sleep 5
    echo $vpc_id
}

makevpc 10.0.0.0/16 us-east-2