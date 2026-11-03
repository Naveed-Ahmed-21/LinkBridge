# Testing Strategy

## 1. Testing layers

### Unit tests
- Domain models and validation.
- Connection state machine.
- Protocol serialization/deserialization.
- Transfer state transitions.
- Filename/path validation.
- Retry and timeout policies.

### Widget tests
- Onboarding and pairing screens.
- Dashboard states.
- Device cards.
- Transfer queue and progress.
- Error, empty and permission states.
- Settings controls.

### Integration tests
- Discovery and manual connection.
- Pairing lifecycle.
- Authenticated session establishment.
- File transfer in both directions.
- Cancellation and interruption.
- Device revocation.

### Security tests
- Unpaired peer access.
- Invalid/replayed pairing challenge.
- Malformed and oversized messages.
- Path traversal and symlink cases.
- Duplicate/partial chunk handling.
- Secret redaction in logs.

### Manual real-device tests
- Physical Android device + Linux desktop.
- Different Wi-Fi router configurations.
- VPN/firewall behavior.
- Sleep/wake and app lifecycle.
- Low battery and low storage.
- App upgrade and trusted-device persistence.

## 2. Transfer test matrix

| Scenario | Expected result |
|---|---|
| Small text file | Exact content and matching hash |
| Large file | Streaming without loading entire file into memory |
| Zero-byte file | Valid completion |
| Duplicate filename | Explicit configured behavior |
| User cancels | Transfer stops and partial file is cleaned or clearly retained |
| Wi-Fi drops | Failed/interrupted state; never false success |
| Receiver runs out of space | Actionable error and cleanup |
| Invalid filename | Rejected safely |
| Modified chunk | Integrity verification fails |
| Unpaired sender | Request rejected |

## 3. Release gates

- Format and static analysis clean.
- Automated tests pass.
- Manual test evidence recorded.
- No critical/high security issue unresolved.
- Privacy and permission copy reviewed.
- Known limitations documented.
- Version and build metadata reproducible.
