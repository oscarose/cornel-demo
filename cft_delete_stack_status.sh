#!/bin/bash

set -x

if [[ $? -eq 0 ]];
   then
   echo "Openshift cluster stack deletion is in progress"
   delete_stack_status=$(aws --region $1 cloudformation wait stack-delete-complete --stack-name $2 --query 'Stacks[0].StackStatus' --output text)
   while [[ $delete_stack_status == "REVIEW_IN_PROGRESS" ]] || [[ $delete_stack_status == "$3" ]]
   do
   sleep 30
   delete_stack_status=$(aws --region $1 cloudformation wait stack-delete-complete --stack-name $2 --query 'Stacks[0].StackStatus' --output text)
   done
fi
