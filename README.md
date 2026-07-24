# Integra Fitness

Integra Fitness is a modern Flutter application designed to bring together the key components of a complete wellness experience in one polished mobile interface.

## Overview

Integra Fitness provides a unified fitness companion that blends the most useful elements from meal planners, workout trackers, and community wellness apps. With a focus on personalization and usability, the project aims to support daily nutrition, workout planning, progress tracking, and social motivation in a single experience.

## Key Features

- **Meal Tracking**: Log meals and review nutrition summaries.
- **Food Scanning**: Support for quick food search and scanning workflows.
- **Recipe Management**: View recipes with scalable serving sizes.
- **Workout Tracking**: Track exercises, sessions, and progress.
- **Custom Workouts**: Build routines based on available equipment and body composition.
- **Nutrition Planning**: Personalized nutrition plans with dynamic recommendations.
- **Community Hub**: Discover groups, connect with friends, and stay motivated.
- **Appearance Settings**: Toggle between light and dark themes.

## Feature Checklist

Use this checklist to track which features are implemented and which are still planned.

- [ ] Meal Tracking
- [ ] Food Scanning
- [ ] Recipe Management
- [ ] Workout Tracking
- [ ] Custom Workouts
- [ ] Nutrition Planning
- [ ] Community Hub
- [ ] Appearance Settings

## Architecture

The app is built with Flutter and follows a tab-based design using:

- `MaterialApp` with `ThemeData` and custom color schemes
- `IndexedStack` for fast tab switching
- Modular tab screens under `lib/tabs/`
- A dedicated settings screen in `lib/settings/`
- Global slide page transitions for a smooth navigation experience

## Getting Started

### Prerequisites

- Flutter SDK installed
- A supported IDE such as Visual Studio Code or Android Studio
- A connected device or emulator

### Run the app

```bash
flutter pub get
flutter run
```

### Run tests

```bash
flutter test
```

## Project Structure

- `lib/main.dart` — App entry point, themes, navigation, and tab layout
- `lib/tabs/` — Individual tab screens and reusable tab view components
- `lib/settings/settings_page.dart` — Settings screen and preferences UI
- `test/` — Widget tests covering navigation and settings behavior

## Contributing

Contributions are welcome. If you want to add features, improve the UI, or fix bugs, please follow standard GitHub workflows:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request with a clear description

## Notes

This repository is a great foundation for expanding into a full-featured fitness platform. The existing structure is designed to support additional modules like workout history, meal plan scheduling, user profiles, and social activity feeds.
=======
A Flutter Application that tries to combine all the different fitness apps into one:

## Goals
* Meal Tracking
* Food Scanning
* Recipes with scalable servings
* Workout Tracking
* Custom workouts based on equipment/body comp with scaling
* Nutrition tracking with personalized plans
* Community section for gyms/groups/friends etc.
* and more
>>>>>>> 2506b8728ca0968b9c28f4bf701eff07d482f453
