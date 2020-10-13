---
owner_slack: "#re-govuk"
title: MongoDB backups
layout: manual_layout
parent: "/manual.html"
section: Backups
type: learn
last_reviewed_on: 2020-10-13
review_in: 6 months
---

## mongodumps to S3

We backup to an AWS S3 bucket.

The timings are defined by parameters [set in the manifest](https://github.com/alphagov/govuk-puppet/blob/master/modules/mongodb/manifests/s3backup/cron.pp), but for important MongoDB clusters these may be taken every 15 minutes. The machines which take the backups are defined in hiera node classes.

These backups are encrypted using GPG, but the functionality is similar to mongodump.

### Restoring

Use the `/usr/local/bin/mongodb-restore-s3` script available on MongoDB machines which have S3 backup enabled.

This script grabs the latest backup from the S3 bucket, decrypts and unpacks it, and does a `mongo restore`.

Machines which have enabled S3 backups and contain the script will have `mongodb::backup::s3_backups` set to `true` in their yaml configuration (see [`govuk-puppet`](https://github.com/alphagov/govuk-puppet)).

### mongodumps via `govuk_env_sync` in AWS

In AWS environments, the mongodump to S3 has been replaced by a very similar mechanism as part of the [govuk-env-sync].

The dump is not GPG encrypted anymore, instead we rely on S3 for encryption at rest.

[govuk-env-sync]: govuk-env-sync.html
