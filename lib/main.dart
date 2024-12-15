import 'package:PP_787/pages/home_page.dart';
import 'package:PP_787/pages/onboarding_page.dart';
import 'package:PP_787/pages/splash_page.dart';
import 'package:PP_787/remote_config.dart';
import 'package:PP_787/storages/isar.dart';
import 'package:PP_787/storages/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_app_info/flutter_app_info.dart';

import 'navigation/routes.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color.fromARGB(1, 1, 1, 1),
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark));

  await RemoteConfigService.init();
  await AppSharedPreferences.init();
  await AppIsarDatabase.init();

  final isFirstRun = AppSharedPreferences.getIsFirstRun() ?? true;
  if (isFirstRun) await AppSharedPreferences.setNotFirstRun();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    AppInfo(
      data: await AppInfoData.get(),
      child: MyApp(isFirstRun: isFirstRun),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstRun});

  final bool isFirstRun;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onUnknownRoute: (settings) => CupertinoPageRoute(
        builder: (context) => const HomePage(),
      ),
      onGenerateRoute: (settings) => switch (settings.name) {
        AppRoutes.onBoarding => CupertinoPageRoute(
          settings: settings,
          builder: (context) => const OnboardingPage(),
        ),
        AppRoutes.home => CupertinoPageRoute(
          settings: settings,
          builder: (context) => const HomePage(),
        ),

        _ => null,
      },
      home: SplashPage(
      isFirstRun: isFirstRun,
    ),);
  }
}


