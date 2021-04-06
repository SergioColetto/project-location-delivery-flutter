import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/models/address.dart';
import 'package:happy_postcode_flutter/service/network/network_manager.dart';
import 'package:happy_postcode_flutter/service/postcode_service_imp.dart';

class FavoriteProvider extends ChangeNotifier {
  final service = PostcodeServiceImp(NetworkRequestManager.instance.service);

  List<Address> _favorite = [];
  UnmodifiableListView<Address> get favorite => UnmodifiableListView(_favorite);

  void add(BuildContext context, Address address) {
    if (_favorite.contains(address)) return;
    _favorite.add(address);
    notifyListeners();
  }

  void delete(Address address) {
    _favorite.remove(address);
    notifyListeners();
  }

  bool includes(Address address) {
    return _favorite.contains(address);
  }
}
