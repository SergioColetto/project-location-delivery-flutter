import 'package:http_interceptor/http_interceptor.dart';

class NetworkRequestManager {
  static NetworkRequestManager _instace;
  static NetworkRequestManager get instance {
    if (_instace == null) _instace = NetworkRequestManager._init();
    return _instace;
  }

  HttpClientWithInterceptor service;

  NetworkRequestManager._init() {
    service =
        HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  }
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print(data.url);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data.body);
    return data;
  }
}
