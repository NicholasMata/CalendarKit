# Contributing to CalendarKit

Thank you for helping improve CalendarKit. Contributions should be focused,
documented, and easy to review.

## Getting Started

1. Fork and clone the repository.
2. Open `Package.swift` in Xcode or work from the command line.
3. Create a branch for your change.
4. Keep changes scoped to one feature, fix, or documentation concern.

CalendarKit requires Swift 6.0, iOS 17 or later, and macOS 15 or later.

## Building and Testing

Build the package from the repository root:

```sh
swift build
```

Run the test suite:

```sh
swift test
```

Add or update tests when behavior changes. Before submitting a pull request,
make sure the package builds and all applicable tests pass.

## Documentation

Document new public APIs with concise source comments. Add or update DocC
articles when a change introduces concepts that need more explanation than an
API comment can provide.

Build the combined DocC archive and preview its static output locally:

```sh
DOCC_HOSTING_BASE_PATH="" zsh ./docs/build-docc-site.sh
python3 -m http.server 8080 --directory .build/docc/site
```

Open <http://localhost:8080/documentation/> and stop the server with Control-C.
The documentation build treats warnings as errors. See
[docs/README.md](docs/README.md) for details about the merged archive and
GitHub Pages deployment.

## Commit Messages

Write commit messages in the imperative mood and describe the change the commit
introduces:

```text
Add calendar month navigation
```

Keep the subject concise, ideally around 50 characters. When more context is
needed, leave a blank line after the subject and wrap the explanatory body at
approximately 72 characters.

Each commit should represent one coherent change. Separate unrelated code,
documentation, and infrastructure changes when they can be reviewed
independently.

For additional guidance, see
[A Note About Git Commit Messages](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).

## Pull Requests

In your pull request:

- Explain what changed and why.
- Call out behavior or API changes.
- Describe how you tested the change.
- Include screenshots for visible SwiftUI or documentation changes.
- Keep unrelated changes in separate pull requests.
