import 'package:flutter/material.dart';

import '../Constants/Colors.dart';
import '../Views/BoardingScreen/BoardingScreen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yukti-idea',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        useMaterial3: true, scaffoldBackgroundColor: scaffoldColor,
        // Below to get horizontal sliding transitions for routes.
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      home: BoardingScreen(),
    );
  }
}
