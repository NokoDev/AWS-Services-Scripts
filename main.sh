#! /bin/bash

#VPC_NAME=$1
#VPC_REGION=$2
#CIDR=$3

set -e


function createVpc () {
    vpc_id=$(aws ec2 create-vpc --cidr-block $1 --region $2 --query "Vpc.VpcId" --output text)
    
    echo "VPC create with success: " $vpc_id
}

function createSubnet () {
    subnet_id=$(aws ec2 create-subnet --vpc-id $vpc_id --cidr-block $1 --availability-zone $2 --query "Subnet.SubnetId" --output text)
    
    echo "Subnet create with success: " $subnet_id

}

function createInternetGateway () {

    internetGateway_id=$(aws ec2 create-internet-gateway --query "InternetGateway.InternetGatewayId" --output text)

    if [ $internetGateway_id != "" ] 
    then 
    #Command returns nothing
    
    $(aws ec2 attach-internet-gateway --internet-gateway-id $internetGateway_id --vpc-id $vpc_id)

    #Planning how to extract the created association
    associated_vpc_id=$(aws ec2 describe-internet-gateways --internet-gateway-id $internetGateway_id --query "InternetGateways[].Attachments[].VpcId" --output text)
    fi
    echo "Internet Gateway create with success: " $internetGateway_id "And its a assiciated with: " $associated_vpc_id
}



echo "###############################################"
createVpc 10.0.0.0/16 us-east-2
echo "###############################################"
sleep 3
createSubnet 10.0.0.0/24 us-east-2a
echo "###############################################"
sleep 3
createInternetGateway
echo "###############################################"
 