import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/components/app_theme.dart';
import 'package:happy_postcode_flutter/pages/search_delegate_page.dart';
import 'package:happy_postcode_flutter/pages/settings_page.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(PostcodeApp());

class PostcodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new AddressProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Location Delivery',
        initialRoute: '/',
        routes: {
          '/': (_) => SearchDelegatePage(),
          'setting': (_) => SettingsPage(),
        },
        theme: AppTheme.buildTheme(),
      ),
    );
  }
}
