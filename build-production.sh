#!/bin/bash

# Source the environment
source ~/.zshrc

# Set keystore passwords
export KEYSTORE_PASSWORD="Stupidqpid3363!"
export KEY_PASSWORD="Stupidqpid3363!"

# Build the production APK
echo "Building Quizee Production APK..."
./gradlew assembleProductionRelease

echo "Build complete! APK location:"
echo "app/build/outputs/apk/production/release/app-production-release.apk"