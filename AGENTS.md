# AI Coding Agent Instructions — LinkBridge

You are contributing to LinkBridge, an open-source Android + Linux phone-to-PC companion application.

## Read first

Before making changes, inspect:
- `README.md`
- `docs/PRD.md`
- `docs/TRD.md`
- `docs/ARCHITECTURE.md`
- `docs/PROTOCOL.md`
- `docs/SECURITY.md`
- Relevant ADRs in `docs/adr/`

## Non-negotiable rules

1. Do not invent existing files, APIs, tests, or implementation status. Inspect the repository first.
2. Do not implement multiple unrelated features in one task.
3. Do not rewrite architecture or replace dependencies without explaining the reason and asking for approval.
4. Keep UI, application logic, domain logic, infrastructure and native adapters separate.
5. Keep protocol definitions independent of Flutter widgets and platform-specific code.
6. Use typed models; validate all data received from the network.
7. Handle errors explicitly. Never silently swallow exceptions.
8. Do not hardcode secrets, tokens, private keys, signing keys or credentials.
9. Never store private keys in ordinary preferences or source control.
10. Never create an unauthenticated file server or accept privileged commands from unpaired peers.
11. Treat discovery results, device names, IP addresses, filenames and all network payloads as untrusted.
12. Validate file paths and prevent traversal and symlink escape.
13. Stream large files; do not load entire files into memory.
14. Do not claim a feature works unless it has been implemented and tested.
15. Do not claim tests pass unless you actually ran them and report the commands/results.
16. Add tests for new behavior and update documentation.
17. Ask before introducing a new transport, cloud dependency, protocol-breaking change or major dependency.
18. Do not expose clipboard contents, notification bodies, tokens or keys in logs.

## Implementation workflow

For each task:
1. Restate the requested scope and acceptance criteria.
2. Inspect relevant code and docs.
3. Propose a short implementation plan.
4. Implement only the approved scope.
5. Add/update tests.
6. Run formatter, analyzer and relevant tests.
7. Report changed files, commands run, actual results, known limitations and follow-up work.

## Code quality

- Prefer small, cohesive files and clear names.
- Avoid giant widgets and god classes.
- Use dependency injection and interfaces at platform/network boundaries.
- Keep state transitions explicit.
- Avoid premature abstractions, but preserve platform and protocol boundaries.
- Add comments for non-obvious security and concurrency decisions, not for self-explanatory code.

## Product truthfulness

The UI must distinguish implemented, unavailable, disconnected, permission-denied and planned capabilities. Do not create fake live device status or pretend a prototype action performs a real operation.
