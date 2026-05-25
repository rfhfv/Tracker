# Tracker App

An iOS habit tracker built with Swift and UIKit.  
The app helps users form healthy habits by creating custom trackers with categories, emoji, colors, and schedules. It features filtering by day or status, detailed statistics, and dark mode support, all powered by Core Data.

[Figma mockup](https://www.figma.com/design/owAO4CAPTJdpM1BZU5JHv7/Tracker)

## Screenshots

<img width="1975" height="782" alt="Image" src="https://github.com/user-attachments/assets/8dfc9e15-037a-4bae-9c75-3aeba9150ee1" />

## Features

- **Habit & Event Tracking:** Create regular habits with a weekly schedule, or irregular events for one-off activities.
- **Customization:** Personalize each tracker with a name, category, custom emoji, and color.
- **Calendar View:** View and filter your trackers by any specific day.
- **Search & Filter:** Find trackers by name or filter them by completion status ("All", "Today", "Completed", "Incomplete").
- **Statistics Dashboard:** Monitor your progress with metrics like "Best Streak", "Perfect Days", "Total Completed", and "Daily Average".
- **Category Management:** Create, edit, and delete custom categories to organize your trackers.
- **Onboarding Flow:** A brief introduction to the app's concepts on first launch.
- **Dark Mode:** Full support for system-wide light and dark themes.

## Tech Stack

- **UIKit** with Storyboards and Auto Layout
- **Core Data** for local data persistence
- **MVVM** architectural pattern
- **Foundation** frameworks (UICollectionView, DatePicker, etc.)

## Architecture

The project follows the **MVVM (Model-View-ViewModel)** pattern:

- **Model:** Core Data entities (`Tracker`, `Category`, `TrackerRecord`) that encapsulate all business data and persistence logic.
- **View:** UIKit ViewControllers and custom UIViews. Responsible for displaying data and forwarding user actions to the ViewModel.
- **ViewModel:** Prepares data from the Model for the View, handles business logic (filtering, statistics calculation), and notifies the View of changes via delegates.

## Key Implementation Details

- **Local Persistence:** All user data is stored locally using Core Data, ensuring full offline functionality.
- **Dynamic UI:** The main screen is built with a `UICollectionView` and compositional layout to handle sections, search, and filtering smoothly.
- **Date-Based Filtering:** A custom calendar and date-picker logic allow users to view exactly which habits are scheduled for a chosen day.
- **Statistics Calculation:** ViewModel calculates user metrics like streaks and averages by analyzing Core Data records.
- **Onboarding:** The first-launch experience is managed through a `UIPageViewController` with custom control.

## Installation

**Via terminal:**

- git clone https://github.com/rfhfv/Tracker.git
- cd Tracker
- open Tracker.xcodeproj
