# LinkBridge Communication Protocol (Draft)

**Status:** Draft for prototype. This is not a finalized wire standard.

## 1. Requirements

- Versioned and backward-compatible where practical.
- Typed messages with strict validation.
- Authenticated and encrypted after pairing.
- Explicit limits on message and file sizes.
- No executable payloads or arbitrary remote commands.
- Separate control messages from bulk file content.
- Unknown message types must fail safely.

## 2. Transport proposal

Initial prototype: local TCP-based secure session, with a small WebSocket/control channel or a single framed stream. Choose one framing strategy during the first network spike and record it in an ADR.

Do not send sensitive content over plaintext HTTP/WebSocket. Do not assume a private Wi-Fi network is trusted.

## 3. Message envelope

Illustrative JSON envelope for control messages:

```json
{
  "protocol": "linkbridge",
  "version": 1,
  "message_id": "uuid",
  "request_id": "uuid-or-null",
  "type": "connection.hello",
  "sender_device_id": "stable-device-id",
  "timestamp": "ISO-8601",
  "payload": {}
}
```

Requirements:
- `version` is an integer.
- IDs are generated securely and validated.
- Timestamp is informational; do not rely on it for authorization.
- Payload schema is specific to `type`.
- Enforce maximum envelope size before parsing.
- Reject malformed, oversized, or unsupported messages.

## 4. Initial message types

| Type | Direction | Purpose |
|---|---|---|
| `connection.hello` | Both | Begin protocol negotiation |
| `connection.capabilities` | Both | Exchange supported feature/version information |
| `pairing.request` | Initiator to peer | Request a pairing ceremony |
| `pairing.challenge` | Peer to initiator | Return challenge/verification data |
| `pairing.approve` | User-approved endpoint | Record consent |
| `pairing.reject` | Either | Reject pairing |
| `session.ready` | Both | Confirm authenticated session |
| `transfer.offer` | Sender to receiver | Offer file metadata |
| `transfer.accept` | Receiver to sender | Accept transfer |
| `transfer.reject` | Receiver to sender | Reject transfer |
| `transfer.chunk` | Sender to receiver | Stream a bounded file chunk |
| `transfer.progress` | Receiver to sender | Acknowledge progress |
| `transfer.complete` | Receiver to sender | Confirm integrity-checked completion |
| `transfer.cancel` | Either | Cancel transfer |
| `error` | Either | Return stable error category |

## 5. Pairing security

The exact key agreement and certificate/fingerprint scheme must be selected and reviewed before implementation. Do not invent cryptography or implement custom primitives. Prefer established platform cryptographic libraries and a documented protocol.

Pairing must:
1. Use a short-lived challenge.
2. Bind the session to the peer's cryptographic identity.
3. Display a verification value to users.
4. Require explicit approval.
5. Persist trust only after successful verification.
6. Expire pending pairing sessions.
7. Allow trust revocation.

## 6. File transfer metadata

Example conceptual fields:
- transfer_id
- filename (display metadata only; never trust as a path)
- size_bytes
- media_type (advisory only)
- checksum_algorithm
- checksum
- chunk_size
- destination policy

Validate all fields. Enforce configured maximum file size, chunk size, concurrent transfers and timeouts.

## 7. File transfer lifecycle

```text
offered -> accepted -> transferring -> verifying -> completed
                 \-> rejected
transferring -> cancelled
transferring -> failed
```

Only report `completed` after the receiver has finalized the file and verified integrity.

## 8. Chunking and integrity

- Stream bounded chunks.
- Include transfer ID and sequence/offset.
- Reject out-of-order or duplicate chunks unless the resume protocol explicitly supports them.
- Compute and verify a whole-file cryptographic hash.
- Write to a temporary destination and atomically rename after verification.
- Clean up partial files after cancellation/failure according to documented retention rules.

## 9. Version negotiation

Peers exchange supported protocol versions and capabilities. If no mutually supported version exists, fail with `protocol_version_unsupported`; do not silently downgrade security.

## 10. Open decisions

- Exact framing: length-prefixed binary, WebSocket frames, or another reviewed option.
- TLS certificate provisioning and peer identity binding.
- Chunk size and concurrency defaults.
- Transfer resume semantics.
- Discovery service record and port allocation.
- Protocol schema format and code generation strategy.

Record decisions in `docs/adr/` before stabilizing the protocol.
