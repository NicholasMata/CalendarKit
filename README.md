# CalendarKit

CalendarKit is a layered Swift package for building calendar experiences on Apple platforms.

## Package Structure

The project is split into three libraries:

- `CalendarExtensions`
  Foundation-first calendar models and utilities with no SwiftUI dependency.
- `CalendarKit`
  Composable SwiftUI building blocks for creating custom calendar interfaces.
- `CalendarUI`
  Higher-level, opinionated SwiftUI calendar views built on top of `CalendarKit`.

## Documentation

DocC catalogs are included for all three libraries and are published as one merged documentation site.

To build the static documentation site locally:

```sh
zsh ./docs/build-docc-site.sh
```

Then open:

```sh
open .build/docc/site/index.html
```

Additional documentation build details live in [docs/README.md](docs/README.md).

## GitHub Pages

The repository includes a GitHub Actions workflow that builds and deploys the DocC site to GitHub Pages.

Workflow file:

- [`.github/workflows/deploy-docc.yml`](.github/workflows/deploy-docc.yml)

To enable deployment, configure the repository's Pages source to use **GitHub Actions**.
