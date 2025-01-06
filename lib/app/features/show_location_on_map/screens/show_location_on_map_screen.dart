import 'package:enjaz_app/core/utils/string_manager.dart';
import 'package:enjaz_app/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class showLocationOnMapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const showLocationOnMapScreen({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  _showLocationOnMapScreenState createState() =>
      _showLocationOnMapScreenState();
}

class _showLocationOnMapScreenState extends State<showLocationOnMapScreen> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    final LatLng customLocation = LatLng(widget.latitude, widget.longitude);

    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.locationText),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: customLocation,
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('customLocation'),
            position: customLocation,
            infoWindow: const InfoWindow(
              title: 'Location',
              snippet: 'Location Selected',
            ),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showLocationOnMapScreen(
        latitude: 24.7136, // خط العرض (مثال: الرياض، السعودية)
        longitude: 46.6753, // خط الطول (مثال: الرياض، السعودية)
      ),
    ),
  );
}
