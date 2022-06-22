#! /bin/bash

#VPC_NAME=$1
#VPC_REGION=$2
#CIDR=$3


function createVpc () {
    vpc_id=$(aws ec2 create-vpc --cidr-block $1 --region $2 --query "Vpc.VpcId" --output text)
    sleep 5
    echo $vpc_id
}

function createSubnet () {
    subnet_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block $1 --query "Subnet.SubnetId" --output text)
    
    echo $subnet_id

}



createVpc 10.0.0.0/16 us-east-2
createSubnet 10.0.0.0/24