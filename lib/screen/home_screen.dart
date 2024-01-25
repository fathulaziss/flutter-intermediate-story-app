import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onLogout});

  final Function() onLogout;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story'),
        actions: [
          context.watch<AuthProvider>().isLoadingLogout
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white))
              : IconButton(
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
    );
  }
}
