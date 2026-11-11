# Dependencies

The package needs [Vale](https://vale.sh) and nothing else on the machine. One component is bundled in the repository and one is fetched by `vale sync`. Neither is covered by `LICENSE`.

## Bundled

### en_GB Hunspell dictionary

- Location: `styles/config/dictionaries/`
- Version: 4.0.1 (2025-04-01)
- Revision: [`e7f163f`](https://github.com/LibreOffice/dictionaries/tree/e7f163feb2beaf526135132d8716e68e19d2716e/en) of the LibreOffice dictionaries, directory `en/`
- Licence: LGPL. The dictionary's README and the head of the affix file say LGPL without a version. The phonetic rules in `en_GB.aff` state version 2.1, and `LGPL-2.1.txt` is that text
- Copyright: Kevin Atkinson, David Bartlett, Brian Kelk, Andrew Brown and Marco A.G. Pinto. The phonetic rules have their own notice in `en_GB.aff`, dated 2000
- Used for: `Plain.Spelling`
- Platforms: all

## Fetched by `vale sync`

### ai-tells

- Source: [tbhb/vale-ai-tells](https://github.com/tbhb/vale-ai-tells), release `v1.37.0`
- Version: 1.37.0
- Revision: tag object `ac0e5be57a1df75e569540392e19d54c6f860429`
- Licence: MIT
- Copyright: Copyright (c) 2025-2026 Tony Burns
- Used for: `ConsequenceClause`, `BareHolds`, `NegatedObject`, `UniversalSubject` and `SemicolonUsage` on Markdown and commit messages
- Platforms: all

## Tools

### Vale

- Source: [vale-cli/vale](https://github.com/vale-cli/vale)
- Version: 3.26.0
- Revision: `e2d4374b1c66c8a1dd6d912bebc135040d8833fa`
- Licence: MIT
- Copyright: Copyright (c) 2016 Joseph Kato
- Used for: running the rules and their tests. The package does not distribute it
- Platforms: all

## Obligations

- **en_GB dictionary (LGPL).** `en_GB.aff`, `en_GB.dic` and `README_en_GB.txt` are the upstream files, unmodified, and `LGPL-2.1.txt` travels with them in the repository and in each release archive. A copy that changes them stays under the LGPL and says what changed.
- **ai-tells (MIT).** The repository does not contain it. `vale sync` downloads it from its own release, with its licence, onto the machine that runs the check.
