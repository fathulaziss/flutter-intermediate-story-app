import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/provider/page_provider.dart';
import 'package:flutter_intermediate_story_app/widgets/placemark.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.onSelectLocation});

  final Function() onSelectLocation;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  geo.Placemark? placemark;
  LatLng myLocation = const LatLng(0, 0);

  bool isLoading = false;

  @override
  void initState() {
    onMyLocationButtonPress();
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  Future<void> initData() async {
    final location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    isLoading = true;
    setState(() {});

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        if (kDebugMode) {
          print('Location services is not available');
        }
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        if (kDebugMode) {
          print('Location permission is denied');
        }
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    defineMarker(latLng, street!, address);

    setState(() {
      placemark = place;
      myLocation = latLng;
      isLoading = false;
    });
  }

  Future<void> onMyLocationButtonPress() async {
    final location = Location();
    late LocationData locationData;

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
      myLocation = latLng;
    });

    defineMarker(latLng, street!, address);
    await mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId('source'),
      position: latLng,
      infoWindow: InfoWindow(title: street, snippet: address),
    );
    setState(() {
      markers
        ..clear()
        ..add(marker);
    });
  }

  Future<void> onLongPressGoogleMap(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
      myLocation = latLng;
    });

    defineMarker(latLng, street, address);

    await mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps')),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: myLocation,
                      zoom: 18,
                    ),
                    markers: markers,
                    // myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    onMapCreated: (controller) {
                      setState(() {
                        mapController = controller;
                      });
                    },
                    onLongPress: (LatLng latLng) async {
                      await onLongPressGoogleMap(latLng);
                    },
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: FloatingActionButton(
                      child: const Icon(Icons.my_location),
                      onPressed: () async {
                        await onMyLocationButtonPress();
                      },
                    ),
                  ),
                  if (placemark == null)
                    const SizedBox()
                  else
                    Positioned(
                      bottom: 16,
                      right: 16,
                      left: 16,
                      child: Column(
                        children: [
                          Placemark(placemark: placemark!),
                          ElevatedButton(
                            onPressed: () {
                              final data = {
                                'lat': myLocation.latitude,
                                'lon': myLocation.longitude,
                              };
                              widget.onSelectLocation();
                              context
                                  .read<PageProvider>()
                                  .returnData(jsonEncode(data));
                            },
                            child: const Text('Pilih Lokasi'),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
