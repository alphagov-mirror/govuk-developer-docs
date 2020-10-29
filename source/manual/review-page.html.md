---
owner_slack: "#govuk-developers"
title: Review a page in this manual
section: Documentation
layout: manual_layout
parent: "/manual.html"
---

Every page in the manual has a "Last updated" value, based on the timestamp of the last commit associated with the file. The more recent the date, the more confidence the reader can have that the content is accurate.

It is helpful to review a document at the point of using it, as you likely have the most context for the problem at that moment in time.

## How to review

### Things to look out for

- Is the page accurate?
- Is the page still relevant?
- Does it help the reader complete their task?
- Does it [follow the styleguide](/manual/docs-style-guide.html)?

### When you've reviewed the page, either:

- Update the page
- Remove it (don’t forget to [set up a redirect][redirects])
- Assign it for someone else to review
- Confirm the page is OK and set a new 'last updated' date

If you've not had to make any changes to the content itself, you could add a HTML comment to the bottom of the document, e.g. `<!-- Reviewed on YYYY-MM-DD by NAME -->`.

### Relevant blog posts to link to

Is there a relevant blog post to the page you're reviewing? Would linking to it help the reader complete their task?

You can find [GOV.UK blog posts on the GDS Tech blog](https://gdstechnology.blog.gov.uk/category/gov-uk/).

[redirects]: https://github.com/alphagov/govuk-developer-docs/blob/master/config/tech-docs.yml
