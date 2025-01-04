import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  bool isLocationEnabled = false;
  LocationPermission locationPermission = LocationPermission.denied;
  Position? currentPosition;

  // Check if location services are enabled
  Future<void> checkLocationService() async {
    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    update();
  }

  // Check and request location permission
  Future<void> requestLocationPermission() async {
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
    update();
  }

  // Get current location
  Future<Position> fetchCurrentLocation() async {
    try {
      await checkLocationService();
      if (!isLocationEnabled) {
        throw Exception("Location services are disabled.");
      }

      await requestLocationPermission();
      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) {
        throw Exception("Location permission denied.");
      }

      return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return Position(
        latitude: 6.927079,
        longitude: 79.861244,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      );
    }
  }
}
