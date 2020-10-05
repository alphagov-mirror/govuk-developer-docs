---
owner_slack: "#govuk-2ndline"
title: 'Email Alert API: Unprocessed work'
section: Icinga alerts
subsection: Email alerts
layout: manual_layout
parent: "/manual.html"
last_reviewed_on: 2020-10-05
review_in: 6 months
---

> Sometimes we lose work due to [a flaw with the Sidekiq queueing system](https://github.com/mperham/sidekiq/wiki/Problems-and-Troubleshooting#my-sidekiq-process-is-crashing-what-do-i-do). At 30 minute intervals a job, [RecoverLostJobsWorker], will try to requeue work that has not been processed [within an hour](https://github.com/alphagov/email-alert-api/blob/2f3931ac1ca25fe8c79b2405af98d1de55e1d47b/app/workers/recover_lost_jobs_worker/unprocessed_check.rb#L13).

This alert indicates that Email Alert API has work that has not been processed in the generous amount of time we expect it to have been - see [here](https://github.com/alphagov/email-alert-api/tree/master/app/workers/metrics_collection_worker) for the timings for each alert.

* **[`unprocessed content changes`](https://github.com/alphagov/email-alert-api/blob/master/app/workers/process_content_change_worker.rb)**. This means we're not generating emails for subscribers with "immediate" frequency subscriptions in response to [a change in some content] on GOV.UK.

* **[`unprocessed messages`](https://github.com/alphagov/email-alert-api/blob/master/app/workers/process_message_worker.rb)**. This means we're not generating emails for subscribers with "immediate" frequency subscriptions in response to [a custom message].

Things to check:

* Check [Sentry] for errors.

* Check the [Sidekiq dashboard] for worker failures.

* Check [Kibana] for errors - use ```@fields.worker: <worker class>``` for the query.

* Manually retry any pending jobs from a console: `Sidekiq::RetrySet.new.retry_all`.

* Check the [Email Alert API Technical dashboard] for performance issues.

If all else fails, you can try running the work manually from a console, similarly to [the automatic recovery worker](https://github.com/alphagov/email-alert-api/blob/2f3931ac1ca25fe8c79b2405af98d1de55e1d47b/app/workers/recover_lost_jobs_worker/unprocessed_check.rb#L13), but using `new.perform` instead of `perform_async`.

[Sentry]: https://sentry.io/organizations/govuk/issues/?project=202220&statsPeriod=6h
[a custom message]: https://github.com/alphagov/email-alert-api/blob/master/docs/api.md#post-messages
[a change in some content]: https://github.com/alphagov/email-alert-api/blob/master/docs/api.md#post-content-changes
[Kibana]: https://kibana.logit.io/s/2dd89c13-a0ed-4743-9440-825e2e52329e/app/kibana#/discover?_g=(refreshInterval:(display:Off,pause:!f,value:0),time:(from:now-1h,mode:quick,to:now))&_a=(columns:!('@message',host),index:'*-*',interval:auto,query:(query_string:(query:'@type:%20sidekiq%20AND%20application:%20email-alert-api%20AND%20@fields.worker:%20ProcessContentChangeWorker')),sort:!('@timestamp',desc))
[RecoverLostJobsWorker]: https://github.com/alphagov/email-alert-api/blob/master/app/workers/recover_lost_jobs_worker.rb

[Sidekiq dashboard]: https://grafana.production.govuk.digital/dashboard/file/sidekiq.json?refresh=1m&orgId=1&var-Application=email-alert-api&var-Queues=All&from=now-3h&to=now
[Email Alert API Technical dashboard]: https://grafana.production.govuk.digital/dashboard/file/email_alert_api_technical.json?refresh=1m&orgId=1
