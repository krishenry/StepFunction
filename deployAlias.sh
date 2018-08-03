#!/bin/sh

function deployFail {
    echo "Deploy to AWS Lambda failed"
	exit 1
}
trap deployFail ERR

CURDIR=`pwd`
#NAME=$(cat ./Code/lambdaName)
NAME=LizzieTestDev
ALIAS=KRIS
VERSION=1
#VERSION=$(cat ./Code/version)
#BUILD_VERSION=$VERSION.$GO_PIPELINE_COUNTER
#build_number=$1

existing_aliases=$(aws lambda list-aliases --function-name ${NAME} --region ${REGION} --output json| jq -r '.Aliases[] | {Name: .Name}')


if [[ $existing_aliases == *"$ALIAS"* ]]; then
  aws lambda update-alias --region ${REGION} --function-name ${NAME} --description "${NAME}" --function-version $VERSION  --name $ALIAS
else
   aws lambda create-alias --region ${REGION} --function-name ${NAME} --description "${NAME}" --function-version $VERSION --name $ALIAS
fi