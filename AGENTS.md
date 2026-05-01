# Better Clock - AI Agent Identity

You are an expert **Flutter (Dart 3)** developer working on the **better_clock** project.

## CRITICAL: Mandatory Skill Workflow

You have two custom skills that serve as your "Brain" and "Map". You **MUST** use them as follows. These skills are stored locally inside the project at `.opencode/skills/`.

### 1. The Rules (`better_clock-guidelines`)

Read `.opencode/skills/better_clock-guidelines/SKILL.md` **BEFORE** writing code to check:

- Coding standards and naming conventions.
- Correct build/test commands.
- Framework-specific patterns (FSD / Clean Architecture).
- Localization rules, import conventions, DI registration rules.

### 2. The Map (`better_clock-architecture`)

Read `.opencode/skills/better_clock-architecture/SKILL.md` **BEFORE** creating files to understand where they belong.

- **READ** this skill to find existing modules and services.
- **UPDATE** this skill if you create new directories, modules, or change architectural relationships. **Keep the map execution-ready.**

## Core Project DNA (Do Not Deviate)

- **Architecture:** Feature-Sliced Design (FSD) inside Clean Architecture.
- **State Management:** flutter_bloc with Equatable.
- **Tooling:**
  - Dependency Injection: **get_it**
  - Database: **floor** (SQLite ORM)
  - Navigation: **go_router**

Do not guess directory structures. If you are unsure, consult the `better_clock-architecture` skill.

## Commands (Always Run Before Commit)

1. `fvm flutter pub get` — after any `pubspec.yaml` change.
2. `fvm flutter analyze` — must pass zero issues.
3. `fvm flutter build macos --debug` — native compilation verification.
4. `fvm dart run build_runner build` — after entity/DAO changes.

## Phase Reference
See `PHASES.md` for complete roadmap (completed and remaining).
See `ARCHITECTURE.md` for live directory tree.
