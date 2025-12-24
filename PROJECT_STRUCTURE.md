# Quizee Android Project Structure

## Overview
This is the Android TWA (Trusted Web Activity) project for **Quizee** - a modern quiz and educational assessment platform.

## Directory Structure

```
quizee-android/
├── app/                           # Main Android application module
│   ├── build.gradle              # App-level build configuration
│   └── src/
│       ├── main/                 # Production source code
│       │   ├── java/com/quizee/app/main/twa/  # Java source files
│       │   │   ├── Application.java
│       │   │   ├── DelegationService.java
│       │   │   └── LauncherActivity.java
│       │   ├── res/              # Android resources
│       │   │   ├── drawable*/    # Icons and graphics
│       │   │   ├── mipmap*/      # Launcher icons
│       │   │   ├── values/       # Strings, colors, etc.
│       │   │   └── xml/          # Configuration files
│       │   └── AndroidManifest.xml
│       └── integration/          # Integration build variant
│           └── res/              # Integration-specific resources
├── assets/                       # Source assets (icons, etc.)
│   ├── quizee-512.png           # Master 512x512 icon
│   ├── quizee-192.png           # Web icon
│   └── quizee-180.png           # iOS icon
├── docs/                         # Documentation
│   ├── ai-requirements.md       # AI/ML feature requirements
│   ├── migration-notes.md       # Migration documentation
│   └── quizee-branding.md       # Brand guidelines
├── scripts/                      # Build and utility scripts
│   ├── generate_icons.ps1       # Icon generation script
│   └── ...
├── build.gradle                  # Project-level build configuration
├── settings.gradle              # Gradle settings
├── twa-manifest.json            # TWA configuration
├── android.keystore             # App signing keystore
└── README.md                    # Project documentation
```

## Key Configuration Files

### App Identity
- **Package**: `com.quizee.app.main.twa`
- **App Name**: Quizee
- **Domains**: 
  - Production: `quizee.app`
  - Integration: `integration.quizee.app`

### Build Variants
- **Production**: Main release build for Play Store
- **Integration**: Development/testing build with red icon

### Icon Assets
All icons generated from `assets/quizee-512.png`:
- Launcher icons (all densities)
- Adaptive icons (Android 8.0+)
- Notification icons
- Splash screen
- Store listing icon

## Development Workflow

1. **Icon Updates**: Place new 512x512 icon in assets/ and run generation script
2. **Build Production**: `./gradlew assembleProductionRelease`
3. **Build Integration**: `./gradlew assembleIntegrationRelease`
4. **Build Both**: `./build-both.bat`

## Branding
- **Primary Color**: Indigo (#6366F1)
- **Theme**: Educational/professional
- **Target**: Quiz and learning enthusiasts