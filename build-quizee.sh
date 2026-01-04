#!/bin/bash

# Source the environment
source ~/.zshrc

# Set keystore passwords
export KEYSTORE_PASSWORD="Stupidqpid3363!"
export KEY_PASSWORD="Stupidqpid3363!"

# Build the integration APK for testing
echo "Building Quizee Integration APK..."
./gradlew assembleIntegrationRelease

echo "Build complete! APK location:"
echo "app/build/outputs/apk/integration/release/app-integration-release.apk"