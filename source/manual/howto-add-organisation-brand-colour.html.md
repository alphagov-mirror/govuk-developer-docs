---
owner_slack: "#govuk-developers"
title: Add an organisation's brand colour
section: Publishing
layout: manual_layout
parent: "/manual.html"
last_reviewed_on: 2020-09-28
review_in: 6 months
related_applications: [whitehall, government-frontend]
---

An organistion's brand colour is used to style their organisation page (such as
dividing lines, icons and link text). For example
see the [DCMS organisation page](https://www.gov.uk/government/organisations/department-for-digital-culture-media-sport).

The colour is set as an option under a drop down field called "brand colour" when
creating or editing an [organisation page in Whitehall Publisher](https://whitehall-admin.publishing.service.gov.uk/government/admin/organisations).

## 1. Add the brand colour in GOV.UK Frontend

Set up a fork of `govuk-frontend`, then add the colour to the [_colours-organisations.scss file](https://github.com/alphagov/govuk-frontend/blob/master/src/govuk/settings/_colours-organisations.scss) and update the [CHANGELOG](https://github.com/alphagov/govuk-frontend/blob/master/CHANGELOG.md).
See [updating changelog](https://github.com/alphagov/govuk-frontend/blob/master/docs/contributing/versioning.md#updating-changelog) and [example PR](https://github.com/alphagov/govuk-frontend/pull/1918) for more details.

> **Note**
>
> It may be some time before the next version of `govuk-frontend` is released,
to get the changes out on time you can add the colour in `govuk_publishing_components`,
see [this PR](https://github.com/alphagov/govuk_publishing_components/pull/1648)
as an example.

## 2. Add the organisation as brand colour option in Whitehall

Add a new entry for the organisation in [app/models/organisation_brand_colour.rb](https://github.com/alphagov/whitehall/blob/master/app/models/organisation_brand_colour.rb), which will show
the organisation as an option under the [brand colour drop down field](https://github.com/alphagov/whitehall/blob/52aff8f61a29b3999054b5b5c94875a5534eaf9a/app/views/admin/organisations/_form.html.erb#L25) in Whitehall.
The CSS class name should match the name used in `govuk-frontend`.

## Testing your changes locally

1. In your local fork of `govuk-frontend`, run `npm run build:package`
2. In `govuk_publishing_components`, update `package.json` to point to your local
  `govuk-frontend` repo, then run `npm install`
3. In `collections`, update the Gemfile to point to your local version of
  `govuk_publishing_components`
4. In `whitehall`, you should see the organisation as an option under the `brand
  colour` field (you will also need to update the `Status on GOV.UK` to `currently live`
  to view the page)
5. Run `./startup.sh —integration` in `collections` to view the organisation's page

> **Note**
>
> It may take some time for the colour to update on the page in `integration`.
> You might be able to speed up the process by running the
> [`publishing_api:republish_organisation[slug]`](https://deploy.blue.production.govuk.digital/job/run-rake-task/parambuild/?TARGET_APPLICATION=whitehall&MACHINE_CLASS=whitehall_backend&RAKE_TASK=publishing_api:republish_organisation[slug]) rake task in Whitehall.
