# Technical Requirements Document (TRD)

## 1. Technical direction

Build two Flutter applications with shared Dart packages. Use Kotlin only where Android platform APIs require it. Keep transport and protocol logic independent from UI frameworks.

## 2. Supported MVP environment

- Desktop: Linux (initially validate on the project's primary Arch Linux development environment, then test at least one additional mainstream Linux distribution before alpha).
- Mobile: Android. Define and test a minimum Android API level before implementation; do not guess it in code or marketing.
- Toolchain: Flutter stable pinned by the repository, Dart bundled with Flutter, Android SDK/JDK versions documented in the development environment.

## 3. Proposed stack

| Layer | Choice | Notes |
|---|---|---|
| UI | Flutter | Separate desktop and mobile app entry points |
| State management | Riverpod | Keep providers scoped by feature |
| Routing | GoRouter | Route guards for onboarding/pairing where useful |
| Shared models | Dart | Typed, validated domain models |
| Protocol | Dart package | Versioned message envelope and schemas |
| Android platform | Kotlin + Flutter platform channels/Pigeon | Permissions, lifecycle, notification listener later |
| Discovery | mDNS/DNS-SD | Discovery only; never trust discovered peers |
| Transport | TCP/TLS or HTTPS + WebSocket | Select exact implementation after a prototype and security review |
| Storage | SQLite abstraction | Store non-secret app data; keys use OS secure storage |
| Logging | Structured local logging | Redact credentials and personal content |

Pin package versions in `pubspec.lock`. New dependencies require a reason, license check, maintenance check, and review.

## 4. Suggested repository structure

```text
apps/
  desktop/
    lib/
      app/
      core/
      features/
      platform/
    linux/
  mobile/
    lib/
      app/
      core/
      features/
      platform/
    android/
packages/
  linkbridge_models/
  linkbridge_protocol/
  linkbridge_core/
  linkbridge_storage/
native/
  android/
  linux/
docs/
  adr/
```

## 5. Architecture boundaries

- Presentation: Flutter widgets, routes, themes, view models/providers.
- Application: use cases and feature orchestration.
- Domain: entities, value objects, interfaces, business rules.
- Infrastructure: network, discovery, storage, platform adapters.
- Native adapters: Kotlin/OS-specific behavior behind narrow interfaces.

Do not put socket handling, file writes, cryptography, or platform permission logic inside widgets.

## 6. Core modules

### Device discovery
- Advertise only the minimum service metadata needed.
- Discover peers on supported LAN interfaces.
- Handle multiple interfaces and changing IP addresses.
- Provide manual IP/port or pairing-code fallback.
- Discovery results remain untrusted until pairing succeeds.

### Pairing and identity
- Establish a short-lived pairing session.
- Display a verification code or QR-derived verification value.
- Require explicit user approval.
- Bind the approved peer to a persistent cryptographic identity.
- Revoke trust when the user removes a device.
- Never use a device name or IP address as identity.

### Connection manager
- Own connection state transitions.
- Prevent duplicate concurrent sessions unless explicitly supported.
- Handle timeout, disconnect, reconnect, and cancellation.
- Expose typed events to the UI.
- Avoid silently changing to an unverified peer.

### File transfer
- Transfer metadata and content separately.
- Stream data; do not load entire large files into memory.
- Validate size, name, type where relevant, destination and available storage.
- Write to a temporary file and atomically finalize after integrity verification.
- Enforce safe path handling and prevent traversal.
- Support cancellation and cleanup of partial files.
- Use checksums for integrity verification.

### Clipboard (P1)
- Explicit opt-in on both endpoints.
- Prevent echo loops using origin identifiers and content/version metadata.
- Define maximum payload size and supported content types.
- Do not sync clipboard history by default.

### Notifications (P1)
- Android notification-listener access is sensitive and must be explicitly enabled by the user.
- Explain what is captured and where it is sent.
- Provide per-app controls and pause/disable controls.
- Do not imply Android can grant this permission silently.

### Screen mirroring (P2)
- Investigate scrcpy integration rather than writing a streaming engine initially.
- Review dependency licensing, installation, process management, permissions, and supported Linux environments.
- Do not display working controls until the integration exists.

## 7. Protocol requirements

See [PROTOCOL.md](PROTOCOL.md). All messages must be typed, versioned, bounded in size, validated, and authenticated after pairing.

## 8. Error handling

Use stable error categories, for example:
- discovery_unavailable
- peer_unreachable
- pairing_expired
- pairing_rejected
- authentication_failed
- protocol_version_unsupported
- permission_denied
- storage_unavailable
- insufficient_space
- transfer_cancelled
- integrity_check_failed
- connection_lost
- internal_error

User-facing messages must explain what happened and the next useful action. Never show stack traces or secrets in ordinary UI.

## 9. Quality gates

Before merging a feature:
- `dart format` passes.
- `flutter analyze` passes for affected apps/packages.
- Unit and widget tests pass.
- Protocol tests pass where applicable.
- Integration/manual tests are recorded.
- Security-sensitive changes receive an explicit review.
- Documentation and sample configuration are updated.
