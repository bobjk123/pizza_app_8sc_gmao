# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog and follows Semantic Versioning where possible.

## Unreleased
- Documentation updates and housekeeping.

## 2025-11-25
### Added
- `REQUIREMENTS.md` (Spanish) and `REQUIREMENTS_en.md` (English). (commit: `0a580d1`)

### Changed
- README updated with a "Recent changes (25 Nov 2025)" section documenting today's reverts and new requirement files. (commit: `a8ec887`)
- Minor README edits earlier same day. (commit: `18f3adb`)

## 2025-11-24
### Reverts
- Reverted two recent feature/fix commits pushed on 2025-11-24. Revert commits pushed to `main`:
  - `fee07ab` — Revert "feat: add CartCubit, CartScreen and cart summary bar; wire add-to-cart"
  - `f796cf0` — Revert "fix: repair HomeScreen widget tree and prevent bottom bar overflow; improve responsiveness"

> Note: These reverts removed the experimental cart files and the HomeScreen edits that were added earlier on 2025-11-24.

### Added (earlier on 2025-11-24)
- Experimental cart feature and UI (later reverted): `CartCubit`, `cart_state`, `CartScreen`, and related changes. (original commits: `14de43f` and `63f7239`)
- New assets added. (commit: `9a49698`)

## 2025-11-19
### Added
- `CONTRIBUTING.md` and `android/google-services.json.sample`. (commits: `beb5b61`, `f705002`)
- Test images added. (commit: `d606543`)

## 2025-11-18
### Changed
- README and `.gitignore` updates; removed tracked `lib/firebase_options.dart` from repo and added to `.gitignore`. (commits: `22bfe51`, `12cd93e`)
- Deleted files containing Google/Firebase secrets from the repository. (commit: `cd61962`)

### Fixed
- `local_image` updated to support network image with local fallback. (commit: `724bc61`)

## 2025-11-17
### Changed
- Macro widget and BLoC fixes. (commit: `e44591b`)

## 2025-11-15
### Added
- Pizza repository library and models/entities. (commits: `b108083`, `a6da2b5`)
- Local image replacement for Firebase Storage usage. (commit: `846657a`)

---

This changelog captures major changes recorded in the recent commit history. If you want a more strict release-based changelog (tags and versions), I can:
- create a `v0.1.0` tag and move entries from `Unreleased` to that version, or
- generate a GitHub release from these entries.

Tell me if you want me to commit and push `CHANGELOG.md` now (I can do it), or adjust wording/structure first.