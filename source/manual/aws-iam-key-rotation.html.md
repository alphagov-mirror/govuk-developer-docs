---
title: AWS IAM Key Rotation
parent: "/manual.html"
layout: manual_layout
type: learn
section: AWS
owner_slack: "#govuk-developers"
last_reviewed_on: 2020-01-17
review_in: 6 months
---

## Overview

GOV.UK uses [AWS IAM] accounts to manage applications access to our AWS
infrastructure. The [Access Keys] associated with these accounts need to be
[rotated] every 3 months.

Rotating AWS IAM keys requires permissions which are available with the `admin`,
`internal-admin`, `platformhealth-poweruser` or `poweruser` roles. If you can't
assume one of these roles, you won't be able to rotate keys.

## How to rotate Access Keys

Log in to the [IAM Management Console] in the environment you want to rotate
keys for and you'll see a list of users and the age of their access keys.

### 1. Find users access key

- Click on the user whose key you want to rotate.
- Click on the `Security Credentials` tab.

Users should always only have one access key. The only time a user should have
two keys is when we are in the process of rotating the old one. For this reason,
AWS allow users to have a maximum of two Access Keys at the same time.

If this user has no keys, consider deleting it if it's not needed.

If this user has only one key, make a note of the `Access Key ID` and proceed to
[find out if the key is used].

If this user has two keys, you'll need to follow this guide twice. The first
time, you'll need to consider one key as the old one to rotate and the other key
as if it was a new one just created. The second time, you'll follow the guide as
normal as the user will then have only one key. Now, choose which key is the one
you are going to rotate and apply the following steps to that key.

### 2. Find out if the key is used

- Check the `Last used` value.
- If the value is a date, [find where the key is used].
- If it's `N/A`, you can safely [remove the key] as it was never used.

### 3. Find where the key is used

- Enter [govuk-secrets/puppet] in your machine.
- Run the appropriate [Puppet AWS common actions] considering the following:
  - The command to run is related to the environment you need to target. For
  example, to edit global staging credentials in the `govuk::apps` namespace,
  you need to run `bundle exec rake 'eyaml:edit[staging,apps]'`.
  - You may need to run more than one command. For example, to edit the global
  integration credentials both in and out of the `govuk::apps` namespace, you
  need run both `$ bundle exec rake 'eyaml:edit[integration]'` and
  `$ bundle exec rake 'eyaml:edit[integration,apps]'`.
- Search for the `Access Key ID` in the result.

Repeat the previous steps for [govuk-secrets/puppet_aws]:
- Enter [govuk-secrets/puppet_aws].
- Run the same command(s) again.
- Search for the `Access Key ID` in the result.

Keys may also be defined in more then one place, for example the hieradata
values `govuk::apps::support::aws_access_key_id` and
`govuk::apps::support_api::aws_access_key_id` contain the same key.

Keys may also be shared across AWS and Carrenza environments.

If the key is not present in the hieradata, it might be present in the control
panel of one of the 3rd party services, such as Fastly or Logit.

> **Note**
> If the key is not present in `govuk-secrets` nor in any other 3rd party
> services, you can [remove the key].

### 4. Create and deploy new key

- Click `Create access key` in `Security credentials`
- If the key to change was in a 3rd party provider:
  - Replace the old `Access Key ID` and `Secret access key` with the new ones.
- If the key to change was in `govuk-secrets`:
  - Replace the old `Access Key ID` and `Secret access key` with the new ones.
  - Redeploy [govuk-puppet] so it picks up the new key.
  - Either wait up to 30 minutes for this to take effect or run
  `govuk_puppet --verbose` in the machine that uses that key.

### 5. Ensure new key is being used

Ensure that the `Last used` values change to show that the new key is being
used and the old key is not used. Keys that are used infrequently may take a
while to update and updates can take a few minutes to show in the control panel.

If the `Last used` time of the old key continues to change, the key has not been
completely removed so you'll need to [find where the key is used] again.

If the `Last used` time of the old key doesn't change anymore, you can
[remove the key].

### 6. Remove the old key

Old keys can either be deleted or made inactive. Making the key inactive will
prevent the key from being used, but it can quickly be made active again. This
is useful if you are not confident that all uses of the key have been updated.
In production systems, this could prevent minor outages scaling into incidents.

- Notify [2ndline] that you are about to delete a key or make a key inactive.
- Click `Make inactive` to inactivate the key o click the `X` to delete it.

## Command Line Interface

It's also possible to view and update access keys with the [AWS CLI].


[AWS IAM]: https://docs.aws.amazon.com/en_pv/IAM/latest/UserGuide/id_users.html
[Access Keys]: https://docs.aws.amazon.com/en_pv/IAM/latest/UserGuide/id_credentials_access-keys.html
[rotated]: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_RotateAccessKey
[IAM Management Console]: https://console.aws.amazon.com/iam/home?region=eu-west-1#/users
[govuk-secrets/puppet]: https://github.com/alphagov/govuk-secrets/tree/master/puppet
[Puppet AWS common actions]: https://github.com/alphagov/govuk-secrets/tree/master/puppet_aws#common-actions
[govuk-secrets/puppet_aws]: https://github.com/alphagov/govuk-secrets/tree/master/puppet_aws
[govuk-puppet]: https://github.com/alphagov/govuk-puppet
[find out if the key is used]: #2-find-out-if-the-key-is-used
[find where the key is used]: #3-find-where-the-key-is-used
[remove the key]: #6-remove-the-old-key
[2ndline]: /manual/2nd-line.html
[AWS CLI]: https://aws.amazon.com/blogs/security/how-to-rotate-access-keys-for-iam-users/
