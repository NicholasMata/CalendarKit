# Documentation

CalendarKit publishes the DocC catalogs for `CalendarExtensions`,
`CalendarKit`, and `CalendarUI` as one combined DocC archive. DocC synthesizes
the package landing page and provides unified navigation and search across the
three modules.

Build the site from the repository root:

```sh
zsh ./docs/build-docc-site.sh
```

The combined archive is written to `.build/docc/CalendarKit.doccarchive`, and
the static site is written to `.build/docc/site`.

## Previewing Locally

Build without a hosting base path, then serve the generated static site over
HTTP:

```sh
DOCC_HOSTING_BASE_PATH="" zsh ./docs/build-docc-site.sh
python3 -m http.server 8080 --directory .build/docc/site
```

Open <http://localhost:8080/documentation/>. Stop the server with Control-C.

`docc preview` accepts a source `.docc` catalog, not the combined compiled
`.doccarchive`, so it can't preview the merged archive directly.

The build treats DocC warnings as errors so broken symbol links and invalid
catalog content fail locally and in continuous integration. It then uses
`docc merge` to combine the module archives without a custom HTML landing page.
The build also verifies that the synthesized landing page contains its image
resources before producing a deployable artifact.

GitHub Actions runs the same script and deploys the generated site to GitHub
Pages. Configure the repository's Pages source to use GitHub Actions before
running the deployment workflow.
