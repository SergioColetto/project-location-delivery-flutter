import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class DestinationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, provider, child) => CustomScrollView(
        slivers: <Widget>[
          ReorderableSliverList(
            delegate: ReorderableSliverChildListDelegate(provider.route
                .map((item) => Card(
                      child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Container(
                          child: ListTile(
                            leading: Icon(Icons.compare_arrows_sharp),
                            title: Text('${item.line1}'),
                            subtitle: Text(
                                '${item.line2} ${item.line3} ${item.postcode}'),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Favorites',
                            color: Colors.black45,
                            icon: Icons.favorite,
                            onTap: () => {},
                          ),
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () => provider.deleteInRoute(item),
                          ),
                        ],
                      ),
                    ))
                .toList()),
            onReorder: provider.onReorder,
          )
        ],
      ),
    );
  }
}
