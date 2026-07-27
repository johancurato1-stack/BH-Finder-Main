import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

//============================================================================
//! LOCATION RESULT
//============================================================================

class LocationResult {
  const LocationResult({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String address;
  final double latitude;
  final double longitude;
}

//============================================================================
//! LOCATION SERVICE
//============================================================================

class LocationService {
  //============================================================================
  //! DETECT CURRENT LOCATION
  //============================================================================

  Future<LocationResult> detectCurrentLocation() async {
    final permission = await _requestPermission();

    if (!permission) {
      throw Exception('Location permission denied.');
    }

    final position = await Geolocator.getCurrentPosition();

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final place = placemarks.first;

    final address = [
      place.street,
      place.subLocality,
      place.locality,
      place.administrativeArea,
    ].where((e) => e != null && e.trim().isNotEmpty).join(', ');

    return LocationResult(
      address: address,
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  //============================================================================
  //! GEOCODE MANUAL ADDRESS
  //============================================================================

  Future<LocationResult> geocodeAddress({
    required String province,
    required String city,
    required String barangay,
    String street = '',
    String landmark = '',
  }) async {
    final query = [
      street,
      barangay,
      city,
      province,
      landmark,
    ].where((e) => e.trim().isNotEmpty).join(', ');

    final locations = await locationFromAddress(query);

    if (locations.isEmpty) {
      throw Exception('Address not found.');
    }

    final location = locations.first;

    return LocationResult(
      address: query,
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }

  //============================================================================
  //! REQUEST PERMISSION
  //============================================================================

  Future<bool> _requestPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return false;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}
