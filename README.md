# iOS Test Application

This repository contains a mobile iOS application developed as part of a test assignment. The application is designed following the MVVM (Model-View-ViewModel) architectural pattern and utilizes AutoLayout for UI layout and constraints.

## Features

- **Single Screen**: The app contains a single screen interface.
- **Multi-Selection Checkboxes**: Users can make multiple selections using checkboxes.

## Architecture

The application is built using the MVVM architectural pattern, which promotes separation of concerns and allows for easier testing and maintenance. Below is a brief overview of each component:

- **Model**: Handles the data and business logic.
- **View**: Responsible for the UI and presentation. All UI components are laid out using AutoLayout to ensure a responsive and adaptive design.
- **ViewModel**: Acts as a mediator between the Model and View, handling the presentation logic.

## UI Layout

The UI is designed with AutoLayout to ensure that the layout adapts to different screen sizes and orientations. This approach also improves maintainability and readability of the UI code.

## Getting Started

### Prerequisites

- Xcode 14.0 or later
- iOS 15.0 or later

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/ios-test-app.git
2. ```bash
   cd ios-test-app
3. ```bash
   open ios-test-app.xcodeproj
