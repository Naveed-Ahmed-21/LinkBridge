# First Implementation Milestone — Repository Foundation

## Goal

Create a reproducible repository with Linux desktop and Android Flutter app shells, shared package boundaries, coding-agent rules, and automated quality checks.

## Scope

- Git repository initialized on `main`.
- Documentation committed.
- Root `.gitignore` and `.editorconfig`.
- VS Code Dart/Flutter recommendations.
- Flutter Linux desktop app shell.
- Flutter Android app shell.
- Four shared Dart package shells.
- GitHub Actions CI for format, analysis and tests.
- Bootstrap and verification scripts.

## Not in scope

- UI implementation beyond generated Flutter starter screens.
- Network discovery.
- Pairing.
- Cryptography implementation.
- File transfer.
- Bluetooth, USB, Wi-Fi Direct or cloud services.

## Acceptance criteria

- [ ] `flutter doctor -v` has no blocking issue for the intended targets.
- [ ] `./scripts/bootstrap.sh` completes.
- [ ] Desktop app runs on Linux.
- [ ] Android app runs on a physical Android device or emulator.
- [ ] Every app/package passes format, analyze and test.
- [ ] GitHub Actions passes on the initial push.
- [ ] No signing keys, secrets, local SDK paths or generated build files are committed.
- [ ] `AGENTS.md` is present at repository root.

## Developer commands

```bash
chmod +x scripts/bootstrap.sh scripts/verify.sh
./scripts/bootstrap.sh
./scripts/verify.sh
```

Run desktop app:

```bash
cd apps/desktop
flutter run -d linux
```

List Android targets and run:

```bash
flutter devices
cd apps/mobile
flutter run -d <android-device-id>
```

## Completion evidence

Record Flutter/Dart versions, `flutter doctor -v` summary, target device, verification output, and CI run URL in the milestone pull request or project notes.
