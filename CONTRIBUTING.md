# Contributing to vale-style

Bug reports, fixes, new rules, tests and documentation improvements are welcome. This file covers how to get a change accepted and the terms it is accepted under.

## Before you start

- Open an issue for a rule that reports correct text, a rule that misses text its message describes, or a documentation gap. Include the Vale version, the smallest text that shows the problem and the alert.
- For a new rule, open an issue first to discuss it. The package holds rules that apply to any C or C++ project. A rule for one project belongs in that project's own style.

## Checks

The checks need [Vale](https://vale.sh) 3.26.0, the version CI runs, and Make. Before opening a pull request, run from the repository root:

```sh
make check
```

`make check` runs four targets, and each can be run alone:

- `make test` runs the test cases of every style.
- `make prose` checks every file that git tracks against the package's own rules.
- `make version` checks that `VERSION`, the newest release in `CHANGELOG.md` and the release that the README names agree.
- `make package` builds the archive from the last commit and checks a project that takes the package from it.

`make check VALE=<path>` runs them with a chosen binary. Give an absolute path.

CI also checks the title and the description of a pull request: the title as the subject of a commit message, and the description against the template. To run the same check before opening the pull request, write the title to a file named `COMMIT_EDITMSG` and the description to a file named `PR_BODY.md`, both outside the working tree, and pass the two paths to `vale` from the repository root.

## Rules

- A rule is one YAML file in the directory of its style under `styles/`. A script that a rule runs is in `styles/config/scripts/`.
- Each style has a test file beside its rules, named after the style. A rule that is added or changed comes with test cases for text it reports and text it accepts.
- `.vale.ini` assigns the styles to files, and a project receives it with the package. The tables under [Files and styles](README.md#files-and-styles) in the README list every assignment and every rule, so update them with the change.
- `styles/config/vocabularies/Programming/accept.txt` holds the programming terms that the dictionary does not. The dictionary in `styles/config/dictionaries/` is third-party and keeps its upstream text.
- A script and a Make file open with the header under [Licence header](README.md#licence-header) in the README. A new file gets the current year.
- A new third-party component gets an entry in `DEPENDENCIES.md`.

## Pull requests

- Branch from `develop` and name the branch `<type>/<short-description>`, where type is `feat`, `fix`, `chore` or `refactor`.
- Prefix the pull request title the same way: `fix: ...`, `feat: ...`.
- If the pull request resolves an issue, put `Closes #N` in the description so the issue closes on merge.
- Fill in the template. The Summary opens with "This PR" and a verb in lower case, and states what the change does and why in plain prose. Changes is one bullet per change.
- Keep a pull request to one change. A fix and an unrelated refactor are two pull requests.
- The maintainer merges. Do not merge your own pull request.

## Changelog

`CHANGELOG.md` records what each release changes for a project that uses the package. Its entries are written in the pull request that makes the release, so no other pull request touches it. The format is the one the package checks, described under [Changelog format](README.md#changelog-format) in the README. These rules cover what an entry says:

- An entry says what changed for the project. The reason, the mechanism and the history are in the pull request.
- Record only what a project can observe: a rule, its level, the files a style applies to, a setting, the version of a component the package brings, the licence. Leave out CI, tests, tooling and refactoring.
- Name a rule as a project's `.vale.ini` names it, such as `Plain.Spelling`.
- A change that breaks a project's `.vale.ini`, such as a renamed rule, opens with `**Breaking:**`.
- A change that makes a rule report text it accepted goes under Changed, because a project's check can start to fail. Fixed holds a rule that reported correct text and a rule that failed to run.
- An entry ends with a link to its pull request, in parentheses: `([#N](https://github.com/jamiebullock/vale-style/pull/N))`.
- Correct or narrow an entry that is inaccurate. Do not add exceptions and qualifications to it.

## Releases

`develop` is the default branch and receives every pull request. `main` holds releases only: it fast-forwards to a commit on `develop` and never receives a pull request or a commit of its own.

A release is a pull request to `develop` titled `chore: release X.Y.Z` that raises `VERSION`, adds the release to `CHANGELOG.md` and names the new version in the README. The maintainer then fast-forwards `main` to that commit. The push to `main` tags the commit `vX.Y.Z`, builds `vale-style.zip` from it and publishes the archive as a GitHub release.

## Licensing of contributions

vale-style is licensed under the zlib licence (see `LICENSE`). By submitting a contribution, whether as a pull request, a patch or a suggestion in an issue, you agree that:

1. **Origin.** You wrote the contribution, or you have the right to submit it under the terms below. If it includes material you did not write, you say so in the pull request and identify its source and licence.
2. **Licence.** Your contribution is licensed under the zlib licence, the same terms as the rest of the project.
3. **Relicensing.** You grant the project's primary copyright holder, Jamie Bullock, permission to relicense your contribution, together with the rest of the project, under any licence approved by the Open Source Initiative. This exists so that the project can move to a different open source licence in future without tracking down every past contributor. It does not permit relicensing under proprietary terms.

You keep the copyright in your contribution. Nothing here is an assignment.

If you cannot agree to these terms, for example because your employer holds the rights to your work, say so in the pull request and we will work out whether the contribution can be accepted.

## Contributions made with AI tools

Contributions produced with the help of a generation tool are accepted on the same terms. You are responsible for them exactly as if you had typed them: you must have reviewed and understood the change, it must meet the standards above, and the origin clause applies to any third-party material the tool may have reproduced. Note in the pull request which tool was used.
