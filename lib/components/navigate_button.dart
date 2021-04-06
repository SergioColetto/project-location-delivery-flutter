import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:provider/provider.dart';

class NavigateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, provider, child) => FloatingActionButton.extended(
          icon: Icon(Icons.navigation_outlined),
          label: Text("NAVIGATE"),
          onPressed: () async {
            provider.launchRoute(context);
          }),
    );
  }
}
