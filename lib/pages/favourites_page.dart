import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/components/centered_message.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, provider, child) => Scaffold(
        body: Container(
          child: CenteredMessage(
            'Favourites',
            icon: Icons.construction,
          ),
        ),
      ),
    );
  }
}
