import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/widgets/placemark.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.latitude, this.longitude});

  final double? latitude;
  final double? longitude;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  geo.Placemark? placemark;

  @override
  void initState() {
    super.initState();
    // initData();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  Future<void> initData() async {
    final info =
        await geo.placemarkFromCoordinates(widget.latitude!, widget.longitude!);
    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    placemark = place;

    final marker = Marker(
      markerId: const MarkerId('myLocation'),
      position: LatLng(widget.latitude!, widget.longitude!),
      infoWindow: InfoWindow(title: street, snippet: address),
    );

    markers.add(marker);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps')),
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.latitude!, widget.longitude!),
                zoom: 18,
              ),
              markers: markers,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              onMapCreated: (controller) async {
                final info = await geo.placemarkFromCoordinates(
                  widget.latitude!,
                  widget.longitude!,
                );

                final place = info[0];
                final street = place.street!;
                final address =
                    '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

                setState(() {
                  placemark = place;
                });

                final marker = Marker(
                  markerId: const MarkerId('myLocation'),
                  position: LatLng(widget.latitude!, widget.longitude!),
                  infoWindow: InfoWindow(title: street, snippet: address),
                );

                setState(() {
                  mapController = controller;
                  markers.add(marker);
                });
              },
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Column(
                children: [
                  FloatingActionButton.small(
                    heroTag: 'zoom-in',
                    onPressed: () {
                      mapController.animateCamera(CameraUpdate.zoomIn());
                    },
                    child: const Icon(Icons.add),
                  ),
                  FloatingActionButton.small(
                    heroTag: 'zoom-out',
                    onPressed: () {
                      mapController.animateCamera(CameraUpdate.zoomOut());
                    },
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),
            if (placemark == null)
              const SizedBox()
            else
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Placemark(placemark: placemark!),
              ),
          ],
        ),
      ),
    );
  }
}
