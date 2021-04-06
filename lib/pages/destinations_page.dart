import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/components/centered_message.dart';
import 'package:happy_postcode_flutter/components/destinatons_list.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:provider/provider.dart';

class DestinationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, provider, child) => Scaffold(
        body: provider.totalInRoute > 0
            ? DestinationsList()
            : Container(
                child: CenteredMessage(
                  'Destinations',
                  icon: Icons.location_on_outlined,
                ),
              ),
      ),
    );
  }
}
