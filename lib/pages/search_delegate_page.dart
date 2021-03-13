import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/components/app_theme.dart';
import 'package:happy_postcode_flutter/components/centered_message.dart';
import 'package:happy_postcode_flutter/components/custom_navigation_bar.dart';
import 'package:happy_postcode_flutter/components/navigate_button.dart';
import 'package:happy_postcode_flutter/components/route_list.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:happy_postcode_flutter/search/search_delegate.dart';
import 'package:provider/provider.dart';

class SearchDelegatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40, top: 8, right: 40, bottom: 10),
                child: InkWell(
                  onTap: () async {
                    showSearch(context: context, delegate: DataSearch());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.buildTheme()
                          .backgroundColor
                          .withOpacity(0.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(3.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 10),
                      child: Text(
                        "Search Postcode",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(),
        floatingActionButton: NavigateButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: provider.totalInRoute > 0
            ? RouteList()
            : CenteredMessage(
                "Location Delivery",
                icon: Icons.room_outlined,
              ),
      ),
    );
  }
}
