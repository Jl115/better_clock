# Better Clock — Architecture Map

## Directory Tree

```
lib/
├── main.dart
├── router.dart
├── core/
│   ├── di/
│   │   └── injection.dart              # get_it registrations
│   ├── data/
│   │   └── local/
│   │       ├── app_database.dart       # Floor abstract DB (cross-feature via package: imports)
│   │       └── app_database.g.dart     # Generated Floor code
│   ├── services/
│   │   ├── audio_service.dart
│   │   ├── notification_service.dart
│   │   ├── permission_service.dart
│   │   └── time_ticker_service.dart    # 10ms broadcast stream
│   ├── theme/
│   │   ├── catppuccin_colors.dart      # Catppuccin Mocha + Latte palette
│   │   └── app_theme.dart              # ThemeData builder for Mocha
│   └── utils/
│       └── result.dart                 # Monadic Result<T,E>, AppError hierarchy, DurationFormatting
├── features/
│   ├── alarm/
│   │   ├── data/
│   │   │   ├── dao/
│   │   │   │   └── alarm_dao.dart
│   │   │   └── models/
│   │   │       └── alarm_entity.dart
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
│       │   │   └── stopwatch_local_datasource.dart
│       │   ├── models/
│       │   │   └── stopwatch_entity.dart
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
2. **Floor entities are feature-owned:** Every feature owns its Floor entities in `features/<name>/data/models/` and DAOs in `features/<name>/data/dao/`.
3. `core/data/local/app_database.dart` only contains the shared `AppDatabase` abstraction and cross-feature entity imports via **package: imports** (required for `floor_generator` to discover entities).
4. **State Management:** `flutter_bloc` with `Equatable` states.
5. **DI:** `get_it` for manual singleton registrations.
6. **Navigation:** `go_router` with `ShellRoute` for bottom tabs (Alarm, Stopwatch, Customization).
7. **Database:** SQLite via `floor` ORM. `AppDatabase` is built in `configureDependencies()`.
8. **Domain entities:** Pure Dart. Floor entities: storage only. They are separate and owned by features.
9. **Result type:** Monadic `Result<T, E>` used at all repository boundaries.
10. **Services:** Singletons for cross-cutting concerns (ticker, audio, notifications, permissions).
11. **Theme:** Catppuccin Mocha with Latte foundation prepared.
12. **Phase tracking:** See `PHASES.md` for completed and remaining phases.
