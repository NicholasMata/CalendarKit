# Documentation

CalendarKit publishes the DocC catalogs for `CalendarExtensions`,
`CalendarKit`, and `CalendarUI` as a single static site.

Build the site from the repository root:

```sh
zsh ./docs/build-docc-site.sh
```

The generated site is written to `.build/docc/site`. Open
`.build/docc/site/index.html` to browse it locally.

GitHub Actions runs the same script and deploys the generated site to GitHub
Pages. Configure the repository's Pages source to use GitHub Actions before
running the deployment workflow.
