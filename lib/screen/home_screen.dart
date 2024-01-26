import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/model/stories_model.dart';
import 'package:flutter_intermediate_story_app/provider/auth_provider.dart';
import 'package:flutter_intermediate_story_app/provider/story_provider.dart';
import 'package:flutter_intermediate_story_app/widgets/stories_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onLogout});

  final Function() onLogout;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StoriesModel>? listStory;

  @override
  void initState() {
    getStories();
    super.initState();
  }

  Future<void> getStories() async {
    final storyRead = context.read<StoryProvider>();
    final result = await storyRead.getStories();
    if (result.listStory!.isNotEmpty) {
      listStory = result.listStory;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story'),
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
        onPressed: () {},
        icon: const Icon(
          Icons.add_circle,
          size: 48,
          color: Colors.deepPurple,
        ),
      ),
      body: context.watch<StoryProvider>().isLoadingStories
          ? const Center(child: CircularProgressIndicator())
          : listStory!.isNotEmpty
              ? ListView.builder(
                  itemCount: listStory?.length,
                  itemBuilder: (context, index) {
                    final data = listStory![index];
                    return StoriesCard(data: data, onTap: () {});
                  },
                )
              : const SizedBox(),
    );
  }
}
