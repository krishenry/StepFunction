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

#VAR=`cat example.json`

lambda_ARN="arn:aws:lambda:us-east-1:015887481462:function"
Alias="YUPPP"
VAR=$(cat << EOF
{
    "StartAt": "Merge ARNs",
    "States": {
        "Merge ARNs": {
            "Type": "Task",
            "Resource": "$lambda_ARN:LizzieTestDev:$Alias",
            "Next": "Upload Output"
        },
        "Upload Output": {
            "Type": "Task",
            "Resource": "$lambda_ARN:LizzieTest:$Alias",
            "End": true
        }
    }
}
EOF
)

echo "$VAR"

REGION="us-east-1"

aws stepfunctions update-state-machine --state-machine-arn $ARN --definition "$VAR" --region $REGION
