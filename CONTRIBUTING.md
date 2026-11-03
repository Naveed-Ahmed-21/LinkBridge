# Contributing to LinkBridge

Thanks for considering a contribution.

## Before starting

- Read `README.md`, `docs/ARCHITECTURE.md`, `docs/SECURITY.md` and the relevant feature requirements.
- Search existing issues and pull requests.
- For substantial design or dependency changes, open an issue or ADR first.

## Workflow

1. Create a focused branch: `feature/<short-name>` or `fix/<short-name>`.
2. Keep changes limited to one coherent feature.
3. Add or update tests.
4. Run formatting, analysis and tests.
5. Update docs and changelog/release notes where relevant.
6. Open a pull request with scope, rationale, tests and screenshots where useful.

## Code expectations

- Follow Dart/Flutter conventions.
- Keep UI, application logic, domain rules and infrastructure separate.
- Use typed models and explicit error handling.
- Avoid hardcoded secrets and personal data.
- Do not add dependencies without a clear need and license/maintenance review.
- Never claim a test passed unless it was run.

## Security

Do not include credentials, private keys, signing material, clipboard contents, notification bodies, or sensitive user data in issues, logs, screenshots or pull requests.

Report suspected vulnerabilities privately using the security contact published by the project maintainers. Until a private reporting channel exists, do not publish exploit details.
