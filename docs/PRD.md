# Product Requirements Document (PRD)

## 1. Summary

LinkBridge connects an Android phone and a Linux desktop so users can move information between them without relying on a cloud account. The first release prioritizes secure local pairing, file transfer, device status, and a dependable connection lifecycle.

## 2. Problem

Moving files and small pieces of information between a phone and computer is often fragmented across cables, messaging apps, cloud services, and vendor-specific utilities. Users need a straightforward local connection with clear privacy and connection status.

## 3. Target users

- People who regularly move files between Android and Linux.
- Developers who want a practical phone/desktop companion.
- Privacy-conscious users who prefer local-network transfers.
- Open-source users who value inspectable behavior and self-hosted/local operation.

## 4. Product principles

1. Local-first: core MVP functions work on the local network without a cloud account.
2. Consent-first: pairing and sensitive permissions require explicit user action.
3. Honest status: the UI must distinguish available, connected, syncing, failed, and unsupported states.
4. Secure by default: no unauthenticated file server or silent pairing.
5. Incremental delivery: ship a narrow, tested vertical slice before adding transports and advanced features.
6. Cross-platform boundaries: isolate platform-specific code behind interfaces.

## 5. MVP scope

### P0 — required for first usable prototype

- Android and Linux app launch and basic navigation.
- Local device discovery on the same LAN.
- Manual connection fallback if discovery fails.
- User-approved pairing with identity verification.
- Authenticated encrypted session after pairing.
- Connection status and paired-device management.
- Send a file from desktop to Android.
- Send a file from Android to desktop.
- Transfer progress, cancellation, failure feedback, and history.
- Basic local diagnostics without exposing secrets.

### P1 — after P0 is stable

- Two-way clipboard synchronization with explicit opt-in.
- Better transfer queue and duplicate-file handling.
- Reconnection behavior.
- Notification synchronization, subject to Android notification-listener permission and desktop integration.
- Settings for privacy, transfer destination, and connection behavior.

### P2 — later exploration

- Screen mirroring using an established integration such as scrcpy, after feasibility and licensing review.
- Bluetooth, Wi-Fi Direct, and USB transports.
- Windows and macOS desktop support.
- Optional remote connectivity or relay, only after a separate threat model.

## 6. Out of scope for MVP

- Remote control of Android.
- Cloud user accounts.
- Cloud backup.
- Guaranteed background transfer when Android or Linux terminates the app/service.
- Seamless switching among all transport types.
- Bluetooth as a high-throughput file-transfer path.
- Custom screen-mirroring engine.

## 7. Core user journeys

### Journey A: first pairing

1. User opens desktop app.
2. Desktop starts LAN discovery and displays pairing options.
3. User opens Android app and discovers or scans the desktop.
4. Both devices display matching verification information.
5. User explicitly approves on the required devices.
6. A trusted device identity is stored securely.
7. Both apps show the paired state.

### Journey B: transfer desktop to phone

1. User selects a paired phone.
2. User chooses files or drags files into the transfer area.
3. App validates file access and destination.
4. User confirms the transfer.
5. Transfer starts over an authenticated session.
6. Progress, speed where measurable, and cancellation are displayed.
7. Receiver validates and commits the file safely.
8. Both devices show completion or actionable failure.

### Journey C: transfer phone to desktop

Same guarantees as Journey B, with the phone selecting content through Android's system picker and the desktop choosing or confirming a destination.

### Journey D: clipboard sync (P1)

1. User explicitly enables clipboard sync on both sides.
2. A clipboard update is detected only within supported platform constraints.
3. Content is sent to the paired device.
4. UI indicates synchronization status.
5. User can pause sync and clear local history.

## 8. Functional requirements

| ID | Requirement | Priority | Acceptance criteria |
|---|---|---:|---|
| FR-001 | Discover peers on local network | P0 | A device can find a compatible peer on the same LAN, with manual fallback |
| FR-002 | Pair devices with explicit consent | P0 | No device becomes trusted without user approval and verification |
| FR-003 | Authenticate paired sessions | P0 | Unpaired peers cannot access feature endpoints |
| FR-004 | Encrypt data in transit | P0 | File and control traffic use an authenticated encrypted channel |
| FR-005 | Show connection lifecycle | P0 | UI distinguishes discovering, pairing, connected, reconnecting, disconnected, and error |
| FR-006 | Transfer files both directions | P0 | Valid files arrive intact and are saved only to user-approved locations |
| FR-007 | Show transfer progress | P0 | Progress is based on bytes transferred; cancel and failure are represented |
| FR-008 | Manage trusted devices | P0 | User can inspect, rename, disconnect, and revoke a paired device |
| FR-009 | Clipboard synchronization | P1 | Sync is opt-in, can be paused, and does not loop updates indefinitely |
| FR-010 | Notification synchronization | P1 | Requires clear permission explanation and explicit Android notification access |
| FR-011 | Export diagnostics | P1 | Export excludes secrets, tokens, private keys, and file contents |
| FR-012 | Screen mirroring integration | P2 | Feasibility, permissions, UX, and dependency review completed before implementation |

## 9. Non-functional requirements

- Security: encrypted, authenticated communication; secure key storage; input and path validation.
- Reliability: interrupted transfers fail safely and do not silently report success.
- Performance: transfer throughput should be measured on representative devices; do not promise a target until benchmarked.
- Accessibility: keyboard navigation, readable contrast, semantic labels, and scalable layouts.
- Privacy: no cloud dependency for MVP; clear data-retention behavior.
- Maintainability: feature modules, typed protocol messages, tests, and documented platform boundaries.
- Observability: actionable local logs with redaction.

## 10. Success criteria

The MVP is ready for a limited alpha when:
- A clean install on Linux and Android can pair without developer tools.
- Pairing requires and records explicit consent.
- Both transfer directions work on a normal home/office LAN.
- File hashes match after transfer.
- Cancel, disconnect, and retry paths are tested.
- No unauthenticated peer can upload, download, or invoke privileged actions.
- Setup, limitations, and troubleshooting are documented.

## 11. Risks and assumptions

- LAN client isolation, guest Wi-Fi, VPNs, and firewalls may block discovery or connections.
- Android background execution and file access are permission- and OS-version-dependent.
- Linux firewall and network-interface behavior varies by distribution.
- mDNS discovery is not authentication.
- Android and Linux may have different lifecycle and storage semantics.
- Screen mirroring and notification sync need native/platform-specific work.
