# Better Clock — Development Phases & Roadmap

## Overview
A modern, highly customizable clone of the iOS Clock app built with Flutter.

## Completed Phases

### Phase 1: Skeleton & Infrastructure ✅
- [x] Project setup with `fvm flutter create`.
- [x] Dependencies: `flutter_bloc`, `go_router`, `get_it`, `floor`, `audioplayers`, `file_picker`, `path_provider`, `flutter_local_notifications`, `permission_handler`, `equatable`, `intl`, `build_runner`, `floor_generator`.
- [x] Folder structure: Feature-Sliced Design (FSD) inside Clean Architecture.
- [x] **Core Services**: `TimeTickerService` (10ms broadcast), `AudioService`, `NotificationService`, `PermissionService`.
- [x] **Database**: Floor entities (`AlarmEntity`, `StopwatchSessionEntity`, `LapEntity`, `CustomizationEntity`), DAOs, `AppDatabase`, auto-generated `app_database.g.dart`.
- [x] **Utilities**: Monadic `Result<T, E>` with `Success`/`Failure`, sealed `AppError` hierarchy (`DatabaseError`, `NotFoundError`, `ValidationError`, `UnknownError`), `DurationFormatting`, `DateTimeExtensions`.
- [x] **DI**: `get_it` registration for all core services, database, feature repositories, and usecases.
- [x] **Routing**: `go_router` with `ShellRoute` and `NavigationBar` (Alarm, Stopwatch, Customization tabs).
- [x] Placeholder pages for Alarm and Customization.
- [x] `ARCHITECTURE.md` created with live directory tree.

### Phase 2: Functional Stopwatch ✅
- [x] **Domain Layer**: `StopwatchSession`, `StopwatchLap` entities with `lastStartTime` for pause/resume accuracy.
- [x] **Domain Layer**: `StopwatchCustomization` entity (font size, colors, lap list toggles).
- [x] **Repository Interface**: `IStopwatchRepository` returning `Result<T, E>`.
- [x] **Usecases**: `CreateSessionUseCase`, `UpdateSessionUseCase`, `DeleteSessionUseCase`, `GetOrCreateCurrentSessionUseCase`, `AddLapUseCase`, `DeleteLapsUseCase`.
- [x] **Data Layer**: `StopwatchLocalDataSource` wrapping Floor DAO.
- [x] **Data Layer**: `StopwatchRepositoryImpl` with full entity <-> domain mapping including `lastStartTimeIso`.
- [x] **Customization Data Layer**: `ICustomizationRepository`, `CustomizationRepositoryImpl` (JSON serialization).
- [x] **Customization Usecases**: `GetStopwatchCustomizationUseCase`, `SaveStopwatchCustomizationUseCase`.
- [x] **BLoC**: `StopwatchBloc`, `StopwatchEvent`, `StopwatchState` using `Equatable`.
  - `LoadStopwatch`, `StartStopwatch`, `StopStopwatch`, `ResetStopwatch`, `LapStopwatch`, `TickStopwatch`, `LoadCustomization`, `UpdateCustomization`.
  - Accurate pause/resume via `lastStartTime`.
  - Ticker subscription management.
- [x] **UI**: `StopwatchPage` with large formatted MM:SS.hs timer, Start/Stop/Reset/Lap controls.
- [x] **UI**: `StopwatchControls` widget.
- [x] **UI**: `StopwatchLapList` widget with lap number, lap duration, running total.
- [x] DI fully wired for Stopwatch and Customization modules.
- [x] `flutter analyze` — 0 errors.
- [x] `flutter build macos --debug` — success.

## Remaining Phases

### Phase 3: Alarm Core
- [ ] Alarm domain entity with repeat days, label, sound, volume, vibrate, snooze.
- [ ] `IAlarmRepository` with CRUD operations.
- [ ] Alarm usecases (create, update, delete, get, toggle).
- [ ] Alarm data layer (Floor datasource, repository implementation).
- [ ] Alarm list UI with enable/disable toggles.
- [ ] Alarm create/edit dialog/page.
- [ ] Foreground alarm scheduling (in-app alarm trigger UI).
- [ ] `AppDatabase` migration for alarms (if entity changes).

### Phase 4: Background Alarms & Custom Sounds
- [ ] Android: native `AlarmManager` + Foreground Service.
- [ ] iOS/macOS: local notifications + deep links.
- [ ] Alarm must work when app is killed.
- [ ] Deep link handling to open app/trigger alarm ring UI.
- [ ] Custom sounds: built-in defaults + user import via file picker.
- [ ] Audio service integration for alarm sounds.
- [ ] Permission handling for notifications, exact alarms, background services.

### Phase 5: Deep Customization
- [ ] Drag-and-drop layout builder for all clock faces.
- [ ] Save/load layout configurations to DB.
- [ ] Theme engine with per-feature customization.
- [ ] Full stopwatch/timer layout customization.

## Key Design Decisions Archive

1. **Feature-Sliced Design (FSD)** inside Clean Architecture: `domain` → `data` → `presentation` per feature.
2. **State Management:** BLoC (`flutter_bloc`) + `Equatable`.
3. **DI:** `get_it` (manual registration, no codegen).
4. **Navigation:** `go_router` with `ShellRoute` + `NavigationBar`.
5. **Database:** SQLite via `floor` ORM, version 1.
6. **Error Handling:** Monadic `Result<T, E>` wrapping at repository boundary, no exceptions.
7. **Entities:** Floor entities for storage, pure Dart domain entities for business logic.
8. **Services:** Singleton instances registered in DI.
9. **Background Alarms:** Android uses native `AlarmManager`/Foreground Service; iOS/macOS uses `flutter_local_notifications`.
10. **Platforms:** Android, iOS, macOS.

## Build Verification
- **Current status**: `flutter analyze` — 0 errors.
- **Native build**: macOS debug build succeeds.
- **Known warnings**: 3rd-party `audioplayers` Sendable warnings (no action needed).

## To Update
- Update this file when a phase is completed.
- Update `ARCHITECTURE.md` when directory structure changes.
