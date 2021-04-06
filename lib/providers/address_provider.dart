import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:happy_postcode_flutter/models/address.dart';
import 'package:happy_postcode_flutter/service/network/network_manager.dart';
import 'package:happy_postcode_flutter/service/postcode_service_imp.dart';
import 'package:url_launcher/url_launcher.dart';

class AddressProvider extends ChangeNotifier {
  final service = PostcodeServiceImp(NetworkRequestManager.instance.service);

  String oldSearchPostcode = '';

  List<Address> _addresses = [];
  List<Address> _route = [];
  List<Address> _favorite = [];

  UnmodifiableListView<Address> get addresses =>
      UnmodifiableListView(_addresses);
  UnmodifiableListView<Address> get route => UnmodifiableListView(_route);
  UnmodifiableListView<Address> get favorite => UnmodifiableListView(_favorite);

  int get totalInRoute => _route.length;

  void onReorder(int oldIndex, int newIndex) {
    var row = _route.removeAt(oldIndex);
    _route.insert(newIndex, row);
    notifyListeners();
  }

  Future<List<Address>> findByPostcode(
      BuildContext context, final String postcode) async {
    _addresses = await service.findByPostcode(postcode);
    return addresses;
  }

  Future<List<Address>> findPrivado(
      BuildContext context, final String postcode) async {
    return addresses;
  }

  void routeAdd(BuildContext context, Address address) {
    if (_route.length == 9) {
      _dialog(context, "Limit of address in route");
      return;
    }
    if (_route.contains(address)) return;
    _route.add(address);
    notifyListeners();
  }

  void deleteInRoute(Address address) {
    _route.remove(address);
    notifyListeners();
  }

  void deleteAllAddressInRoute() {
    _route = [];
    notifyListeners();
  }

  Future<bool> launchCoordinates(double latitude, double longitude,
      [String label]) {
    return launch(_createCoordinatesUrl(latitude, longitude, label));
  }

  String _createCoordinatesUrl(double latitude, double longitude,
      [String label]) {
    final uri = Uri.https('www.google.com', 'maps/place/$latitude,$longitude',
        {'data': '!3m1!4b1!4m5!3m4!1s0x0:0x0!8m2!3d$latitude!4d$longitude'});

    return uri?.toString();
  }

  void launchRoute(BuildContext context) async {
    if (_route.length == 0) {
      _dialog(context, "Add address in route.");
      return;
    }
    final url = _createRoute();
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  String _createRoute() {
    if (_route.length > 0) {
      final locationsBuild = [];
      locationsBuild.add("");

      _route.forEach((address) =>
          locationsBuild.add('${address.latitude},${address.longitude}'));

      locationsBuild.add('@${locationsBuild[locationsBuild.length - 1]},14z/');

      final allLocations = locationsBuild.join("/");

      return Uri.https('www.google.com', 'maps/dir/$allLocations').toString();
    }
    return '';
  }

  void _dialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                message,
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
        barrierDismissible: false);
  }

  void _sendAddressToPrivateServer() {}

  bool includes(Address address) {
    return _route.contains(address);
  }

  void addAddress(List<Address> data) {
    _addresses = data;
  }

  void dialog(BuildContext context, String msg) {
    _dialog(context, msg);
  }
}
