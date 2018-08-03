#!/bin/sh

function deployFail {
    echo "Deploy to AWS Step Function failed"
	exit 1
}

trap deployFail ERR

CURDIR=`pwd`

ARN="arn:aws:states:us-east-1:015887481462:stateMachine:Kris-StepFunction"

#ARN=aws stepfunctions describe-step-function --name Kris-StepFunction || jq .arn
#LizzieTestDev=aws lambda describe-lambda --name $from file || jq .arn

VAR=`cat example.json`

#echo $VAR
#local directory /c/Users/uc245836/Desktop/AWS/StepFunction/deploy.sh
aws stepfunctions update-state-machine --state-machine-arn $ARN --definition "$VAR" --region $REGION
