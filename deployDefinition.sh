#!/bin/sh

function deployFail {
    echo "Deploy to AWS Step Function failed"
	exit 1
}

trap deployFail ERR

CURDIR=`pwd`
ARN="arn:aws:states:us-east-1:015887481462:stateMachine:Kris-StepFunction"
lambda_ARN="arn:aws:lambda:us-east-1:015887481462:function"
#aws stepfunctions describe-state-machine --state-machine-arn $ARN
#ARN=aws stepfunctions describe-step-function --name Kris-StepFunction || jq .arn

#LizzieTestDev=aws lambda describe-lambda --name $from file || jq .arn
aws lambda get-function --function-name LizzieTestDev --region $REGION

filename='lambdanames.txt'
count=0

declare alias
declare	lambda_names
declare version

while IFS='' read -r line || [[ -n "$line" ]]; do
	variables=( $line )

	alias[${count}]="${variables[2]}"
	#echo "${alias[${count}]}"

	version[${count}]="${variables[1]}"
	#echo "${version[${count}]}"

	lambda_names[${count}]="${variables[0]}"
	#echo "${lambda_names[${count}]}"

	#output=$(aws lambda get-function --function-name "${variables[0]}" --region $REGION ) #get lambda_ARN
	
	#echo $output
	# new_ARN='$(cat << EOF 
	# {
	# $output }
	# EOF 
	# )'

	#echo $output
	#echo ($output | jq -r '.Configuration' | jq -r '.FunctionArn')
	new_lambda_ARN=$(aws lambda get-function --function-name "${variables[0]}" --region $REGION | jq -r '.Configuration' | jq -r '.FunctionArn')
	#echo $new_lambda_ARN
	echo $new_lambda_ARN

	count=$((count+1))
done < $filename

#VAR=`cat example.json`
VAR=$(cat << EOF
{
    "StartAt": "${lambda_names[0]}",
    "States": {
        "${lambda_names[0]}": {
            "Type": "Task",
            "Resource": "$lambda_ARN:${lambda_names[0]}:${alias[0]}",
            "Next": "${lambda_names[1]}"
        },
        "${lambda_names[1]}": {
            "Type": "Task",
            "Resource": "$lambda_ARN:${lambda_names[1]}:${alias[1]}",
            "End": true
        }
    }
}
EOF
)



#echo "$VAR"

REGION="us-east-1"

aws stepfunctions update-state-machine --state-machine-arn $ARN --definition "$VAR" --region $REGION