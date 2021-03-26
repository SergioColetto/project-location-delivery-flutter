import 'dart:convert';

import 'package:happy_postcode_flutter/models/address.dart';
import 'package:happy_postcode_flutter/service/postcode_service.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class PostcodeServiceImp extends PostcodeService {
  PostcodeServiceImp(HttpClientWithInterceptor client) : super(client);

  Future<List<Address>> findByPostcode(String postcode) async {
    List<Address> addresses = [];
    Response response;
// if (!isValid(postcode)) {
//       _dialog(context, "Invalid Postcode");
//       return null;
//     }
    try {
      response = await this.client.get(
          Uri.https('api.ideal-postcodes.co.uk', 'v1/postcodes/$postcode',
              <String, String>{'api_key': 'iddqd'}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      Map<String, dynamic> body = jsonDecode(response.body);
      addresses = builderAddresses(body['result']);
    } on NoSuchMethodError catch (_) {
      // if (response.statusCode == 404) {
      //   _dialog(context, "Postcode Not Found");
      // }
      if (response.statusCode == 402) {
        try {
          // findPrivado(context, postcode);
        } on NoSuchMethodError catch (_) {
          // _dialog(context,
          //     "Limit reached. One of your lookup limits has been breached for today");
        }
      }
    }
    return addresses;
  }

  Future<List<Address>> findByPostcodePrivado(String postcode) async {
    final response = await this.client.get(
        Uri.https('location-delivery.herokuapp.com', 'api/location',
            <String, String>{'postcode': postcode}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    List<dynamic> body = jsonDecode(response.body);
    return builderAddresses(body);
  }

  Future<void> savePostcodeList(List<Address> addresses) {
    client.post(
      Uri.https('location-delivery.herokuapp.com', 'api/location'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(addresses),
    );
  }
}
