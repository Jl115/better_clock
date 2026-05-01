---
name: better_clock-architecture
description: A living map of the Better Clock project structure, modules, and data flow. Read this to navigate. UPDATE THIS when adding files/modules.
---

# Better Clock Architecture Map

This file documents the high-level structure of the application.

## High-Level Directory Tree

```
lib/
├── main.dart                          # Entry point, initializes services, MaterialApp.router
├── router.dart                        # go_router with ShellRoute + NavigationBar
├── core/
│   ├── di/
│   │   └── injection.dart              # get_it registrations for services, DB, repos, usecases
│   ├── database/
│   │   ├── app_database.dart           # Floor abstract DB
│   │   ├── app_database.g.dart        # Generated Floor code
│   │   ├── dao/
│   │   │   ├── alarm_dao.dart
│   │   │   ├── customization_dao.dart
│   │   │   └── stopwatch_dao.dart
│   │   └── entities/
│   │       ├── alarm_entity.dart
│   │       ├── customization_entity.dart
│   │       └── stopwatch_entity.dart   # StopwatchSessionEntity, LapEntity
│   ├── services/
│   │   ├── audio_service.dart         # Placeholder for audioplayers
│   │   ├── notification_service.dart # Placeholder for flutter_local_notifications
│   │   ├── permission_service.dart    # Permission handler wrapper
│   │   └── time_ticker_service.dart   # Broadcasts DateTime every 10ms
│   └── utils/
│       └── result.dart                # Monadic Result<T,E>, AppError hierarchy, DurationFormatting
├── features/
│   ├── alarm/
│   │   └── presentation/
│   │       └── pages/
│   │           └── alarm_list_page.dart  # Placeholder
│   ├── customization/
│   │   ├── data/
│   │   │   └── repositories/
│   │   │       └── customization_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── stopwatch_customization.dart
│   │   │   ├── repositories/
│   │   │   │   └── customization_repository.dart
│   │   │   └── usecases/
│   │   │       └── customization_usecases.dart
│   │   └── presentation/
│   │       └── pages/
│   │           └── customization_page.dart
│   └── stopwatch/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── stopwatch_local_datasource.dart  # Wraps Floor DAO
│       │   └── repositories/
│       │       └── stopwatch_repository_impl.dart   # Mapper+CRUD
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── stopwatch_customization.dart
│       │   │   ├── stopwatch_lap.dart
│       │   │   └── stopwatch_session.dart   # With lastStartTime for pause/resume
│       │   ├── repositories/
│       │   │   └── stopwatch_repository.dart
│       │   └── usecases/
│       │       └── stopwatch_usecases.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── stopwatch_bloc.dart
│           │   ├── stopwatch_event.dart
│           │   └── stopwatch_state.dart
│           ├── pages/
│           │   └── stopwatch_page.dart
│           └── widgets/
│               ├── stopwatch_controls.dart
│               └── stopwatch_lap_list.dart
test/
    └── widget_test.dart
```

## Key Modules & Responsibilities

- **`core/services/`** — Cross-cutting singletons: TimeTicker, Audio, Notifications, Permissions.
- **`core/database/`** — Floor SQLite ORM: entities, DAOs, generated code. Owned by `configureDependencies()`.
- **`core/di/`** — The single source of truth for `get_it` registrations.
- **`core/utils/`** — Domain-agnostic utilities (Result, error sealed classes, Duration formatting, DateTime extensions).
- **`features/<feature>/domain/`** — Immutable entities, repository interfaces (abstract), usecase classes.
- **`features/<feature>/data/`** — Data sources wrapping DAOs, repository implementations mapping entities ↔ domain.
- **`features/<feature>/presentation/`** — BLoC (state sealed class extends Equatable, event sealed class), pages, widgets.

## Data Flow

```
UI (Page) → Bloc (State/Event) → Usecase → Repository Interface → Repository Impl → Datasource → Floor DAO → SQLite
                                              ↓
                                           Result<T, E> wrapper prevents exceptions crossing boundaries
```

### Navigation
- `go_router` with `ShellRoute` provides bottom tab navigation (Alarm, Stopwatch, Customization).
- `BlocProvider` is injected at the route level for the Stopwatch feature.

### State Management
- `flutter_bloc` + `Equatable` for all feature states.
- `TimeTickerService` provides a 10ms `Stream<DateTime>` consumed by the Stopwatch BLoC when running.
- Ticker subscription is lifecycle-managed inside the BLoC (subscribed on Start, cancelled on Stop/Close).

### Error Handling
- All repository methods return `Result<T, AppError>`.
- Never throw exceptions from data layer to presentation layer.
- Presentation layer uses `result.when(success: ..., failure: ...)`.

## How to Navigate

- Need to add a new feature? Create `features/<name>/domain/`, `data/`, `presentation/`.
- Need to add a new service? Add to `core/services/` and register in `core/di/injection.dart`.
- Need to add a new DB entity? Add to `core/database/entities/`, create DAO in `core/database/dao/`, register in `app_database.dart`, run `build_runner`.
- All imports should follow the AGENTS.md convention (`package:better_clock/...` or verified relative).
