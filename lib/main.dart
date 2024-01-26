import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/common/url_strategy.dart';
import 'package:flutter_intermediate_story_app/data/repositories/auth_repository.dart';
import 'package:flutter_intermediate_story_app/data/repositories/story_repository.dart';
import 'package:flutter_intermediate_story_app/provider/auth_provider.dart';
import 'package:flutter_intermediate_story_app/provider/story_provider.dart';
import 'package:flutter_intermediate_story_app/routes/page_information_parser.dart';
import 'package:flutter_intermediate_story_app/routes/page_manager.dart';
import 'package:flutter_intermediate_story_app/routes/router_delegate.dart';
import 'package:provider/provider.dart';

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
  late StoryProvider storyProvider;
  late PageManager routeProvider;
  late MyRouteInformationParser myRouteInformationParser;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    final storyRepository = StoryRepository();
    authProvider = AuthProvider(authRepository);
    storyProvider = StoryProvider(storyRepository);
    routeProvider = PageManager();
    myRouterDelegate = MyRouterDelegate(authRepository);
    myRouteInformationParser = MyRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => routeProvider),
        ChangeNotifierProvider(create: (context) => authProvider),
        ChangeNotifierProvider(create: (context) => storyProvider),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(
            color: Colors.deepPurple,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        routerDelegate: myRouterDelegate,
        routeInformationParser: myRouteInformationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );

    // return ChangeNotifierProvider(
    //   create: (context) => authProvider,
    //   child: MaterialApp.router(
    //     theme: ThemeData(
    //       useMaterial3: true,
    //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //       appBarTheme: const AppBarTheme(
    //         color: Colors.deepPurple,
    //         titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
    //         iconTheme: IconThemeData(color: Colors.white),
    //       ),
    //     ),
    //     routerDelegate: myRouterDelegate,
    //     routeInformationParser: myRouteInformationParser,
    //     backButtonDispatcher: RootBackButtonDispatcher(),
    //   ),
    // );
  }
}
