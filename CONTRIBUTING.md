# 🤝 Contributing to Pizza Delivery Demo

Thank you for your interest in contributing! This guide explains how to run the project locally, the preferred workflow, and — critically — how to handle secrets (Firebase keys and config) safely.

---

## 🎯 Goal

Keep the repository clean of secrets while enabling reproducible local setups and clear contribution steps for students and collaborators.

---

## 🔧 Local Setup (Windows + VS Code)

1. Clone the repo and open it in VS Code:

```powershell
git clone <YOUR_REPO_URL>
cd "C:\Users\<you>\Desktop\Aplicaciones Moviles\pizza_app_8sc_gmao"
code .
```

2. Install dependencies:

```powershell
flutter pub get
```

3. Configure Firebase locally (Auth + Firestore):

- Install `flutterfire_cli` (if not already):

```powershell
dart pub global activate flutterfire_cli
```

- Run configuration (choose your Firebase project):

```powershell
flutterfire configure --project "YOUR_PROJECT_ID"
```

This generates a local `lib/firebase_options.dart`. IMPORTANT: do not commit that file.

4. Run the app:

```powershell
flutter run -d chrome
```

---

## 🔐 Secrets & Firebase Configuration (MUST READ)

- Never commit the following files to this repository:
  - `android/app/google-services.json`
  - `ios/Runner/GoogleService-Info.plist`
  - `lib/firebase_options.dart`
  - Service account JSON files (e.g., `*-serviceAccount-*.json`)
  - `.env` files with real keys

- This repository already includes `.gitignore` entries for these files. If you accidentally pushed secrets, rotate keys immediately and contact the instructor.

- When you need to share configuration with teammates use one of these secure methods:
  - A private password manager / secrets manager
  - An encrypted channel (e.g. secure file share)
  - CI/CD secrets (set variables in GitHub Actions or your CI provider)

---

## 🧾 What to Commit

- Commit source code, tests, and documentation.
- Do NOT commit generated or local-only config files. Instead, provide sample files suffixed with `.sample` (for example: `google-services.json.sample`) containing placeholders and instructions.

---

## 🛠 Branching & Pull Request Workflow

1. Create a feature branch from `main`:

```powershell
git checkout -b feat/short-description
```

2. Make your changes and run tests (or `flutter analyze`):

```powershell
flutter analyze
flutter test
```

3. Stage and commit with a clear message:

```powershell
git add <files>
git commit -m "feat: add short description"
```

4. Push your branch and open a Pull Request on GitHub.

PR checklist:
- Title and description explain the change.
- No secrets or credentials included.
- `flutter analyze` passes locally.

---

## 📐 Code Style & Tests

- Follow existing style in the project.
- Prefer small, focused commits.
- Run `flutter analyze` and unit/widget tests before submitting a PR.

---

## 🧾 Adding Demo Assets

If adding large binary assets (GIFs, images) consider placing them in `docs/` and keep them reasonably small. If files are large (>5MB), consider hosting externally or using Git LFS.

---

## ❓ Questions or Sensitive Incidents

If you accidentally commit a secret, notify the repository owner immediately and rotate the secret in the provider console (Firebase). For help removing secrets from history, ask the instructor or follow documented steps for `git filter-repo` or BFG.

---

Thanks for helping keep the project secure and easy to collaborate on — happy coding! 🍕✨
