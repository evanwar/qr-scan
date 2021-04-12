import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:qr_reader/models/scan_model.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType typemap = MapType.normal;
  @override
  Widget build(BuildContext context) {
    ScanModel scanModel = ModalRoute.of(context).settings.arguments;

    final CameraPosition _kGooglePlex =
        CameraPosition(target: scanModel.getLatLng(), zoom: 18.0, tilt: 50.0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
              icon: Icon(Icons.location_pin),
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: scanModel.getLatLng(),
                        zoom: 18.0,
                        tilt: 50.0)));
              })
        ],
      ),
      body: GoogleMap(
          zoomControlsEnabled: false,
          markers: scanModel.getmarkers(),
          mapType: typemap,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.layers),
          onPressed: () {
            if (typemap == MapType.normal) {
              typemap = MapType.satellite;
            } else {
              typemap = MapType.normal;
            }

            setState(() {});
          }),
    );
  }
}
