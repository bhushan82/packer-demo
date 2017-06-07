#!/bin/bash

cd ../terraform/jenkins-packer-demo
arr=$(terraform show | grep 'vpc_id\|subnet_id\|aws_instance.jenkins-instance')
declare -i counter
counter=0
# echo 'answer='
# echo $counter
for i in $arr
do
 #echo $i
 if (($counter>0)); then
   counter=$((counter+1))
 fi
 if [ $i == "aws_instance.jenkins-instance:" ]; then
   #echo $i
   counter=$((counter+1))
 fi
 if (($counter==4)); then
   #echo 'subnet found'
   export SUBNET_ID=$i
 fi
 if (($counter==7)); then
   #echo 'vpc found'
   export VPC_ID=$i
 fi
done

echo $SUBNET_ID
echo $VPC_ID

pwd
cd ../../packer-demo/
packer build -debug=true -machine-readable packer-demo.json 
