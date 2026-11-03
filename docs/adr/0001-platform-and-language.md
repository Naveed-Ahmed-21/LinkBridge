# ADR 0001: Initial platform and language strategy

- Status: Proposed
- Date: 2026-11-02

## Context

LinkBridge needs a shared UI and application layer across Android and desktop, while Android-specific capabilities require native APIs.

## Decision

- Flutter/Dart for Android and Linux application UI and shared application logic.
- Kotlin for Android-specific platform integration when required.
- Keep transport and protocol packages platform-independent.
- Defer Rust unless profiling or a concrete native requirement justifies it.

## Consequences

- Faster shared UI development.
- Platform-specific behavior remains possible through narrow adapters.
- Flutter desktop packaging and Android lifecycle behavior still require dedicated testing.
