# Multi-factor authentication (MFA) with role delegation for AWS CLI

> If you only own a single AWS account, you’re facing a serious security risk! [This post](https://cloudonaut.io/your-single-aws-account-is-a-serious-risk/) will show you why this a problem and how you can solve it.

The use AWS CLI with role delegation protected by MFA you need to:

* Get a session token from STS for an IAM user using MFA
* Assume a role in a account you want to work with

![MFA with Role Delegation](./flow.png?raw=true "MFA with Role Delegation")

This little script helps you to achieve the goal of using the AWS CLI in a MFA protected way. 

** AWS CLI has built in support for MFA and role delegation. THis script is no longer needed! Scroll to the bottom to see how to configure AWS CLI!**

## Installation

```
mkdir -p ~/.aws/
wget -O ~/.aws/mfacli.sh https://raw.githubusercontent.com/widdix/aws-mfacli/master/mfacli.sh
chmod 700 ~/.aws/mfacli.sh
```

## Configuration

Open `~/.aws/mfacli.sh`:

* `DEFAULT_REGION`: e.g. eu-west-1
* `ACCOUNT_ID`: the 12 digit AWS account id
* `USERNAME`: the name of your IAM user
* `ACCESS_KEY_ID`: access key of your IAM user
* `SECRET_ACCESS_KEY`: access secret of your IAM user

Now we create a function for every role you want to assume. Open your `~/.bash_profile`:

```
function aws_acc1() { . ~/.aws/mfacli.sh $1 <ACCOUNT 1 ID> <ROLE>; }
```

If you want to assume a role in a different account, just add a line to your `~/.bash_profile`:

```
function aws_acc2() { . ~/.aws/mfacli.sh $1 <ACCOUNT 2 ID> <ROLE>; }
```

## Usage

In your Terminal, type:

```
aws_acc1 <TOKEN>
```

## Configure AWS CLI with MFA and role delegation

Replace the following placeholders in the `~/.aws/config` section:

* `<DEFAULT_REGION>`: e.g. eu-west-1
* `<BASTION_ACCOUNT_ID>`: the 12 digit AWS account id of your bastion account
* `<USERNAME>`: the name of your IAM user in the bastion account
* `<ACCESS_KEY_ID>`: access key of your IAM user in the bastion account
* `<SECRET_ACCESS_KEY>`: access secret of your IAM user in the bastion account
* `<ACCOUNT1_ID>`: the 12 digit AWS account id

Open `~/.aws/config`:

```
[profile bastion]
region = <DEFAULT_REGION>
aws_access_key_id = <ACCESS_KEY_ID>
aws_secret_access_key = <SECRET_ACCESS_KEY>
[profile account1]
source_profile = bastion
role_arn = arn:aws:iam::<ACCOUNT1_ID>:role/<ROLE>
mfa_serial = arn:aws:iam::<BASTION_ACCOUNT_ID>:mfa/<USERNAME>
```

If you want to interact with the CLI add `--profile account1` to your call like `aws --profile account1 s3 ls`.
