#!/bin/sh
ARN="arn:aws:states:us-east-1:015887481462"
Step_Function_Name="Kris-StepFunction"

State_Machine_ARN="$ARN:$Step_Function_Name"
echo $State_Machine_ARN

lambda_ARN="arn:aws:lambda:us-east-1:015887481462"

VAR=$(cat << EOF
{
    "StartAt": "Merge ARNs",
    "States": {
        "Merge ARNs": {
            "Type": "Task",
            "Resource": ""'"$lambda_ARN"'":function:LizzieTestDev:WORKS",
            "Next": "Upload Output"
        },
        "Upload Output": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:us-east-1:015887481462:function:LizzieTest:WORKS",
            "End": true
        }
    }
}
EOF
)

echo "$VAR"