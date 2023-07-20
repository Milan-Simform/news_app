import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers.putIfAbsent(
      'x-api-key',
      () => '3-Xs-E3kL-ODeH-ZWEwPKKFdfrlSIMsu2OCEd5dxBAA',
    );
    handler.next(options);
  }
}
