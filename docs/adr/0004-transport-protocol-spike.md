# ADR 0004: Transport and protocol implementation spike

- Status: Proposed — decision required before production implementation
- Date: 2026-11-02

## Context

The project needs a reliable local control channel and streaming data path. The exact framing and secure identity model must not be guessed.

## Options to evaluate

- TCP with TLS and length-prefixed messages.
- HTTPS for request/response operations plus WebSocket for control events.
- WebSocket for control and a separate authenticated streaming channel.

## Evaluation criteria

- Mature, maintained library support on Flutter/Linux and Android.
- Authenticated peer identity and certificate/key lifecycle.
- Streaming large files without buffering.
- Cancellation and backpressure.
- Clear protocol versioning and interoperability tests.
- Firewall and network behavior.
- Security reviewability.

## Decision

Do not finalize the wire protocol from this ADR alone. Build a small two-physical-device spike, compare options, select one, and replace this ADR with an accepted decision before implementing production pairing or transfer.
