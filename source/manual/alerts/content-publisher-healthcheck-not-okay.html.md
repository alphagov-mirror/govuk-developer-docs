---
owner_slack: "#govuk-pubworkflow-dev"
title: content-publisher app healthcheck not ok
section: Icinga alerts
layout: manual_layout
parent: "/manual.html"
last_reviewed_on: 2020-02-06
review_in: 6 months
---

There are a few things that this alert can be, you'll need to click on the alert to find out more details on what's gone wrong. There are more details and common fixes listed below.

## Government Data Check

This means that content publisher is having trouble updating government data. Ordinarily it does this every fifteen minutes and seeing this error means it hasn't happened in at least 6 hours. The code for the job can be found [here][https://github.com/alphagov/content-publisher/blob/07e9acb6d1b559387b5402c8b696bccfa0b31097/app/jobs/populate_bulk_data_job.rb], please check the app logs for more details. 

## Sidekiq redis

This is a standard GovukHealthcheck that checks content publisher has a connection to Redis via Sidekiq.

## Active record

This is a standard GovukHealthcheck that checks content publisher has a connection to its database via ActiveRecord.
