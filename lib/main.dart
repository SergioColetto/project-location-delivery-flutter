import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/components/app_theme.dart';
import 'package:happy_postcode_flutter/pages/main_page.dart';
import 'package:happy_postcode_flutter/pages/settings_page.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:happy_postcode_flutter/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new AddressProvider()),
        ChangeNotifierProvider(create: (_) => new FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => new ThemeChanger(2)),
      ],
      child: PostcodeApp(),
    ),
  );
}

class PostcodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location Delivery',
      initialRoute: '/',
      routes: {
        '/': (_) => MainPage(),
        'setting': (_) => SettingsPage(),
      },
      theme: currentTheme,
    );
  }
}
