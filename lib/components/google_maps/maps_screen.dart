import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart' as places;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:projecto_registagro/components/google_maps/location_provider.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  gmaps.GoogleMapController? _mapController;

  gmaps.LatLng? _destinationLatLng;
  String? etaText;
  String? distanceText;

  gmaps.LatLng? _userLatLng;
  gmaps.LatLng _pickupLatLng = const gmaps.LatLng(37.0, 122.0);
  static const gmaps.LatLng _defaultLatLng = gmaps.LatLng(37.0, 122.0);

  final String _googleApiKey = 'AIzaSyBr5KqYWjgKnRFLX2P9b0-U8_Ap79KRyIk';
  late final places.FlutterGooglePlacesSdk _places;
  Set<gmaps.Polyline> _polylines = {};
  bool isLoading = false;
  bool _isConfirming = false;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _places = places.FlutterGooglePlacesSdk(_googleApiKey);

    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
    _slideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final loc = context.read<SourceLocationProvider>();
      await loc.fetchCurrentLocation();

      if (!mounted) return;

      if (loc.currentLatLng != null) {
        setState(() {
          _userLatLng = loc.currentLatLng;
          _pickupLatLng = loc.currentLatLng!;
        });
        _mapController?.animateCamera(
          gmaps.CameraUpdate.newLatLngZoom(loc.currentLatLng!, 16),
        );
      }
      _slideController.forward();
    });
  }

  Future<void> _updateRouteIfPossible() async {
    if (_destinationLatLng == null || _pickupLatLng == _defaultLatLng) {
      setState(() {
        _polylines = {};
        etaText = null;
        distanceText = null;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final loc = context.watch<SourceLocationProvider>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: gmaps.GoogleMap(
                initialCameraPosition: gmaps.CameraPosition(target: _userLatLng ?? _defaultLatLng, zoom: 16),
                onMapCreated: (controller) {
                  _mapController = controller;
                  if (_userLatLng != null) {
                    controller.animateCamera(gmaps.CameraUpdate.newLatLngZoom(_userLatLng!, 16));
                  }
                },
                markers: {
                  gmaps.Marker(
                    markerId: const gmaps.MarkerId('pickup'),
                    position: _pickupLatLng,
                    icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueGreen),
                    infoWindow: const gmaps.InfoWindow(title: "📍 Partida"),
                  ),
                  if (_destinationLatLng != null)
                    gmaps.Marker(
                      markerId: const gmaps.MarkerId('destination'),
                      position: _destinationLatLng!,
                      icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueRed),
                      infoWindow: const gmaps.InfoWindow(title: "🏁 Destino"),
                    ),
                },
                polylines: _polylines,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                compassEnabled: false,
                onTap: (latLng) async {
                  HapticFeedback.lightImpact();
                  await context.read<SourceLocationProvider>().updateLocation(latLng);
                  setState(() => _pickupLatLng = latLng);
                  await _updateRouteIfPossible();
                  _mapController?.animateCamera(gmaps.CameraUpdate.newLatLng(latLng));
                },
              ),
            ),

            if (loc.isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black, 
                      strokeWidth: 2.5
                    )
                  ),
                ),
              ),

            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              left: 16,
              right: 16,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 16, offset: const Offset(0, 4))],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 14),
                    loc.isLoading
                        ? const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black38))
                        : Container(
                            width: 10, height: 10,
                            decoration: BoxDecoration(
                              color: loc.error != null ? Colors.red.shade400 : Colors.green.shade600,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [BoxShadow(color: (loc.error != null ? Colors.red : Colors.green).withOpacity(0.4), blurRadius: 6)],
                            ),
                          ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        loc.isLoading ? 'A obter localização...'
                            : loc.error ?? (loc.currentAddress.isNotEmpty ? loc.currentAddress : 'Toque no mapa para escolher'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: loc.error != null ? Colors.red.shade400 : Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 160 + bottomPad,
              right: 16,
              child: _CircleButton(
                onTap: () {
                  HapticFeedback.lightImpact();
                  if (_userLatLng != null) {
                    _mapController?.animateCamera(gmaps.CameraUpdate.newLatLngZoom(_userLatLng!, 16));
                  }
                },
                child: const Icon(Icons.my_location, size: 20, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    _mapController?.dispose();
    super.dispose();
  }
}

class _CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const _CircleButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46, height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 3))],
        ),
        child: Center(child: child),
      ),
    );
  }
}