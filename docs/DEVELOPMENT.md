# Development Setup

## 1. Scope

This guide describes the intended development setup for the Android + Linux MVP. Exact Flutter, Dart, Android SDK, JDK, Gradle and plugin versions must be pinned after the first clean build on the project machine.

## 2. Prerequisites

- Git.
- Flutter stable SDK (version pinned by the repository).
- Android SDK and a compatible JDK.
- Linux desktop build dependencies required by the selected Flutter version.
- Android device or emulator.
- A second device on the same LAN for real network testing.

Do not assume emulator-to-host networking behaves like two physical devices.

## 3. Initial repository setup

```bash
git clone <repository-url>
cd linkbridge

flutter doctor -v
flutter --version
dart --version
```

Create the app shells only after agreeing the repository structure:

```bash
mkdir -p apps packages docs/adr native
```

Suggested initial generation commands:

```bash
flutter create --platforms=linux apps/desktop
flutter create --platforms=android apps/mobile
```

Review generated files before committing. Do not overwrite existing application files blindly.

## 4. Development checks

Run from the relevant Flutter app/package directory:

```bash
dart format .
flutter analyze
flutter test
```

For Android native tests/builds, use the Gradle wrapper committed with the Android project:

```bash
cd apps/mobile/android
./gradlew test
```

Build commands depend on the selected target and Flutter version. Record verified commands in CI once the project exists.

## 5. Environment and secrets

- Never commit `.env` files containing secrets, private keys, signing keys, or local credentials.
- Commit safe example configuration only.
- Keep Android signing material outside Git.
- Use local secure storage for development credentials where possible.
- Add generated build outputs and local IDE state to `.gitignore`.

## 6. Device testing

Test at minimum:
- Linux desktop + physical Android phone on the same Wi-Fi.
- Different Wi-Fi networks or guest/client isolation failure.
- VPN enabled/disabled.
- Desktop sleep/wake.
- Android app background/foreground.
- Wi-Fi disconnect/reconnect.
- Large file, zero-byte file, duplicate name, cancellation and low storage.
- Permission denied and permission later granted.

## 7. Troubleshooting

### Devices are not discovered
- Confirm both devices are on the same LAN.
- Check guest network/client isolation.
- Check Linux firewall and VPN.
- Use manual connection fallback.
- Do not disable firewall permanently as a workaround.

### Connection works but transfer fails
- Check authenticated session state.
- Check destination permission and free space.
- Inspect redacted logs.
- Verify chunk and size limits.

### Android background behavior differs
- Review Android OS version, battery optimization, foreground-service requirements and permission state.
- Do not promise continuous background behavior without device-specific testing.
