import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/provider/auth_provider.dart';
import 'package:flutter_intermediate_story_app/provider/story_provider.dart';
import 'package:flutter_intermediate_story_app/services/flavor_config.dart';
import 'package:flutter_intermediate_story_app/widgets/stories_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onLogout,
    required this.onStoryDetail,
    required this.onAddStory,
  });

  final Function() onLogout;
  final Function(String) onStoryDetail;
  final Function() onAddStory;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final storyRead = context.read<StoryProvider>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (storyRead.pageItems != null) {
          storyRead.getStories();
        }
      }
    });

    Future.microtask(() async => storyRead.getStories());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlavorConfig.instance.values.titleApp),
        actions: [
          if (context.watch<AuthProvider>().isLoadingLogout)
            const Center(child: CircularProgressIndicator(color: Colors.white))
          else
            IconButton(
              onPressed: () async {
                final scaffoldMessenger = ScaffoldMessenger.of(context);

                final authRead = context.read<AuthProvider>();
                await authRead.logout();

                scaffoldMessenger.showSnackBar(
                  const SnackBar(content: Text('Berhasil Logout')),
                );

                widget.onLogout();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
        ],
      ),
      floatingActionButton: IconButton(
        onPressed: () async {
          context.read<StoryProvider>()
            ..setImageFile(null)
            ..setImagePath(null)
            ..setPageItem(1);

          widget.onAddStory();
        },
        icon: const Icon(
          Icons.add_circle,
          size: 48,
          color: Colors.deepPurple,
        ),
      ),
      body: Consumer<StoryProvider>(
        builder: (context, storyProvider, _) {
          if (storyProvider.listStory.isEmpty &&
              storyProvider.isLoadingStories) {
            return const Center(child: CircularProgressIndicator());
          } else if (storyProvider.listStory.isNotEmpty &&
              !storyProvider.isLoadingStories) {
            final listStory = storyProvider.listStory;

            return ListView.builder(
              controller: scrollController,
              itemCount: listStory.length,
              itemBuilder: (context, index) {
                final data = listStory[index];

                if (data == listStory.last && storyProvider.pageItems != null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return StoriesCard(
                  data: data,
                  onTap: () {
                    widget.onStoryDetail(data.id!);
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('Data tidak ditemukan'));
          }
        },
      ),
    );
  }
}
