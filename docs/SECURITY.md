# LinkBridge Security and Privacy Requirements

## 1. Security objectives

- Only explicitly trusted devices can exchange data.
- All network traffic containing user data is authenticated and encrypted.
- Pairing cannot be silently accepted.
- File transfer cannot write outside an approved destination.
- Secrets and personal content do not leak through logs.
- Users can inspect and revoke trusted devices.

## 2. Threat model

Assume:
- Other devices may exist on the same Wi-Fi network.
- Discovery responses can be spoofed.
- IP addresses and device names can change or be impersonated.
- Networks may be hostile, shared, or misconfigured.
- A transfer may be interrupted or maliciously modified.
- Input metadata may be malformed or intentionally hostile.

Out of scope for initial MVP:
- Protection against a fully compromised endpoint OS.
- Enterprise device management and centralized identity.
- Remote internet relay attacks (no relay in MVP).

## 3. Trust boundaries

- Discovery: untrusted.
- Pairing request: untrusted until verified and approved.
- Authenticated session: trusted only for the capabilities authorized to that peer.
- File metadata and chunks: untrusted input even on an authenticated session.
- Local database: sensitive local state.
- OS key store: preferred secret boundary.

## 4. Mandatory controls

### Pairing
- Explicit user consent.
- Short-lived pairing challenge.
- Verification code/QR with anti-spoofing design.
- Persistent cryptographic peer identity.
- Rate limiting and expiration.
- Revoke device action.

### Network
- No plaintext transmission of file contents, clipboard data, or credentials.
- Authenticate the peer on every new session.
- Reject unpaired peers.
- Bind requests to the authenticated device identity.
- Restrict listening interfaces where feasible and document firewall behavior.
- Apply timeouts, message size limits and rate limits.

### File system
- Never concatenate an untrusted filename into an arbitrary path.
- Normalize and validate destination paths.
- Prevent `..` traversal, absolute-path injection and symlink escape.
- Use user-approved directories/file pickers.
- Write temporary files and atomically finalize.
- Verify size and checksum.
- Enforce quotas and free-space checks.

### Secrets
- Never commit private keys, tokens, signing keys, or credentials.
- Use Android Keystore and an appropriate Linux secret service/keyring.
- Never print secrets in logs or crash reports.
- Provide revocation and local-data reset behavior.

### Privacy
- No cloud account required for MVP.
- Clipboard sync off by default.
- Notification sync off by default.
- Explain Android notification access before directing the user to system settings.
- Do not store clipboard contents or notification bodies in logs.
- Provide clear controls to pause synchronization and remove trusted devices.

## 5. Logging policy

Allowed:
- Event type, timestamp, coarse result, non-sensitive transfer ID.
- Sanitized error category.
- App/protocol version.

Not allowed:
- File contents.
- Clipboard contents.
- Notification bodies.
- Private keys, pairing secrets, access tokens.
- Full sensitive local paths unless explicitly included in a user-generated diagnostic export with warning.

## 6. Security review checklist

Before release:
- [ ] Pairing spoofing and replay cases tested.
- [ ] Unpaired peer access rejected.
- [ ] Authentication failure tested.
- [ ] Message and chunk size limits enforced.
- [ ] File path traversal tests pass.
- [ ] Symlink and overwrite behavior reviewed.
- [ ] Interrupted transfer cleanup tested.
- [ ] Logs inspected for secret leakage.
- [ ] Device revocation invalidates future sessions.
- [ ] Dependencies and licenses reviewed.
- [ ] Threat model updated for new transports/features.

## 7. Security incident response

Document a private reporting channel before public release. Triage security issues separately from ordinary feature requests. Do not publish exploit details before a fix is available.
