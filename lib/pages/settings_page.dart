import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Destinations'),
        ),
      ),
    );
  }
}
