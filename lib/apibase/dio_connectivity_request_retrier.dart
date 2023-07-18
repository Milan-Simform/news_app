import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:news_app/apibase/repository.dart';

class DioConnectivityRequestRetrier {
  final Connectivity connectivity = Connectivity();

  Future<Response<dynamic>> scheduleRetryRequest(
    RequestOptions requestOptions,
  ) {
    final completer = Completer<Response<dynamic>>();
    StreamSubscription<dynamic>? subscription;
    subscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          unawaited(subscription?.cancel());
          completer.complete(
            Repository.instance.dio.fetch(requestOptions),
          );
        }
      },
    );
    return completer.future;
  }
}
