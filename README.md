# vale-style

Vale rules for plain technical prose in C and C++ projects. They check Markdown, changelogs, source comments, licence headers, commit messages and pull request bodies. Tested with [Vale](https://vale.sh) 3.26.0.

## Use

Name the package in the project's `.vale.ini`:

```ini
StylesPath = .vale/styles
MinAlertLevel = suggestion
Packages = https://github.com/jamiebullock/vale-style/releases/download/v0.1.0/vale-style.zip
```

`vale sync` downloads the package, and `vale .` checks the tree. The package carries its own configuration, so those three lines are a complete `.vale.ini`.

`vale sync` also downloads [ai-tells](https://github.com/tbhb/vale-ai-tells) 1.37.0, which supplies five of the rules.

Keep the synced files out of version control:

```gitignore
.vale/styles/.vale-config/
.vale/styles/Changelog/
.vale/styles/Comments/
.vale/styles/Commit/
.vale/styles/Licence/
.vale/styles/Plain/
.vale/styles/PullRequest/
.vale/styles/ai-tells/
.vale/styles/config/dictionaries/
.vale/styles/config/scripts/
.vale/styles/config/templates/
.vale/styles/config/views/
.vale/styles/config/vocabularies/Programming/
```

## Files and styles

| Files | Styles |
| --- | --- |
| `*.md` | Plain, ai-tells |
| `CHANGELOG.md` | Plain, Changelog |
| `*.c`, `*.h`, `*.i` | Plain, Comments, Licence |
| `*.cc`, `*.cpp`, `*.cxx`, `*.hh`, `*.hpp`, `*.hxx` | Plain, Comments without `LineComment`, Licence |
| `CMakeLists.txt`, `*.cmake`, `Makefile`, `*.mk`, `*.py` | Licence |
| `COMMIT_EDITMSG` | Plain, Commit, ai-tells |
| `PR_BODY.md` | Plain, PullRequest |

In C and C++ files the Plain and Comments rules read the comments only.

| Style | Rules |
| --- | --- |
| Plain | ASCII only, British spelling, no repeated word, no metaphor or filler, no qualifier of candour, no tool attribution, no reference to planning material. Two warnings: a statement defined against an alternative, and a claim about use in the field |
| Changelog | The format under [Changelog format](#changelog-format) |
| Comments | Block comments in C, no issue or pull request reference, and a warning for change history |
| Licence | The header under [Licence header](#licence-header) |
| Commit | A subject that opens with a type, has no closing full stop and is 72 characters at most, and a warning for a body that describes the work |
| PullRequest | Summary, Changes and Checklist sections, a Summary that opens "This PR", bullet lists under Changes and Checklist, and no hard-wrapped paragraph |
| ai-tells | `ConsequenceClause`, `BareHolds`, `NegatedObject`, `UniversalSubject` and `SemicolonUsage`, as warnings |

## Changelog format

The Changelog style checks a `CHANGELOG.md` against [Common Changelog](https://common-changelog.org):

- The file opens with `# Changelog`, and the first release heading follows it
- A release heading is `## [X.Y.Z] - YYYY-MM-DD`. Releases run from newest to oldest, and each has a link at the foot of the file
- A release may have one notice, a single line in italics directly under its heading
- The sections are Changed, Added, Removed and Fixed, in that order
- An entry is one line of 20 words at most, with no closing full stop
- An entry opens with a verb in the imperative, taken from the list below
- An entry ends with a linked pull request, issue or commit in parentheses
- A breaking change opens with `**Breaking:**` and a lower-case verb, and comes first in its section

```markdown
# Changelog

## [1.1.0] - 2026-02-01

### Changed

- **Breaking:** rename `ex_mean` to `ex_average` ([#14](https://github.com/owner/name/pull/14))
- Raise the minimum CMake version to 3.21 ([#13](https://github.com/owner/name/pull/13))

### Fixed

- Fix the phase sign of `ex_spectrum` on Linux ([#12](https://github.com/owner/name/pull/12))

## [1.0.0] - 2026-01-01

_First release._

[1.1.0]: https://github.com/owner/name/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/owner/name/releases/tag/v1.0.0
```

The verbs are Accept, Add, Allow, Assert, Build, Bump, Change, Check, Correct, Deprecate, Document, Drop, Exclude, Fix, Implement, Include, Keep, Limit, Make, Match, Move, Raise, Read, Reduce, Reject, Remove, Rename, Replace, Report, Require, Restrict, Return, Set, Speed, Stop, Support, Tag, Take, Treat and Use.

## Licence header

The Licence style checks that a file opens with a project line and two SPDX tags. A file may carry more than one copyright line.

```c
/* Part of Example
 *
 * SPDX-FileCopyrightText: 2026 A. N. Author
 * SPDX-License-Identifier: Zlib
 */
```

CMake, Make and Python files use the same four lines with `#`, after the shebang line where there is one.

## Overrides

Settings in the project's `.vale.ini` apply after the package's.

```ini
StylesPath = .vale/styles
MinAlertLevel = suggestion
Packages = https://github.com/jamiebullock/vale-style/releases/download/v0.1.0/vale-style.zip
Vocab = Example

[*.{c,h}]
Example.Name = YES
Comments.History = NO
Plain.Contrast = error

[third_party/**]
BasedOnStyles =
```

- `Vocab = Example` adds the words in `.vale/styles/config/vocabularies/Example/accept.txt` to the package's vocabulary
- `Example.Name = YES` turns on the project's own rule in `.vale/styles/Example/Name.yml`. The style needs a name the package does not use
- A rule set to `NO` is off for those files, and a rule set to a level reports at that level
- An empty `BasedOnStyles` skips the files that match
- A `BasedOnStyles` line that names a style replaces the package's styles for the files that match, so it names those too: `BasedOnStyles = Plain, Comments, Licence, Example`

## Commit messages and pull request bodies

A commit message is checked from a file named `COMMIT_EDITMSG`, and a pull request body from a file whose name ends `PR_BODY.md`:

```sh
git log -1 --format=%B > COMMIT_EDITMSG
vale COMMIT_EDITMSG

gh pr view 12 --json body --jq .body > PR_BODY.md
vale PR_BODY.md
```

## Development

Each style has a test file beside its rules. `vale sync` fetches ai-tells, and then the tests run:

```sh
vale sync
vale test --coverage styles/Plain styles/Changelog styles/Comments styles/Commit styles/PullRequest styles/Licence
vale README.md CHANGELOG.md DEPENDENCIES.md
```

A release is a tag `vX.Y.Z` on `main` with a matching entry in `CHANGELOG.md`. Pushing the tag builds `vale-style.zip` and publishes it as a GitHub release.

## Licence

The package is under the zlib licence, in `LICENSE`. The British English dictionary in `styles/config/dictionaries/` is under the LGPL. `DEPENDENCIES.md` lists it and the other components.
