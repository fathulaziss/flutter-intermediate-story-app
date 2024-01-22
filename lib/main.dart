import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/common/url_strategy.dart';
import 'package:flutter_intermediate_story_app/data/repositories/auth_repository.dart';
import 'package:flutter_intermediate_story_app/provider/auth_provider.dart';
import 'package:flutter_intermediate_story_app/routes/page_information_parser.dart';
import 'package:flutter_intermediate_story_app/routes/router_delegate.dart';

void main() {
  usePathUrlStrategy();
  runApp(const StoryApp());
}

class StoryApp extends StatefulWidget {
  const StoryApp({super.key});

  @override
  State<StoryApp> createState() => _MyAppState();
}

class _MyAppState extends State<StoryApp> {
  late MyRouterDelegate myRouterDelegate;
  late AuthProvider authProvider;
  late MyRouteInformationParser myRouteInformationParser;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    authProvider = AuthProvider(authRepository);
    myRouterDelegate = MyRouterDelegate(authRepository);
    myRouteInformationParser = MyRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerDelegate: myRouterDelegate,
      routeInformationParser: myRouteInformationParser,
      backButtonDispatcher: RootBackButtonDispatcher(),
    );
  }
}
