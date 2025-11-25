# Requirements Document — Pizza App

Last updated: November 25, 2025

Purpose
- Define the scope, functional and non-functional requirements, user flows, data models, and acceptance criteria for the "Pizza App" mobile/web application.

1. Product summary
- An app for ordering pizzas with a catalog, product details, cart, authentication (Firebase Auth), and data storage (Cloud Firestore).
- Goal: allow authenticated users to browse pizzas, add them to a cart, and complete orders (checkout planned for a later phase).

2. Audience and actors
- End User (customer): browses the catalog, manages cart, places orders.
- Administrator (optional): manages catalog and orders (not implemented currently).
- External systems: Firebase Auth, Cloud Firestore (database), hosting (optional).

3. Functional requirements (FR)
FR-01 Authentication
- Users can sign in / sign out using email and password via Firebase Auth.
- On registration, a document `users/{uid}` is created in Firestore with basic user data.

FR-02 Pizza catalog
- Display a list of pizzas: image, name, description, price, discount, veg/non-veg indicator, and spiciness level.
- Support pagination or batch loading (future improvement).

FR-03 Product details
- Show detailed information for a pizza and a button to "Add to cart".

FR-04 Cart
- Users can add/remove items and change quantities in the cart (currently in-memory state).
- Show a summary (total quantity, total price) in a bottom bar or modal.

FR-05 Checkout (minimum scope)
- An "Order Now" button that acts as a placeholder for the payment flow (payment integration is out of scope for this phase).

FR-06 Robust images
- Attempt to load network images and fall back to a local asset if loading fails.

4. Non-functional requirements (NFR)
NFR-01 Performance
- UI response time: under 200ms for basic interactions on modern devices.

NFR-02 Availability
- Support partial offline mode: show cache or appropriate messages when Firestore is unavailable (future improvement).

NFR-03 Security
- Do not commit secrets or files like `google-services.json` or `GoogleService-Info.plist` to the repository.
- Firestore rules must protect reads/writes by UID (project-specific rules).

NFR-04 Accessibility
- Use accessible text contrast, scalable text sizes, and minimum tappable area for buttons.

NFR-05 Portability
- Support Android, iOS and Web; avoid native APIs unsupported on Web or provide alternatives.

5. Data models (proposed)
- Pizza
  - id: string
  - name: string
  - description: string
  - price: number (integer)
  - discount: int (percentage)
  - picture: string (URL or local path)
  - isVeg: bool
  - spicy: int (1=bland, 2=balanced, 3=spicy)

- CartItem
  - pizzaId: string
  - name: string
  - unitPrice: number
  - qty: int
  - picture: string

- User (Firestore `users/{uid}`)
  - uid: string
  - email: string
  - displayName: string
  - isAdmin: bool (optional)
  - createdAt: timestamp

6. Critical user flows
- Launch -> Authentication -> Home
- Home -> Details -> Add to cart -> View cart -> Order Now
- SignUp -> create Firestore user doc -> redirect to Home

7. APIs / Integrations
- Firebase Auth: login, logout, registration.
- Firestore: `pizzas` collection (read access) and `users`.
- (Optional) Cloud Functions / Payments: future integrations.

8. Testing & acceptance criteria
8.1 Acceptance criteria (by FR)
- FR-01: Registration creates `users/{uid}` and the user becomes authenticated.
- FR-02: Catalog displays at least 5 sample pizzas and broken images use the local fallback image.
- FR-03: Adding to cart increases `totalItems` and `totalPrice` in the bottom summary bar.
- FR-04: No RenderFlex overflow occurs on the main UI on small screens.

8.2 Recommended tests
- Unit tests: BLoCs/Cubits (GetPizzaBloc, CartCubit, AuthenticationBloc).
- Widget tests: Home screen rendering, Cart screen quantity manipulation.
- Integration tests: full flow login -> add to cart -> verify totals.

9. Deployment and development environment
- Local requirements: Flutter SDK (stable channel recommended), matching Dart SDK, Android SDK/emulator or Chrome for web testing.
- Sensitive files: `android/app/google-services.json`, `ios/GoogleService-Info.plist`, `lib/firebase_options.dart` should remain out of the repository (use `.gitignore` and provide sample files like `.sample`).
- Useful commands:
  - `flutter pub get`
  - `flutter analyze`
  - `flutter run -d chrome` (or `-d emulator-5554` for Android)

10. Tasks / milestones
- Milestone 1: Stabilize catalog and details (responsive UI and image fallback). (PARTIALLY COMPLETED)
- Milestone 2: Implement cart with local persistence (SharedPreferences / Hive). (ACTION: reimplement on feature branch)
- Milestone 3: Basic checkout and payments (out of initial scope).

11. Constraints and assumptions
- The app uses Firebase as backend; the team has access to configure local credentials.
- Payment gateway is not required in the initial phase.
- Firestore rules will be configured so only authenticated users can write their `users/{uid}` document.

12. Risks
- Misconfigured Firestore rules → runtime read/write failures.
- Unreliable external images → local fallback required.
- State manipulation before providers are mounted → ProviderNotFoundException (mitigated by defensive UI code).

13. Recommendations
- Provide `CartCubit` at a top-level in the widget tree when `HomeScreen` or other screens consume it.
- Persist the cart locally to improve UX and survive hot reloads / app restarts.
- Add CI to run `flutter analyze` and unit tests.

14. Attachments
- `README.md` includes basic setup instructions and `android/google-services.json.sample` as a guide.

---
Notes: This document is a baseline. We can convert it into a formal template (IEEE or an agile user-story backlog) if you prefer.
