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
│   ├── data/
│   │   └── local/
│   │       ├── app_database.dart     # Floor abstract DB (uses package: imports for cross-feature)
│   │       └── app_database.g.dart   # Generated Floor code
│   ├── services/
│   │   ├── audio_service.dart         # Placeholder for audioplayers
│   │   ├── notification_service.dart  # Placeholder for flutter_local_notifications
│   │   ├── permission_service.tsx    # Permission handler wrapper
│   │   └── time_ticker_service.dart   # Broadcasts DateTime every 10ms
│   ├── theme/
│   │   ├── catppuccin_colors.dart    # Catppuccin Mocha + Latte palette constants
│   │   └── app_theme.dart             # ThemeData builder for Mocha
│   └── utils/
│       └── result.dart                # Monadic Result<T,E>, AppError hierarchy, DurationFormatting
├── features/
│   ├── alarm/
│   │   ├── data/
│   │   │   ├── dao/
│   │   │   │   └── alarm_dao.dart    # Floor DAO for AlarmEntity
│   │   │   └── models/
│   │   │       └── alarm_entity.dart  # Floor entity for alarms
│   │   └── presentation/
│   │       └── pages/
│   │           └── alarm_list_page.dart
│   ├── customization/
│   │   ├── data/
│   │   │   ├── dao/
│   │   │   │   └── customization_dao.dart
│   │   │   ├── models/
│   │   │   │   └── customization_entity.dart
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
│       │   ├── dao/
│       │   │   └── stopwatch_dao.dart
│       │   ├── datasources/
│       │   │   └── stopwatch_local_datasource.dart  # Wraps Floor DAO
│       │   ├── models/
│       │   │   └── stopwatch_entity.dart  # StopwatchSessionEntity, LapEntity
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
- **`core/data/local/`** — Shared local DB abstraction: `AppDatabase`, `app_database.g.dart`. **Does not contain feature entities or DAOs.**
- **`core/di/`** — The single source of truth for `get_it` registrations.
- **`core/theme/`** — Catppuccin Mocha/Latte color palettes and Mocha ThemeData builder.
- **`core/utils/`** — Domain-agnostic utilities (Result, error sealed classes, Duration formatting, DateTime extensions).
- **`features/<feature>/data/models/`** — Floor entities (DB tables) owned by the feature.
- **`features/<feature>/data/dao/`** — Floor DAOs owned by the feature.
- **`features/<feature>/data/repositories/`** — Repository implementations that map between Floor entities and domain models.
- **`features/<feature>/domain/`** — Immutable entities, repository interfaces (abstract), usecase classes.
- **`features/<feature>/presentation/`** — BLoC (state sealed class extends Equatable, event sealed class), pages, widgets.

## Data Flow

```
UI (Page) → Bloc (State/Event) → Usecase → Repository Interface → Repository Impl → Datasource → Floor DAO → SQLite
                                              ↓
                                           Result<T, E> wrapper prevents exceptions crossing boundaries
```

### Database Layer (IMPORTANT)
- Floor entities and DAOs are **feature-owned** (`features/<feature>/data/models/` and `features/<feature>/data/dao/`).
- `core/data/local/app_database.dart` is the **shared abstraction** that imports all feature entities via **package: imports** (so `floor_generator` can discover them).
- `AppDatabase` must import entities as `package:better_clock/features/<feature>/data/models/<entity>.dart`, not relative paths.

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

- Need to add a new feature? Create `features/<name>/domain/`, `data/models/`, `data/dao/`, `data/repositories/`, `presentation/`.
- Need to add a new service? Add to `core/services/` and register in `core/di/injection.dart`.
- Need to add a new DB entity? Add to `features/<name>/data/models/`, create DAO in `features/<name>/data/dao/`, import in `core/data/local/app_database.dart` via **package: import**, run `build_runner`.
- All imports should follow the AGENTS.md convention (`package:better_clock/...` or verified relative).
