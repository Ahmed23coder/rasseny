# Agent Instructions: Rasseny Intelligence

## Project Overview & Personality
High-end, "Executive Editorial" news app for iPhone 15 Pro (393pt baseline).
- **Architecture:** Clean Architecture + BLoC + Repository Pattern.

## Critical Compliance Rules (Design System v2.0)
1. **Pill Aesthetics:** Every button, input, and chip must use `AppRadius.pill` (50px). No hardcoded 50.0 values.
2. **Iconography:** Strictly use `LucideIcons`. Stroke weights: 2.8 for active, 2.0 for inactive.
3. **Responsive Scaling:** Use `context.scaleWidth()` and `context.scaleHeight()` for all dimensions.
4. **Logic Pattern:** Feature-driven BLoC. Every screen must have a corresponding Cubit and State file.

## Immediate Tasks for Technical Audit & Refactor
1. **Refactor Inputs:** Update `lib/presentation/widgets/inputs/app_text_input.dart` to reference `AppRadius` constants instead of hardcoded values.
2. **Icon Migration:** Migrate `lib/presentation/widgets/navigation/bottom_nav_bar.dart` and header icons in `lib/presentation/views/home/home_view.dart` to `LucideIcons`.
3. **Consolidate Repositories:** Delete `lib/data/repositories/auth_repository_remote.dart` and move any unique logic to `auth_repository_impl.dart`.
4. **Router Audit:** Check `lib/core/navigation/app_router.dart` for routes mapped to `StubScreen` and prioritize them for implementation based on the 32-screen inventory.