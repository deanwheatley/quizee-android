@echo off
echo Building both Production and Integration APKs...
echo.

echo Building Production APK...
call gradlew.bat assembleProductionRelease
if %errorlevel% neq 0 (
    echo Production build failed!
    exit /b %errorlevel%
)

echo.
echo Building Integration APK...
call gradlew.bat assembleIntegrationRelease
if %errorlevel% neq 0 (
    echo Integration build failed!
    exit /b %errorlevel%
)

echo.
echo Both builds completed successfully!
echo Production APK: app\build\outputs\apk\production\release\app-production-release.apk
echo Integration APK: app\build\outputs\apk\integration\release\app-integration-release.apk