import 'package:dio/dio.dart';
import 'package:news_app/apibase/dio_connectivity_request_retrier.dart';
import 'package:news_app/apibase/repository.dart';
import 'package:news_app/utils/extensions.dart';

class RetryInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier =
      DioConnectivityRequestRetrier();

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // 429: Too many Requests - Max concurrency allowed 1 per 1 second
    if (err.response?.statusCode == 429) {
      await Future.delayed(
        1.seconds,
        () async => handler.resolve(
          await Repository().dio.fetch(err.requestOptions),
        ),
      );
    } else {
      handler.next(err);
    }
    // If Socket Exception
    // else if (err.error != null && err.error is SocketException) {
    //   handler.resolve(
    //     await requestRetrier.scheduleRetryRequest(err.requestOptions),
    //   );
    // }
  }
}
