import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_intermediate_story_app/data/repositories/auth_repository.dart';
import 'package:flutter_intermediate_story_app/data/repositories/story_repository.dart';
import 'package:flutter_intermediate_story_app/provider/auth_provider.dart';
import 'package:flutter_intermediate_story_app/provider/localization_provider.dart';
import 'package:flutter_intermediate_story_app/provider/page_provider.dart';
import 'package:flutter_intermediate_story_app/provider/story_provider.dart';
import 'package:flutter_intermediate_story_app/routes/page_information_parser.dart';
import 'package:flutter_intermediate_story_app/routes/router_delegate.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate myRouterDelegate;
  late MyRouteInformationParser myRouteInformationParser;
  late PageProvider pageProvider;
  late AuthProvider authProvider;
  late StoryProvider storyProvider;
  late LocalizationProvider localizationProvider;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    final storyRepository = StoryRepository();

    myRouterDelegate = MyRouterDelegate(authRepository);
    myRouteInformationParser = MyRouteInformationParser();
    pageProvider = PageProvider();
    authProvider = AuthProvider(authRepository);
    storyProvider = StoryProvider(storyRepository);
    localizationProvider = LocalizationProvider();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => pageProvider),
        ChangeNotifierProvider(create: (context) => authProvider),
        ChangeNotifierProvider(create: (context) => storyProvider),
        ChangeNotifierProvider(create: (context) => localizationProvider),
      ],
      builder: (context, child) {
        final localizationProvider = Provider.of<LocalizationProvider>(context);

        return MaterialApp.router(
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
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localizationProvider.locale,
        );
      },
    );
  }
}
