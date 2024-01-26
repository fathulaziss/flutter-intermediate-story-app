import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/model/stories_model.dart';

class StoriesCard extends StatelessWidget {
  const StoriesCard({super.key, required this.data, required this.onTap});

  final StoriesModel data;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: Colors.amber,
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: data.photoUrl!,
              width: 50,
              height: 50,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(data.description!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
