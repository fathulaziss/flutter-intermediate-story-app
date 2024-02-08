import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/model/stories_model.dart';
import 'package:flutter_intermediate_story_app/provider/story_provider.dart';
import 'package:provider/provider.dart';

class StoriesDetailScreen extends StatefulWidget {
  const StoriesDetailScreen({
    super.key,
    required this.storyId,
    required this.onOpenMap,
  });

  final String storyId;
  final Function(double latitude, double longitude) onOpenMap;

  @override
  State<StoriesDetailScreen> createState() => _StoriesDetailScreenState();
}

class _StoriesDetailScreenState extends State<StoriesDetailScreen> {
  StoriesModel? stories;

  @override
  void initState() {
    getDetailStories();
    super.initState();
  }

  Future<void> getDetailStories() async {
    final storyRead = context.read<StoryProvider>();
    final result = await storyRead.getStoriesDetail(widget.storyId);
    if (result.error != true) {
      stories = result.story;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Story Detail')),
      body: context.watch<StoryProvider>().isLoadingStoriesDetail
          ? const Center(child: CircularProgressIndicator())
          : stories != null
              ? Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: stories!.photoUrl!,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) {
                        return CircularProgressIndicator(
                          value: progress.progress,
                        );
                      },
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      },
                    ),
                    const SizedBox(width: 12),
                    Text(
                      stories!.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(stories!.description!),
                    Text('${stories?.lat ?? '-'}'),
                    Text('${stories?.lon ?? '-'}'),
                    ElevatedButton(
                      onPressed: () {
                        widget.onOpenMap(stories?.lat ?? 0, stories?.lon ?? 0);
                      },
                      child: const Text('Buka Peta'),
                    ),
                  ],
                )
              : const Center(child: Text('Data tidak ditemukan')),
    );
  }
}
