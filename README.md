# Multi-factor authentication (MFA) with role delegation for AWS CLI

> If you only own a single AWS account, you’re facing a serious security risk! [This post](https://cloudonaut.io/your-single-aws-account-is-a-serious-risk/) will show you why this a problem and how you can solve it.

The use AWS CLI with role delegation protected by MFA you need to:

* Get a session token from STS for an IAM user using MFA
* Assume a role in a account you want to work with

![MFA with Role Delegation](./flow.png?raw=true "MFA with Role Delegation")

AWS CLI has built in support for MFA and role delegation. The `mfacli.sh` script in this repository is no longer the best way to solve the problem. Read our in-depth instructions about [how to solve the problem with the AWS CLI itself](https://cloudonaut.io/improve-aws-security-protect-your-keys-with-ease/).
