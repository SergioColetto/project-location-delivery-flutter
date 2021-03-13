import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class RouteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<AddressProvider>(
      builder: (context, provider, child) => CustomScrollView(
        slivers: <Widget>[
          ReorderableSliverList(
            delegate: ReorderableSliverChildListDelegate(provider.route
                .map((item) => Row(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(Icons.compare_arrows_sharp,
                                color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(item.line1),
                            subtitle: Text('${item.postcode} ${item.line3}'),
                          ),
                        ),
                        Container(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                provider.deleteInRoute(item);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Icon(Icons.remove_circle,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
                .toList()),
            onReorder: provider.onReorder,
          )
        ],
      ),
    );
  }
}
