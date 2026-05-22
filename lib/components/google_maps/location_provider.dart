import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:projecto_registagro/repositories/geolocation.dart';

class SourceLocationProvider extends ChangeNotifier {
  gmaps.LatLng? _currentLatLng;
  String _currentAddress = '';
  bool _isLoading = false;
  String? _error;
  late BuildContext context;

  gmaps.LatLng? get currentLatLng => _currentLatLng;
  String get currentAddress => _currentAddress;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCurrentLocation(String orderId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      /*LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _error = 'Localização não permitida';
        _isLoading = false;
        notifyListeners();
        return;
      }*/

      final coordinates = await GeoLocation().carrierCoordinates(
        orderId,
      );

      /*final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );*/

      _currentLatLng = gmaps.LatLng(coordinates[0], coordinates[1]);
      _currentAddress = await _getAddress(_currentLatLng!);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateLocation(gmaps.LatLng latLng) async {
    _currentLatLng = latLng;
    _currentAddress = await _getAddress(latLng);
    notifyListeners();
  }

  Future<String> _getAddress(gmaps.LatLng latLng) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isEmpty) return 'Local desconhecido';

      final p = placemarks.first;

      final partes = <String>[];
      if (p.street?.isNotEmpty == true) partes.add(p.street!);
      if (p.subLocality?.isNotEmpty == true) partes.add(p.subLocality!);
      if (p.locality?.isNotEmpty == true) partes.add(p.locality!);
      if (p.administrativeArea?.isNotEmpty == true)
        partes.add(p.administrativeArea!);

      return partes.isNotEmpty ? partes.join(', ') : 'Local desconhecido';
    } catch (_) {
      return 'Local';
    }
  }
}
