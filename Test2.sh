VAR=$(cat << EOF
{
    "StartAt": "Merge ARNs",
    "States": {
        "Merge ARNs": {
            "Type": "Task",
            "Resource": "arn:aws:lambda:us-east-1:015887481462:function:LizzieTestDev:WORKS",
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