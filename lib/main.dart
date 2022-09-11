import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:retro_snake_game/constants/colors.dart';
import 'package:retro_snake_game/provider/menu_provider.dart';
import 'package:retro_snake_game/provider/theme_provider.dart';
import 'package:retro_snake_game/screen/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeModeProvider()),
        ChangeNotifierProvider(
          create: (context) => MenuAndSettingsProvider(),
        )
      ],
      child: const SnakeGame(),
    );
  }
}

class SnakeGame extends StatelessWidget {
  const SnakeGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake II',
      themeMode: Provider.of<ThemeModeProvider>(context).themeMode,
      builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          fontFamily: "Dotted2",
          primarySwatch: Colors.blue,
          canvasColor: AppColors.colorGrey),
      theme: ThemeData(
          fontFamily: "Dotted2",
          primarySwatch: Colors.blue,
          canvasColor: AppColors.colorYello),
      home: const Scaffold(
        body: WelcomeScreen(),
      ),
    );
  }
}
