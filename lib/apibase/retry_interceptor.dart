import 'package:dio/dio.dart';
import 'package:news_app/apibase/repository.dart';
import 'package:news_app/utils/extensions.dart';

class RetryInterceptor extends Interceptor {
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler,) async {
    // 429: Too many Requests - Max concurrency allowed 1 per 1 second
    if (err.response?.statusCode == 429) {
      await Future.delayed(
        1.seconds,
        () async => handler.resolve(
          await Repository().dio.fetch(err.requestOptions),
        ),
      );
    }

    // InvalidAPIKey or Monthly API calls limit reached: 50
    if (err.response?.statusCode == 401) {}
    handler.next(err);
  }
}
