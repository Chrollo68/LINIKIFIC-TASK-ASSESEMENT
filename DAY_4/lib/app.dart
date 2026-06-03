import 'package:flutter/material.dart';

import 'screens/dashboard_screen.dart';
import 'screens/ecommerce_grid_screen.dart';
import 'screens/home_screen.dart';
import 'screens/instagram_post_screen.dart';
import 'screens/list_builder_screen.dart';
import 'screens/responsive_gallery_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/stack_demo_screen.dart';
import 'screens/whatsapp_chat_screen.dart';
import 'theme/app_theme.dart';

class FlutterLayoutShowcaseApp extends StatelessWidget {
  const FlutterLayoutShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layout Showcase',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        InstagramPostScreen.routeName: (_) => const InstagramPostScreen(),
        WhatsAppChatScreen.routeName: (_) => const WhatsAppChatScreen(),
        EcommerceGridScreen.routeName: (_) => const EcommerceGridScreen(),
        SettingsScreen.routeName: (_) => const SettingsScreen(),
        DashboardScreen.routeName: (_) => const DashboardScreen(),
        ListBuilderScreen.routeName: (_) => const ListBuilderScreen(),
        ResponsiveGalleryScreen.routeName: (_) =>
            const ResponsiveGalleryScreen(),
        StackDemoScreen.routeName: (_) => const StackDemoScreen(),
      },
    );
  }
}
