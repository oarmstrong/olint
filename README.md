# olint

`olint` is a better [super-linter](https://github.com/github/super-linter).

Linting all the code in your repository is a well-known best practice.
GitHub's `super-linter` is a project that intends to make that easier, `olint`
works upon the same premise but improves the experience with some better design
decisions and first-class local support.

`olint` doesn't perform any linting itself but rather orchestrates running
existing, well established linters with an opinionated set of rules for each.

## Background

TODO

- Motivation
- Abstract deps
- intellectual provenance see also

## Install

The only requirement is the `olint.sh` script, `bash`, `git` and `docker`. The
script will download all linters and dependencies itself.

```bash
$ curl -L https://raw.githubusercontent.com/oarmstrong/olint/master/olint.sh -o ~/.local/bin/olint
$ which olint
~/.local/bin/olint
```

## Usage

The linter can be run locally on your project as well as via your CI system.
GitHub actions has been documented here but this should be useable by other CI
systems as long as it allows for the running of docker containers.

### CLI

There are no options available. `olint` will recursively lint all files that it
recognised the extension for in the current directory.

```bash
$ olint
[...]
Linting: editorconfig
Linting: markdown
Linting: yaml
[...]
```

### GitHub Actions

```yaml
---
on: [push]

jobs:
  lint:
    runs-on: ubuntu-latest
    name: Lint everything
    steps:
      - uses: actions/checkout@v2
      - uses: oarmstrong/olint@v1
```

## Maintainers

- @oarmstrong

## Contributing

Please feel free to submit
[issues](https://github.com/oarmstrong/olint/issues/new) for any bugs or
feature requests. PRs with improvements are always welcome too!

Alternatively you may contact `ollie@armstrong.io` if you'd prefer.

Contributor guidelines are simply: don't be a dick. This project is welcoming
of contributions from anyone, quality of code is the only thing to be judged or
criticised. Personal comments of any kind are not relevant.

## License

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
