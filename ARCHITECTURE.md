# Better Clock — Architecture Map

## Directory Tree

```
lib/
├── main.dart
├── router.dart
├── core/
│   ├── di/
│   │   └── injection.dart              # get_it registrations
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
│   │   ├── audio_service.dart
│   │   ├── notification_service.dart
│   │   ├── permission_service.dart
│   │   └── time_ticker_service.dart   # 10ms broadcast stream
│   └── utils/
│       └── result.dart                # Monadic Result<T,E>, AppError
├── features/
│   ├── alarm/
│   │   └── presentation/
│   │       └── pages/
│   │           └── alarm_list_page.dart
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
│       │   │   └── stopwatch_local_datasource.dart
│       │   └── repositories/
│       │       └── stopwatch_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── stopwatch_customization.dart
│       │   │   ├── stopwatch_lap.dart
│       │   │   └── stopwatch_session.dart
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

## Architectural Decisions

1. **Feature-Sliced Design (FSD)** inside Clean Architecture layering (domain / data / presentation).
2. **State Management:** `flutter_bloc` with `Equatable` states.
3. **DI:** `get_it` for manual singleton registrations.
4. **Navigation:** `go_router` with `ShellRoute` for bottom tabs (Alarm, Stopwatch, Customization).
5. **Database:** SQLite via `floor` ORM. AppDatabase is built in `configureDependencies()`.
6. **Entities:** Floor entities mirror DB tables. Domain entities are pure Dart.
7. **Result type:** Monadic `Result<T, E>` used at all repository boundaries.
8. **Services:** Singletons for cross-cutting concerns (ticker, audio, notifications, permissions).
9. **Phase tracking:** See `AGENTS.md` todo list for completed phases.
