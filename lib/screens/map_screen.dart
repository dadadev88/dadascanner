import 'dart:async';

import 'package:dadascanner/models/scan_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = 'map_detail';

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  MapType _mapType = MapType.hybrid;

  @override
  Widget build(BuildContext context) {
    Scan scan = ModalRoute.of(context)!.settings.arguments as Scan;

    CameraPosition position = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(scan.description == '' ? 'Location' : scan.description),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: GoogleMap(
          mapType: _mapType,
          initialCameraPosition: position,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {getMarker(scan)},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeLayerType,
        child: const Icon(Icons.layers_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Marker getMarker(Scan scan) {
    return Marker(
      markerId: const MarkerId('My location'),
      position: scan.getLatLng(),
    );
  }

  void _changeLayerType() {
    setState(() {
      _mapType = _mapType == MapType.hybrid ? MapType.normal : MapType.hybrid;
    });
  }
}
