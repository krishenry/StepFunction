#!/bin/sh

function deployFail {
    echo "Deploy to AWS Lambda failed"
	exit 1
}
trap deployFail ERR

CURDIR=`pwd`

variables=( $line )
echo ${variables[0]} 
echo ${variables[1]} 

NAME=${variables[0]}
ALIAS=WORKS
VERSION=${variables[1]}

existing_aliases=$(aws lambda list-aliases --function-name ${NAME} --region ${REGION} --output json| jq -r '.Aliases[] | {Name: .Name}')


if [[ $existing_aliases == *"$ALIAS"* ]]; then
  aws lambda update-alias --region ${REGION} --function-name ${NAME} --description "${NAME}" --function-version $VERSION  --name $ALIAS
else
   aws lambda create-alias --region ${REGION} --function-name ${NAME} --description "${NAME}" --function-version $VERSION --name $ALIAS
fi

