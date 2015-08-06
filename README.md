# Multi-Factor Authentication (MFA) with Role Delegation for AWS CLI

The use AWS CLI with Role Delegation protected by MFA you need to:

1. Get a session token from STS for an IAM user
2. Assume a role in a account you want to work with

This little script helps you to achieve the goal of using the AWS CLI in a MFA protected way.

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

Now we create a function for every Role you want to assume. Open your `~/.bash_profile`:

```
function aws_acc1() { . ~/.aws/mfacli.sh $1 <ACCOUNT 1 ID> <ROLE>; }
```

If you want to assume a rolw in a different account, just add a line to your `~/.bash_profile`:

```
function aws_acc2() { . ~/.aws/mfacli.sh $1 <ACCOUNT 2 ID> <ROLE>; }
```

## Usage

```
aws_acc1 <TOKEN>
```
