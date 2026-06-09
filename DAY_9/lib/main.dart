import 'package:flutter/material.dart';
import 'screens/custom_transition_screen.dart';
import 'screens/explicit_animations_screen.dart';
import 'screens/hero_animations_screen.dart';
import 'screens/home_screen.dart';
import 'screens/implicit_animations_screen.dart';

void main() {
  runApp(const AnimationPlaygroundApp());
}

class AnimationPlaygroundApp extends StatelessWidget {
  const AnimationPlaygroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DAY 9 Flutter Animations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        ImplicitAnimationsScreen.routeName: (context) =>
            const ImplicitAnimationsScreen(),
        ExplicitAnimationsScreen.routeName: (context) =>
            const ExplicitAnimationsScreen(),
        HeroAnimationsScreen.routeName: (context) =>
            const HeroAnimationsScreen(),
        CustomTransitionScreen.routeName: (context) =>
            const CustomTransitionScreen(),
      },
    );
  }
}
