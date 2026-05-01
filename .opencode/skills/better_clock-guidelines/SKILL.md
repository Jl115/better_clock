---
name: better_clock-guidelines
description: CRITICAL framework rules, coding standards, and commands for Better Clock.
---

# Better Clock Technical Guidelines

## Project Overview

- **Stack:** Flutter (Dart 3) + Material Design 3
- **Architecture Pattern:** Feature-Sliced Design (FSD) inside Clean Architecture

## Core Rules

1. **Structure:** Follow FSD strictly:
   - `features/<feature>/domain/` — Pure Dart entities, repository interfaces, usecases.
   - `features/<feature>/data/` — Datasources, repository implementations.
   - `features/<feature>/presentation/` — BLoC, pages, widgets.
   - `core/` — Shared services, database, DI, utilities.
2. **State Management:** MUST use `flutter_bloc` with `Equatable` on all Bloc states.
3. **Dependency Injection:** MUST use `get_it`. Register everything in `lib/core/di/injection.dart`.
4. **Database:** Use `floor` (SQLite ORM).
   - `@primaryKey` (lowercase) for non-autoGenerate.
   - `@PrimaryKey(autoGenerate: true)` for autoGenerate.
   - Run `build_runner` after entity changes.
5. **Error Handling:** ALWAYS use `Result<T, E>` at repository boundaries. Never throw exceptions from data layer to presentation.
6. **Imports:** Use `package:better_clock/...` or relative. Be careful with `../` levels; verify with `find`.
7. **Localization:** All user-facing text must use `AppLocalizations` (no hardcoded strings).
8. **Equatable:** All Bloc states must extend `Equatable`. Bloc events should be sealed classes.
