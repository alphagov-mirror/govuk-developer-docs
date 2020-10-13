---
owner_slack: "#govuk-corona-forms-tech"
title: COVID-19 Services
section: Services
layout: manual_layout
parent: "/manual.html"
last_reviewed_on: 2020-10-15
review_in: 1 month
---

Between March and October 2020 the GOV.UK operated three standalone
services for the COVID-19 pandemic response:

- [Business volunteer service](#business-volunteer-service)
- [Vulnerable people service](#vulnerable-people-service)
- [Find support service](#find-support-service)

These services are no longer deployed, live or in active development.

## Business volunteer service

This service allowed businesses to tell us how they might be able to
help with the response to coronavirus.  That included goods or
services such as medical equipment, hotel rooms or childcare.

**The service has been replaced with a guidance page.**

A backup of the production database was taken prior to the service
being removed. It is available in the `govuk-production-database-backups`
AWS S3 bucket named `coronavirus-business-volunteer-form/production.sql.gzip`
with 365 day retention period (expiry date: Wed, 13 Oct 2021 00:00:00
GMT) as per our privacy policy.

For details...

```shell
gds aws govuk-production-poweruser aws s3api head-object --bucket govuk-production-database-backups --key coronavirus-business-volunteer-form/production.sql.gzip
```

- [Original GitHub Repository](https://github.com/alphagov/govuk-coronavirus-business-volunteer-form)
- [Information on how to bring this service back to life](https://github.com/alphagov/govuk-coronavirus-business-volunteer-form/blob/master/docs/how-to-bring-back-this-service.md)
- [PaaS deployment YAML file](https://github.com/alphagov/govuk-coronavirus-business-volunteer-form/blob/76ba8ce4e6b08bc2a7c3cc6acb9cdaea35530933/concourse/tasks/deploy-to-govuk-paas.yml) for [restoring the PaaS infrastructure](#restoring-the-paas-infrastructure)
- [Concourse pipeline YAML definition file](https://github.com/alphagov/govuk-coronavirus-business-volunteer-form/blob/master/concourse/pipeline.yml) for [restoring the Concourse pipeline](#restoring-the-concourse-pipeline)
- Here are screenshots of the [required settings](images/pingdom/business-volunteers-required.png) and [optional settings](images/pingdom/business-volunteers-optional.png) to recreate the Pingdom check
- [Restoring the Sentry error monitor](images/sentry/business-volunteers.png)
- [Restoring the AWS infrastructure](https://github.com/alphagov/covid-engineering/pull/948)

## Vulnerable people service

This service allowed people identified as vulnerable by the NHS to
tell us if they need help accessing essential supplies and support.
Users will have received a link to the service in a letter or a text
message from the NHS, or been advised by their GP to fill in the form.

**The service has been rebuilt by #vulnerable-people-services team.**

- [Original GitHub Repository](https://github.com/alphagov/govuk-coronavirus-vulnerable-people-form)
- [Rebuilt Service GitHub Repository](https://github.com/alphagov/govuk-shielded-vulnerable-people-service)

## Find support service

This service allowed the public - who may not have been eligible for
the extremely vulnerable service - to find information about what help
is available if they're struggling with unemployment, an inability to
get food, having somewhere to live, or their general wellbeing as a
result of coronavirus.

**The service has now been migrated and is now a smart answer.**

A backup of the production database was taken prior to the service
being removed. It is available in the `govuk-production-database-backups`
AWS S3 bucket under `coronavirus-find-support/production.sql.gzip`
with 365 day retention period (expiry date: Fri, 08 Oct 2021 00:00:00 GMT)
as per our privacy policy.

For details...

```shell
gds aws govuk-production-poweruser aws s3api head-object --bucket govuk-production-database-backups --key coronavirus-find-support/production.sql.gzip
```

- [Smart Answers GitHub Repository](https://github.com/alphagov/smart-answers/blob/master/lib/smart_answer_flows/find-coronavirus-support.rb)
- [Original GitHub Repository](https://github.com/alphagov/govuk-coronavirus-find-support)
- [Restoring the AWS infrastructure](https://github.com/alphagov/covid-engineering/pull/890)

## Restoring the PaaS infrastructure

Details on how to restore or recreate the PaaS infrastructure can be
found [here](https://docs.cloud.service.gov.uk/#gov-uk-platform-as-a-service).

Here are a series of screenshots that may assist with the recreation process:

- [Organisations](images/organisations.png)
- [govuk-development-overview](images/govuk-development-overview.png)
- [Applications](images/production-applications.png)
- [Backing services](images/production-backing-services.png)
- [Business volunteer service](images/business-volunteer-overview-production.png)
- [Vulnerable people service](images/vulnerable-people-overview-production.png)

## Restoring the Concourse pipeline

Details on how to restore or recreate a Concourse pipeline can be found [here](https://docs.publishing.service.gov.uk/manual/concourse.html#creating-new-pipelines).

## Restoring the PagerDuty alert

Here are a series of screenshots that may assist with the recreation process:

- [Activity tab](images/pagerduty/activity-tab.png)
- [Integrations tab](images/pagerduty/integrations-tab.png)
- [Response tab](images/pagerduty/response-tab.png)
- [Incoming event source](images/pagerduty/incoming-event-source.png)
- [Edit rule - when events match these conditions](images/pagerduty/edit-rule-conditions.png)
- [Edit rule - do these things](images/pagerduty/edit-rule-things.png)
- [Edit rule - at these times](images/pagerduty/edit-rule-times.png)

## Restoring the Prometheus AlertManager monitor

To restore or recreate the Prometheus monitor [revert this PR](https://github.com/alphagov/prometheus-aws-configuration-beta/pull/433)
