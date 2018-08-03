#!/bin/sh

function deployFail {
    echo "Deploy to AWS Step Function failed"
	exit 1
}

trap deployFail ERR

CURDIR=`pwd`

ARN="arn:aws:states:us-east-1:015887481462:stateMachine:Kris-StepFunction"
#echo $ARN
VAR=`cat example.json`
echo $VAR
REGION="us-east-1"
#local directory /c/Users/uc245836/Desktop/AWS/StepFunction/deploy.sh
DEFINITION=\'{
  "Comment": "A Hello World example of the Amazon States Language using a Pass state",
  "StartAt": "HelloWorld",
  "States": {
    "HelloWorld": {
      "Type": "Pass",
      "Result": "Hello World has been updated!",
      "End": true
    }
  }
}\'
echo "###############"
echo $DEFINITION
aws stepfunctions update-state-machine --state-machine-arn $ARN --definition "$DEFINITION" --region $REGION
