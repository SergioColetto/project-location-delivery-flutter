import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:provider/provider.dart';

class NavigateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, provider, child) => FloatingActionButton(
          elevation: 0,
          child: Icon(
            Icons.navigation_outlined,
            color: Colors.white,
          ),
          onPressed: () async {
            provider.launchRoute(context);
          }),
    );
  }
}
