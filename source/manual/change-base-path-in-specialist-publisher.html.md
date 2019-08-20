---
title: Change a specialist document base path
parent: "/manual.html"
layout: manual_layout
section: Publishing
owner_slack: "#govuk-2ndline"
last_reviewed_on: 2019-08-20
review_in: 3 months
---

In [Specialist Publisher](https://specialist-publisher.publishing.service.gov.uk/), the base path is automatically generated based on the title when the specialist document is first created. We sometimes receive Zendesk tickets to change a base path when the title has been updated, as the publisher does not have the ability to do this.

You can use the Jenkins rake task runner to run the task:

[`base_path:edit[content_id,/new_base_path]`](https://deploy.publishing.service.gov.uk/job/run-rake-task/parambuild/?TARGET_APPLICATION=specialist-publisher&MACHINE_CLASS=backend&RAKE_TASK=base_path:edit[content_id,/new_base_path])

**NOTE**: the rake task will create a draft with the new slug, so requires you to hit 'Publish' in the Specialist Publisher
interface.

> You can find the `content_id` of the document using the [govuk-toolkit](https://github.com/alphagov/govuk-browser-extension) browser extension.
