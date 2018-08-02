#!/bin/sh

function deployFail {
    echo "Deploy to AWS Step Function failed"
	exit 1
}

trap deployFail ERR

CURDIR=`pwd`

ARN="arn:aws:states:us-east-1:015887481462:stateMachine:Kris-StepFunction"
#echo $ARN
VAR="/StepFunction/deploy.sh" 
#echo $VAR
ROLE="arn:aws:iam::015887481462:role/AcunaStepFunctionRole"
#echo $ROLE

#local directory /c/Users/uc245836/Desktop/AWS/StepFunction/deploy.sh

aws stepfunctions update-state-machine --state-machine-arn $ARN --definition $VAR --role-arn $ROLE
