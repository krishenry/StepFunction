#!/bin/sh

function deployFail {
    echo "Deploy to AWS Step Function failed"
	exit 1
}

trap deployFail ERR

CURDIR=`pwd`

ARN="arn:aws:states:us-east-1:015887481462:stateMachine:Kris-StepFunction"

#aws stepfunctions describe-state-machine --state-machine-arn $ARN
declare -a lines
count=0
filename='lambdanames.txt'
chmod +x deployAlias.sh
while IFS='' read -r line || [[ -n "$line" ]]; do
	lines[${count}]=line
	count=$((count+1))
done < $filename
#ARN=aws stepfunctions describe-step-function --name Kris-StepFunction || jq .arn
#LizzieTestDev=aws lambda describe-lambda --name $from file || jq .arn

#VAR=`cat example.json`
# VAR='{
#     "StartAt": "LizzieTestDev",
#     "States": {
#         "LizzieTestDev": {
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
# }'


VAR='{
    "StartAt": "$(($(lines)[0])[0])",
    "States": {
        "$(($(lines)[0])[0])": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:us-east-1:015887481462:function:LizzieTestDev", 
            "Next": "( ${lines}[1] )[0]"
        },
        "( ${lines}[1] )[0]": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:us-east-1:015887481462:function:LizzieTest",
            "End": true
        }
    }
}'


aws stepfunctions update-state-machine --state-machine-arn $ARN --definition "$VAR" --region $REGION
