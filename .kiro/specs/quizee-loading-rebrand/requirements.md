# Requirements Document

## Introduction

This feature updates all loading screens and remaining Playshares references in the Quizee Android TWA (Trusted Web Activity) application to use proper Quizee branding. The app currently has a `web_app_manifest.json` file that still references "Playshares" which affects loading screens and app identity during startup. Additionally, the loading screens will display dynamically generated loading messages to enhance user engagement during app startup.

## Glossary

- **TWA**: Trusted Web Activity - Android app wrapper that displays web content in a full-screen Chrome browser
- **Web App Manifest**: JSON file that provides metadata about the web application including name, icons, and theme colors
- **Splash Screen**: The loading screen displayed while the app initializes
- **Quizee**: The target brand identity for the application
- **Loading Message**: A text message displayed during app loading to engage users while content loads

## Requirements

### Requirement 1

**User Story:** As a user, I want to see Quizee branding on all loading screens, so that I have a consistent brand experience from app launch.

#### Acceptance Criteria

1. WHEN the app launches THEN the system SHALL display "Quizee" as the application name in the web app manifest
2. WHEN the app displays a short name THEN the system SHALL show "Quizee" instead of "Playshares"
3. WHEN the splash screen appears THEN the system SHALL use Quizee brand colors (#6366F1 primary, #F8FAFC background)
4. WHEN the app loads THEN the system SHALL reference Quizee icon paths (/icons/quizee-*.png)

### Requirement 2

**User Story:** As a user, I want to see engaging loading messages during app startup, so that the loading experience feels dynamic and interesting.

#### Acceptance Criteria

1. WHEN the splash screen displays THEN the system SHALL show a randomly selected loading message from a predefined list
2. WHEN generating a loading message THEN the system SHALL select from Quizee-themed messages (quiz-related, fun, engaging)
3. WHEN the loading message appears THEN the system SHALL display it below the Quizee logo on the splash screen

### Requirement 3

**User Story:** As a developer, I want all Playshares references removed from the codebase, so that the branding is complete and consistent.

#### Acceptance Criteria

1. WHEN searching the codebase for "Playshares" THEN the system SHALL return zero matches in production code
2. WHEN the web_app_manifest.json is parsed THEN the system SHALL contain only Quizee references
3. WHEN building the APK THEN the system SHALL produce an artifact with consistent Quizee branding throughout

### Requirement 4

**User Story:** As a user, I want the rebuilt APK to be properly signed, so that I can install and update the app on my device.

#### Acceptance Criteria

1. WHEN the APK is built THEN the system SHALL sign it with the existing android.keystore
2. WHEN the signed APK is generated THEN the system SHALL be installable on Android devices
3. WHEN the APK is installed THEN the system SHALL display Quizee branding and loading messages on all loading screens
