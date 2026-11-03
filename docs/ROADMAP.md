# LinkBridge Implementation Roadmap

## Delivery principle

Build a working vertical slice in small milestones. Do not attempt all transports and all features in parallel.

## Phase 0 — Project foundation

Deliver:
- Repository structure.
- Flutter desktop and Android shells.
- Shared package boundaries.
- Design system and navigation skeleton.
- CI for formatting, analysis and tests.
- Architecture decision records for initial choices.

Exit criteria:
- Both apps launch on target devices.
- CI runs on every pull request.
- No feature logic is embedded in page widgets.

## Phase 1 — Protocol and local networking spike

Deliver:
- Typed protocol envelope.
- LAN listener/client proof of concept.
- Manual endpoint connection.
- mDNS discovery experiment.
- Message framing and version negotiation.

Exit criteria:
- Two physical devices exchange bounded test messages.
- Discovery failure has a documented manual fallback.
- Protocol and transport choice recorded in ADR.

## Phase 2 — Secure pairing

Deliver:
- Pairing challenge.
- User-visible verification.
- Explicit approval.
- Secure key storage.
- Trusted device list and revocation.
- Authenticated encrypted session.

Exit criteria:
- Unpaired peer cannot access protected endpoints.
- Replay, rejection, expiry and revocation tests pass.
- Security review completed.

## Phase 3 — File transfer vertical slice

Deliver:
- Desktop-to-Android transfer.
- Android-to-desktop transfer.
- File picker and destination selection.
- Streaming and progress.
- Cancellation and cleanup.
- Hash verification.
- Transfer history.

Exit criteria:
- Real-device transfers succeed in both directions.
- Hashes match.
- Disconnect and low-storage cases fail safely.
- Path traversal tests pass.

## Phase 4 — MVP polish

Deliver:
- Reconnection UX.
- Empty/loading/error states.
- Device details and rename.
- Settings and diagnostics.
- Installer/package exploration for Linux.
- User documentation and privacy review.

Exit criteria:
- A new user can install, pair and transfer without developer assistance.
- Known limitations are documented.

## Phase 5 — P1 synchronization

Deliver in separate increments:
1. Clipboard sync.
2. Notification sync.
3. Per-feature permission and privacy controls.

Each increment requires its own threat review and platform tests.

## Phase 6 — Advanced capabilities

Investigate screen mirroring integration, then additional transports (USB, Wi-Fi Direct, Bluetooth), then other desktop platforms. Each is a separate feasibility project, not an assumed extension.

## Recommended first two weeks

Week 1:
- Create repository and app shells.
- Set up CI and design system.
- Define shared models and protocol draft.
- Prove a local network message exchange.

Week 2:
- Complete pairing UX prototype.
- Implement a reviewed pairing proof of concept.
- Test on two physical devices.
- Record protocol, security and platform limitations.

A two-week target is a prototype, not a production-ready secure product.
