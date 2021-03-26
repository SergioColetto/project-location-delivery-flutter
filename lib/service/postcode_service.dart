import 'package:happy_postcode_flutter/models/address.dart';
import 'package:http_interceptor/http_interceptor.dart';

abstract class PostcodeService {
  HttpClientWithInterceptor client;
  PostcodeService(this.client);

  Future<List<Address>> findByPostcode(String postcode);
  Future<List<Address>> findByPostcodePrivado(String postcode);
  Future<void> savePostcodeList(List<Address> addresses);
}
