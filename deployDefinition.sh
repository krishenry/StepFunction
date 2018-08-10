#!/bin/sh

function deployFail {
    echo "Deploy to AWS Step Function failed"
	exit 1
}

trap deployFail ERR
StepFuncName="'Kris-Step2Function'"
CURDIR=`pwd`

StepARN=$(aws stepfunctions list-state-machines --region $REGION --query 'stateMachines[?name=='$StepFuncName'].{stateMachineArn:stateMachineArn}' | jq -r '.[].stateMachineArn')

if [ -z "$StepARN" ]; then  #-z checks if string is unset or empty (null and "")
	echo "$StepFuncName ARN not found"
	exit 1
fi

#lambda_ARN="arn:aws:lambda:us-east-1:015887481462:function"
#StepARN="arn:aws:states:us-east-1:015887481462:stateMachine:Kris-StepFunction"
#aws stepfunctions describe-state-machine --state-machine-arn $ARN --region $REGION #line works doesnt help much

filename='lambdanames.txt'
count=0

declare alias
declare	lambda_names
declare version
declare new_lambda_ARN

while IFS='' read -r line || [[ -n "$line" ]]; do
	variables=( $line )

	alias[${count}]="${variables[2]}"
	#echo "${alias[${count}]}"

	version[${count}]="${variables[1]}"
	#echo "${version[${count}]}"

	lambda_names[${count}]="${variables[0]}"
	#echo "${lambda_names[${count}]}"

	lambda_ARN[${count}]=$(aws lambda get-function --function-name "${variables[0]}" --region $REGION | jq -r '.Configuration' | jq -r '.FunctionArn')
	#echo "${new_lambda_ARN[${count}]}"

	count=$((count+1))
done < $filename

VAR=$(cat << EOF
{
    "StartAt": "${lambda_names[0]}",
    "States": {
        "${lambda_names[0]}": {
            "Type": "Task",
            "Resource": "${lambda_ARN[0]}:${lambda_names[0]}:${alias[0]}",
            "Next": "${lambda_names[1]}"
        },
        "${lambda_names[1]}": {
            "Type": "Task",
            "Resource": "${lambda_ARN[1]}:${lambda_names[1]}:${alias[1]}",
            "End": true
        }
    }
}
EOF
)

#VAR=`cat example.json`
#echo "$VAR"

REGION="us-east-1"

aws stepfunctions update-state-machine --state-machine-arn "$StepARN" --definition "$VAR" --region $REGION