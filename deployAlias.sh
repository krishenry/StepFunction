#!/bin/sh

function deployFail {
    echo "Deploy to AWS Lambda failed"
	exit 1
}
trap deployFail ERR

CURDIR=`pwd`

#split function for lambda name and version
variables=( $line )
echo ${variables[0]} #variable 0 is Lambda name
echo ${variables[1]} #variable 1 is version

NAME=${variable[0]}
ALIAS=WORKS
VERSION=${variable[1]}

existing_aliases=$(aws lambda list-aliases --function-name ${NAME} --region ${REGION} --output json| jq -r '.Aliases[] | {Name: .Name}')


if [[ $existing_aliases == *"$ALIAS"* ]]; then
  aws lambda update-alias --region ${REGION} --function-name ${NAME} --description "${NAME}" --function-version $VERSION  --name $ALIAS
else
   aws lambda create-alias --region ${REGION} --function-name ${NAME} --description "${NAME}" --function-version $VERSION --name $ALIAS
fi

