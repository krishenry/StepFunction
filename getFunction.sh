#!/bin/sh
VAR=$(cat << EOF
{
   "Code": {
        "RepositoryType": "S3", 
        "Location": "https://prod-04-2014-tasks.s3.amazonaws.com/snapshots/015887481462/LizzieTestDev-497112c4-b13f-4e17-a8ed-ab76ed1393fe?versionId=yXIHWY9R9R0GJH8IbgmvGgrzd8KAY9GM&X-Amz-Security-Token=FQoGZXIvYXdzEMj%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaDINSfMHSTe26xhdgUCK3A%2FSJqNBfDQBBRnrKjna8RLr2UAOiOsciVGP6c1bdVpPp%2BJJad3e7NqBMBGdBR22k1fv2TC0u1A1%2F3seb%2BQkkRG6La1OC4EbnWCocvdCQ1QboOVJl%2B0tmpAovfwHC0NClGV0xcDtWTi8XZP2C5LhGn4QGZVIT4F%2BzLSpYmmBkEUbUWIIhfJRAwFWafUZElDVFicT39xUlocWEedJJNCjLGudnC8JRSLhzlCWu6NOFPkTB9Vj%2FehooI%2FzQSEv0Po1PDXXUhs06HujL5Kkh1eUpNhyeDGqfnmiJJ01VEKFG9ltDlhjcVNo0ePFGOsuaQNf5ngAc6Bnd711IEhYVD03PQN03Vk1DP77DVBMni7mwr%2FPJaKnCemD35w%2BPmWwQS7PFlkf2Dpo54mkda3xcuscU5KdhyiWfO2GP%2FSdOSNpiRywtZK8esdXd7NOLQOtz%2FYW14uLtPzrd7pFG3ZDVWAARZD6zUaaGrxt%2FCfJiOdBfIVMJHJnTsTSJPIP0JTauyuNnHquAflSoeEUG2KxDzOWjgYObRo9tNjETKB%2FKII4IcUIz3W%2BDsEi%2BA8%2B%2FaoPX%2BwUZ656Aa7OKBYAojfWr2wU%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20180808T145321Z&X-Amz-SignedHeaders=host&X-Amz-Expires=600&X-Amz-Credential=ASIA25DCYHY3ZLC53R6U%2F20180808%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=f7df9cb6dc847f1745f7a091debe52af117471eb9dd9d81ce539e6d4ace2a3a2"
    }, 
    "Configuration": {
        "TracingConfig": {
            "Mode": "PassThrough"
        }, 
        "Version": "$LATEST", 
        "CodeSha256": "Yx8eM5KV9cdDsnOiXwFVazFiMbsFVlhOamLSQZ8kFfk=", 
        "FunctionName": "LizzieTestDev", 
        "MemorySize": 512, 
        "CodeSize": 1443502, 
        "FunctionArn": "arn:aws:lambda:us-east-1:015887481462:function:LizzieTestDev", 
        "Handler": "example.Hello::myHandler", 
        "Role": "arn:aws:iam::015887481462:role/ToucanAppendArnListRole", 
        "Timeout": 15, 
        "LastModified": "2018-08-02T14:40:00.845+0000", 
        "Runtime": "java8", 
        "Description": ""
    }, 
    "Tags": {
        "tr:financial-identifier": "283711002", 
        "tr:environment-type": "LAB", 
        "tr:resource-owner": "Andrew.Dean@thomsonreuters.com", 
        "tr:resource-owner-role-id": "AROAJQWMH2BYMTOKXRFVQ", 
        "tr:application-asset-insight-id": "200049"
    }
}
EOF
)

new_ARN=$( "$output" | jq '.Configuration.FunctionArn' )
echo $new_ARN
