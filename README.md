# LinkBridge

**Your phone. Your computer. One connected experience.**

LinkBridge is an open-source companion application that connects Android phones to desktop computers. The initial development target is **Android + Linux**, with a modular architecture intended to support Windows and macOS later.

## Project status

Pre-implementation documentation baseline. No feature should be described as implemented until it exists, is tested, and is documented as working.

## Product goals

- Pair a user's Android phone and Linux desktop securely.
- Transfer files between paired devices.
- Synchronize clipboard content with explicit user control.
- Provide a reliable connection and device-management experience.
- Add notification synchronization and screen mirroring in later milestones.

## Initial platform scope

| Component | Initial target | Technology |
|---|---|---|
| Desktop application | Linux | Flutter desktop |
| Mobile application | Android | Flutter UI + Kotlin platform integration |
| Shared application logic | Android + Linux | Dart packages |
| Local transport | Same Wi-Fi/LAN | TCP/HTTP + WebSocket, subject to protocol specification |
| Discovery | Same LAN | mDNS/DNS-SD; manual address/code fallback |
| Local persistence | Both apps | SQLite or platform-appropriate local database |

Bluetooth, Wi-Fi Direct, USB, cloud relay, Windows, and macOS are **not MVP commitments**. They require separate technical spikes and architecture decisions.

## Documentation

- [Product requirements](docs/PRD.md)
- [Technical requirements](docs/TRD.md)
- [Architecture](docs/ARCHITECTURE.md)
- [Communication protocol](docs/PROTOCOL.md)
- [Security model](docs/SECURITY.md)
- [Development setup](docs/DEVELOPMENT.md)
- [Implementation roadmap](docs/ROADMAP.md)
- [Testing strategy](docs/TESTING.md)
- [Contributing](CONTRIBUTING.md)
- [AI coding-agent instructions](AGENTS.md)
- [Architecture decision records](docs/adr/)

## Repository layout

```text
linkbridge/
├── apps/
│   ├── desktop/                 # Flutter Linux desktop app
│   └── mobile/                  # Flutter Android app
├── packages/
│   ├── linkbridge_models/       # Shared typed models
│   ├── linkbridge_protocol/     # Versioned protocol messages
│   ├── linkbridge_core/         # Connection and feature orchestration
│   └── linkbridge_storage/      # Persistence abstractions
├── native/
│   ├── android/                 # Kotlin services and platform adapters
│   └── linux/                   # Linux-specific adapters, if needed
├── docs/
│   └── adr/
├── .github/workflows/
├── AGENTS.md
├── CONTRIBUTING.md
└── README.md
```

## Non-goals for the first milestone

- Internet-based remote connectivity.
- Cloud accounts or cloud storage.
- Full remote phone control.
- Building a screen-mirroring engine from scratch.
- Supporting every transport before a stable Wi-Fi implementation exists.

## License

Choose and add an explicit open-source license before publishing code. Do not assume that a repository is open source merely because it is public.
