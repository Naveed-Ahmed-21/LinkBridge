# LinkBridge Architecture

## 1. Overview

LinkBridge uses a client application on each endpoint. Both devices can initiate transfers and control messages. The architecture is peer-to-peer on the local network for the MVP; there is no required cloud backend.

```text
+----------------------+                 +----------------------+
| Linux Desktop App    |                 | Android App          |
| Flutter UI           |                 | Flutter UI           |
| Feature providers    |                 | Feature providers    |
| Application use cases|                 | Application use cases|
| Domain interfaces    |                 | Domain interfaces    |
| Network adapters     |<-- LAN/TLS ---->| Network adapters     |
| SQLite / secure store|                 | SQLite / Keystore    |
+----------------------+                 +----------------------+
```

## 2. Logical layers

### Presentation
Screens, widgets, navigation, state and user feedback. No direct socket or filesystem operations in widgets.

### Application
Use cases such as `DiscoverDevices`, `StartPairing`, `ApprovePairing`, `SendFile`, `ReceiveFile`, `DisconnectDevice`.

### Domain
Device identity, connection state, transfer state, protocol contracts, validation and business rules.

### Infrastructure
mDNS discovery, network sockets, TLS, file streaming, SQLite, logging and platform integrations.

### Platform adapters
Kotlin Android APIs and Linux-specific integration. Keep them behind Dart interfaces.

## 3. Key interfaces

Illustrative interfaces; refine through tests before treating them as stable public APIs.

```dart
abstract interface class PeerDiscovery {
  Stream<DiscoveredPeer> discover();
  Future<void> stop();
}

abstract interface class PairingService {
  Future<PairingSession> beginPairing(DiscoveredPeer peer);
  Future<TrustedDevice> approvePairing(PairingSession session);
  Future<void> revokeDevice(DeviceId id);
}

abstract interface class LinkTransport {
  Future<void> connect(Endpoint endpoint, Credentials credentials);
  Future<void> disconnect();
  Stream<ProtocolMessage> get incomingMessages;
  Future<void> send(ProtocolMessage message);
}

abstract interface class FileTransferService {
  Stream<TransferProgress> sendFile(DeviceId device, LocalFile file);
  Future<void> cancelTransfer(TransferId id);
}
```

## 4. Connection state machine

```text
idle
  -> discovering
  -> pairing
  -> authenticating
  -> connected
  -> reconnecting
  -> disconnected

Any active state may transition to error with a typed reason.
A revoked or rejected peer must not transition to connected.
```

State transitions must be explicit and tested. Avoid deriving connection status from a socket-exists boolean alone.

## 5. Discovery vs trust

mDNS/BLE advertisements and IP addresses are hints for finding peers, not proof of identity. A discovered peer is untrusted until a pairing ceremony completes and its cryptographic identity is stored.

## 6. Data flow

### Control plane
Small typed messages: handshake, capability negotiation, transfer commands, acknowledgements, cancellation and status.

### Data plane
Streaming file bytes over an authenticated encrypted channel. Keep control and file payload framing unambiguous.

## 7. Storage

Store:
- User preferences.
- Trusted device public identity/fingerprint and non-secret metadata.
- Transfer metadata and status.
- Redacted diagnostics.

Do not store:
- Plaintext private keys in ordinary preferences or source files.
- Authentication tokens in logs.
- File contents or clipboard content in diagnostics.

Use platform secure storage for private keys and secrets. On Android use Android Keystore-backed storage. On Linux select a supported secret service/keyring integration and define behavior when unavailable.

## 8. Platform boundary

Flutter owns shared UI and most application logic. Kotlin owns Android-specific APIs that cannot be reliably implemented in Dart, such as notification listener service and certain lifecycle/permission integrations. Linux-specific functionality belongs behind platform interfaces.

## 9. Future transports

Define transport abstractions, but do not implement Bluetooth, Wi-Fi Direct, or USB before the Wi-Fi MVP is stable. Each future transport requires an ADR, interoperability test, threat review, and clear UX for its limitations.
