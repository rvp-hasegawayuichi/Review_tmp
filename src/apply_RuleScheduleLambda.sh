# Description: Apply CloudFormation template for RuleScheduleLambda
# Usage: ./apply_RuleScheduleLambda.sh [deploy]
#!/usr/bin/env bash

set -u
set -e

Env="${Env:-dev}"
CFN_STACKNAME="elb-rule-schedule-lmd"
CFN_TEMPLATE="RuleScheduleLambda.yml"
CFN_PARAMETERS="RuleScheduleLambda.$Env.json"

CHANGESET_OPTION="--no-execute-changeset"

if [ $# = 1 ] && [ "$1" = "deploy" ]; then
  echo "deploy mode"
  CHANGESET_OPTION=""
fi

aws --profile "${AWS_PROFILE:-revamp}" cloudformation deploy \
    --stack-name ${CFN_STACKNAME} \
    --template-file ${CFN_TEMPLATE} \
    --parameter-overrides "file://${CFN_PARAMETERS}" \
    --capabilities CAPABILITY_NAMED_IAM \
    ${CHANGESET_OPTION}
