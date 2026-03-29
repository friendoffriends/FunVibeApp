# FunVibe

![FunVibe](/DocAssets/FunVibeLogo.png)

FunVibe is an iOS SwiftUI app for discovering leisure activities around you.
It helps users explore clubs, events, and hobbies, then view details, maps, and profile-related flows in one app.

## What The App Does

- Discover clubs, events, and hobbies
- Browse featured activities with images
- Search activities by keyword
- Open activity detail pages
- View activity locations on a map
- Log in, create a profile, and manage a user account
- Use voice input to search for activities

## Project Structure

The `FunVibe/` folder is now grouped by responsibility to make the codebase easier to navigate:

```text
FunVibe/
├── App/
│   ├── FunVibeApp.swift
│   ├── AppData.swift
│   ├── EntryView.swift
│   └── InitialView.swift
├── Models/
│   ├── ActivityClass.swift
│   ├── AddressClass.swift
│   ├── ClassActivity.swift
│   ├── User.swift
│   └── UserClass.swift
├── Services/
│   ├── CustomFunctions.swift
│   └── SpeechRecognizer.swift
├── ViewModels/
│   └── EventMapViewModelClass.swift
├── Views/
│   ├── Activities/
│   ├── Admin/
│   ├── Auth/
│   ├── Home/
│   ├── Media/
│   ├── Profile/
│   └── Shared/
├── Assets.xcassets/
├── Info.plist
└── LaunchScreen.storyboard
```

## Main Feature Areas

### `App/`
App entry point, startup flow, and sample in-memory data.

### `Models/`
Core app models such as `Activity`, `User`, and `Address`.

### `Services/`
Shared helpers for formatting, authentication utilities, and speech recognition.

### `ViewModels/`
View-model layer for map-related logic and future presentation logic.

### `Views/`
UI grouped by feature:

- `Activities/`: explore, add, search, and detail screens
- `Admin/`: admin and user management views
- `Auth/`: login flow
- `Home/`: tab-based root screen
- `Media/`: microphone, file, and image picker views
- `Profile/`: profile screens and profile-specific components
- `Shared/`: shared reusable views like `MapView` and `PasswordField`

## Getting Started

### Requirements

- macOS
- Xcode
- iOS Simulator or a physical iPhone

### Open The Project

Use the main Xcode project:

```text
FunVibe.xcodeproj
```

Then:

1. Open the project in Xcode
2. Select the `FunVibe` scheme
3. Choose an iPhone simulator
4. Build and run the app

## Notes

- The project currently uses Xcode’s synchronized folder structure, so the on-disk folders mirror the app source layout.
- Some files contain earlier experimental or commented-out code; they are kept for now, but the folder structure is cleaner and easier to maintain.
- There are two Xcode project files in the repository, but `FunVibe.xcodeproj` is the one that matches the current synchronized source layout.

## Next Cleanup Ideas

- Rename a few files with spelling inconsistencies, such as `ActivityDesciptionView.swift` and `SendFileVieww.swift`
- Remove unused experimental files and commented-out legacy code
- Split large SwiftUI views into smaller reusable components
- Add tests for helper functions and login behavior