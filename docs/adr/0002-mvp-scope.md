# ADR 0002: MVP platform and feature scope

- Status: Proposed
- Date: 2026-11-02

## Context

Supporting multiple transports and every feature at once creates excessive integration and security risk.

## Decision

Initial target is Android + Linux over the same local network. MVP includes discovery/manual fallback, explicit secure pairing, device management, and bidirectional file transfer. Clipboard and notifications follow after the core is stable. Screen mirroring, USB, Bluetooth, Wi-Fi Direct, cloud relay, Windows and macOS are deferred.

## Consequences

- Narrower and testable first release.
- Future transports require independent feasibility and security reviews.
