# DAY_10 Flutter Image Handling

This Flutter project demonstrates image handling using local assets, network caching, and image picking from gallery/camera.

## What is included

- `Image.asset` for local asset display
- `CachedNetworkImage` for caching network images
- `Image.file` for picked gallery/camera images
- `ImagePicker` integration for gallery and camera access
- `InteractiveViewer` zoom for picked images
- `ChoiceChip` controls to test `BoxFit` behavior
- placeholder + error widgets for network image loading
- a small filter preview for selected images

## Packages used

- `image_picker`
- `cached_network_image`

## Assets

Local images are stored under `assets/images/` and registered in `pubspec.yaml`.

## Permissions

- Android: `android.permission.CAMERA` in `android/app/src/main/AndroidManifest.xml`
- iOS: `NSCameraUsageDescription` and `NSPhotoLibraryUsageDescription` in `ios/Runner/Info.plist`

## Run the app

```bash
cd "d:\LINIKIFIC TASK ASSESEMENT\DAY_10"
flutter pub get
flutter run
```

## Notes

- On an emulator or simulator, camera support may be limited.
- The upload flow is simulated with a placeholder Snackbar.
- Change `BoxFit` values to see asset and picked image resizing behavior.
