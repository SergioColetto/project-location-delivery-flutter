import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:happy_postcode_flutter/components/app_theme.dart';
import 'package:happy_postcode_flutter/components/centered_message.dart';
import 'package:happy_postcode_flutter/models/address.dart';
import 'package:happy_postcode_flutter/pages/main_page.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:postcode/postcode.dart';
import 'package:provider/provider.dart';

class DataSearch extends SearchDelegate {
  @override
  String get searchFieldLabel => "SW1A 1AA";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final provider = Provider.of<AddressProvider>(context, listen: false);

    if (!isValid(query)) {
      return CenteredMessage(
        "Enter a valid postcode",
        icon: Icons.search,
      );
    }

    return FutureBuilder(
      future: new AddressProvider().findByPostcode(context, query),
      builder: (BuildContext context, AsyncSnapshot<List<Address>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return ListSkeleton(
              style: SkeletonStyle(
                theme: SkeletonTheme.Dark,
                isShowAvatar: true,
                barCount: 2,
                isAnimation: true,
              ),
            );
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              provider.addAddress(snapshot.data);
              if (provider.addresses.isNotEmpty)
                return ListView(
                    children: provider.addresses
                        .map((address) => _buildRow(provider, address, context))
                        .toList());
            }
            return CenteredMessage(
              "No Postcode found",
              icon: Icons.warning,
            );
            break;
          case ConnectionState.none:
            break;
        }
        return CenteredMessage(
          "Unknown error",
          icon: Icons.warning,
        );
      },
    );
  }

  Widget _buildRow(
      AddressProvider provider, Address address, BuildContext context) {
    return Card(
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.navigation, color: Colors.grey),
              onPressed: () {
                provider.launchCoordinates(address.latitude, address.longitude);
              }),
          Expanded(
            child: ListTile(
              title: Text('${address.line1}'),
              subtitle:
                  Text('${address.line2} ${address.line3} ${address.postcode}'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_circle,
                color: provider.includes(address) ? Colors.green : Colors.grey),
            onPressed: () {
              provider.routeAdd(context, address);
              this.close(context, MainPage());
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<AddressProvider>(context, listen: false);

    return ListView(
        children: provider.addresses
            .map((address) => _buildRow(provider, address, context))
            .toList());
  }

  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: Colors.white,
        fontSize: 16,
      );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Provider.of<ThemeChanger>(context).currentTheme;
  }
}
