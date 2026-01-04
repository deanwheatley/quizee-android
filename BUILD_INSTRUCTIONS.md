# Quizee Android Build Instructions

## Prerequisites

### 1. Install Java Development Kit (JDK)
You need Java 17 or later for Android development. Choose one of these options:

#### Option A: Install via Homebrew (Recommended)
```bash
# Install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install OpenJDK 17
brew install openjdk@17

# Add to your shell profile (~/.zshrc or ~/.bash_profile)
echo 'export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home' >> ~/.zshrc
echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc

# Reload your shell
source ~/.zshrc
```

#### Option B: Download from Oracle/OpenJDK
1. Download JDK 17+ from https://adoptium.net/
2. Install the .pkg file
3. Set JAVA_HOME in your shell profile

### 2. Verify Java Installation
```bash
java -version
javac -version
echo $JAVA_HOME
```

## Building the APK

### 1. Set Keystore Passwords
You need to provide keystore passwords. Choose one of these methods:

#### Method A: Environment Variables (Recommended)
```bash
export KEYSTORE_PASSWORD="your_keystore_password"
export KEY_PASSWORD="your_key_password"
```

#### Method B: Create gradle.properties.local
```bash
# Create a local properties file (not committed to git)
echo "KEYSTORE_PASSWORD=your_keystore_password" > gradle.properties.local
echo "KEY_PASSWORD=your_key_password" >> gradle.properties.local
```

### 2. Build Commands

#### Production APK (for Play Store)
```bash
./gradlew assembleProductionRelease
```

#### Integration APK (for testing)
```bash
./gradlew assembleIntegrationRelease
```

#### Build Both Variants
```bash
./build-both.bat  # Windows
# or manually run both commands above
```

### 3. Find Your APKs
After successful build, APKs will be located at:
- **Production**: `app/build/outputs/apk/production/release/app-production-release.apk`
- **Integration**: `app/build/outputs/apk/integration/release/app-integration-release.apk`

## Troubleshooting

### Common Issues

1. **"Unable to locate a Java Runtime"**
   - Install Java as described above
   - Verify JAVA_HOME is set correctly

2. **"Keystore password missing"**
   - Set environment variables or create gradle.properties.local
   - Make sure passwords match your keystore

3. **"Build failed"**
   - Run `./gradlew clean` first
   - Check that all dependencies are available
   - Verify Android SDK is installed (if using Android Studio)

### Clean Build
If you encounter issues, try a clean build:
```bash
./gradlew clean
./gradlew assembleProductionRelease
```

## Next Steps After Building

1. **Test the APK**: Install on a test device
2. **Upload to Play Store**: Use the production APK
3. **Set up CI/CD**: Automate builds with GitHub Actions

## Security Notes

- Never commit keystore passwords to git
- Keep your keystore file secure and backed up
- Use different keystores for development and production if needed