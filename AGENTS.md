# Better Clock — Agent Operating Notes

## Quick Start
- Run `flutter pub get` after any `pubspec.yaml` change.
- Run `flutter analyze` before committing to ensure zero issues.
- Native build test: `flutter build macos --debug`.

## Conventions
- **Architecture**: Feature-Sliced Design (FSD) inside Clean Architecture layers.
- **Imports**: Use `package:better_clock/...` or relative. Be careful with `../` levels; verify with `find`.
- **DI**: Register everything in `lib/core/di/injection.dart`. Use `getIt`.
- **Database**: Floor entities use `@primaryKey` (lowercase `p`) for non-autoGenerate, `@PrimaryKey(autoGenerate: true)` for autoGenerate. Run `build_runner` after entity changes.
- **Error Handling**: Always use `Result<T, E>` at repository boundaries. Never throw exceptions from data layer to presentation.
- **State**: Use `Equatable` for all `Bloc` states.

## Phase Reference
See `PHASES.md` for complete roadmap and completed work log.
See `ARCHITECTURE.md` for live directory tree.
