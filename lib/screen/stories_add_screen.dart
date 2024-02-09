import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/provider/page_provider.dart';
import 'package:flutter_intermediate_story_app/provider/story_provider.dart';
import 'package:flutter_intermediate_story_app/services/flavor_config.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class StoriesAddScreen extends StatefulWidget {
  const StoriesAddScreen({
    super.key,
    required this.onUpload,
    required this.onLocation,
  });

  final Function() onUpload;
  final Function() onLocation;

  @override
  State<StoriesAddScreen> createState() => _StoriesAddScreenState();
}

class _StoriesAddScreenState extends State<StoriesAddScreen> {
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LatLng? myLocation;
  geo.Placemark? placemark;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> getMyLocation(double lat, double lon) async {
    final info = await geo.placemarkFromCoordinates(lat, lon);

    setState(() {
      placemark = info[0];
      myLocation = LatLng(lat, lon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Story')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (context.watch<StoryProvider>().imagePath == null)
                const Align(child: Icon(Icons.image, size: 100))
              else
                _showImage(),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _onCameraView,
                      child: const Text('Camera'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _onGalleryView,
                      child: const Text('Gallery'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Form(
                key: formKey,
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your description.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              if (placemark != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    '${placemark?.subLocality}, ${placemark?.locality}, ${placemark?.postalCode}, ${placemark?.country}',
                  ),
                ),
              if (FlavorConfig.instance.flavor == FlavorType.paid)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ElevatedButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      widget.onLocation();

                      final dataString =
                          await context.read<PageProvider>().waitForResult();

                      if (dataString.isNotEmpty) {
                        final data = jsonDecode(dataString);
                        await getMyLocation(data['lat'], data['lon']);
                      }
                      setState(() {});
                    },
                    child: const Text('Lampirkan Lokasi Anda'),
                  ),
                ),
              const SizedBox(height: 12),
              if (context.watch<StoryProvider>().isLoadingStoriesUpload)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    if (formKey.currentState!.validate()) {
                      if (context.read<StoryProvider>().imagePath != null) {
                        final storyRead = context.read<StoryProvider>();
                        final result = await storyRead.uploadStory(
                          description: descriptionController.text,
                          latitude: myLocation?.latitude,
                          longitude: myLocation?.longitude,
                        );
                        scaffoldMessenger.showSnackBar(
                          SnackBar(content: Text('${result.message}')),
                        );
                        if (result.error != true) {
                          descriptionController.clear();
                          widget.onUpload();
                          storyRead.setUploadStatus(value: true);
                          // if (context.mounted) {
                          //   context.read<PageProvider>().returnData('success');
                          // }
                        }
                      } else {
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('Anda belum memilih foto'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Upload'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _onGalleryView() async {
    final provider = context.read<StoryProvider>();
    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;

    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      provider
        ..setImageFile(pickedFile)
        ..setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final provider = context.read<StoryProvider>();
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    if (pickedFile != null) {
      provider
        ..setImageFile(pickedFile)
        ..setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    final imagePath = context.read<StoryProvider>().imagePath;
    return kIsWeb
        ? CachedNetworkImage(
            imageUrl: imagePath.toString(),
            fit: BoxFit.contain,
            progressIndicatorBuilder: (context, url, progress) {
              return CircularProgressIndicator(
                value: progress.progress,
              );
            },
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
          )
        : Image.file(
            File(imagePath.toString()),
            fit: BoxFit.contain,
          );
  }
}
