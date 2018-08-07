#!/bin/sh

function deployFail {
    echo "Deploy to AWS Step Function failed"
	exit 1
}

trap deployFail ERR

CURDIR=`pwd`

ARN="arn:aws:states:us-east-1:015887481462:stateMachine:Kris-StepFunction"

#aws stepfunctions describe-state-machine --state-machine-arn $ARN

#ARN=aws stepfunctions describe-step-function --name Kris-StepFunction || jq .arn
#LizzieTestDev=aws lambda describe-lambda --name $from file || jq .arn

VAR=`cat example.json`

echo "$VAR"

REGION="us-east-1"

aws stepfunctions update-state-machine --state-machine-arn $ARN --definition "$VAR" --region $REGION


# VAR=`{
#     "StartAt": "LizzieTestDev12345",
#     "States": {
#         "LizzieTestDev12345": {
#             "Type": "Task",
#             "Resource": "arn:aws:lambda:us-east-1:015887481462:function:LizzieTestDev", 
#             "Next": "LizzieTest"
#         },
#         "LizzieTest": {
#             "Type": "Task",
#             "Resource": "arn:aws:lambda:us-east-1:015887481462:function:LizzieTest",
#             "End": true
#         }
#     }
# }`