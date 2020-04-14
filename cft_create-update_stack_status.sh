#!/bin/bash
set -x

if [[ $? -eq 0 ]]; 
   then
   echo "OpenShift Cluster stack creation is in progress"
   create_stack_status=$(aws --region $1 cloudformation describe-stacks --stack-name $2 --query 'Stacks[0].StackStatus' --output text)
   while [[ $create_stack_status == "REVIEW_IN_PROGRESS" ]] || [[ $create_stack_status == "$3" ]]
   do
   sleep 30
   create_stack_status=$(aws --region $1 cloudformation describe-stacks --stack-name $2 --query 'Stacks[0].StackStatus' --output text) 
   done
fi
