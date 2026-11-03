# ADR 0003: Local-first, peer-to-peer MVP

- Status: Proposed
- Date: 2026-11-02

## Context

The initial product should connect a user's devices without requiring a cloud account or hosted backend.

## Decision

Use local-network peer-to-peer communication for the MVP. Discovery is a convenience, not an authorization mechanism. Pairing establishes trust; each session authenticates the peer and encrypts data.

## Consequences

- No backend or cloud account required for core MVP.
- Guest Wi-Fi isolation, VPNs, firewalls and network changes can affect connectivity.
- Remote connectivity is explicitly deferred.
