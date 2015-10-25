#!/bin/bash -e

#######################################################
#                                                     #
#                     DEPRECATED                      #
#                                                     #
# Please don't use this script anymore. Instead       #
# follow the instructions here: ttps://cloudonaut.io/ #
# improve-aws-security-protect-your-keys-with-ease/   #
#                                                     #
#######################################################
































#######################################################
#                                                     #
#                   Configuration                     #
#                                                     #
#######################################################

DEFAULT_REGION="eu-west-1"
ACCOUNT_ID="012345678910"
USERNAME="user1"
ACCESS_KEY_ID="XXX"
SECRET_ACCESS_KEY="YYY"



#######################################################
#                                                     #
#                        Usage                        #
#                                                     #
#######################################################

# call
# . ./aws-mfa.sh <MFA TOKEN> <ACCOUNT ID> <ROLE>
# to export env variables to current shell.



#######################################################
#                                                     #
#                    Implementation                   #
#                                                     #
#######################################################

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
unset AWS_SECURITY_TOKEN

export AWS_DEFAULT_REGION=$DEFAULT_REGION
export AWS_ACCESS_KEY_ID=$ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$SECRET_ACCESS_KEY

CRED=$(aws sts get-session-token --serial-number "arn:aws:iam::$ACCOUNT_ID:mfa/$USERNAME" --token-code $1 --query [Credentials.SessionToken,Credentials.AccessKeyId,Credentials.SecretAccessKey] --output text)

export AWS_ACCESS_KEY_ID=$(echo $CRED | cut -d ' ' -f 2)
export AWS_SECRET_ACCESS_KEY=$(echo $CRED | cut -d ' ' -f 3)
export AWS_SESSION_TOKEN=$(echo $CRED | cut -d ' ' -f 1)
export AWS_SECURITY_TOKEN=$(echo $CRED | cut -d ' ' -f 1)

CRED=$(aws sts assume-role --role-arn "arn:aws:iam::$2:role/$3" --role-session-name mfacli --query [Credentials.SessionToken,Credentials.AccessKeyId,Credentials.SecretAccessKey] --output text)

export AWS_ACCESS_KEY_ID=$(echo $CRED | cut -d ' ' -f 2)
export AWS_SECRET_ACCESS_KEY=$(echo $CRED | cut -d ' ' -f 3)
export AWS_SESSION_TOKEN=$(echo $CRED | cut -d ' ' -f 1)
export AWS_SECURITY_TOKEN=$(echo $CRED | cut -d ' ' -f 1)
