import 'package:dio/dio.dart';
import 'package:news_app/apibase/apiservice.dart';
import 'package:news_app/apibase/base_model.dart';
import 'package:news_app/apibase/header_interceptor.dart';
import 'package:news_app/apibase/retry_interceptor.dart';
import 'package:news_app/apibase/server_error.dart';
import 'package:news_app/flavors/flavor_values.dart';
import 'package:news_app/models/model.dart';

class Repository {
  factory Repository() => instance;

  Repository._initialize() {
    dio = Dio(BaseOptions(baseUrl: FlavorValues.instance.baseUrl));
    dio.interceptors.addAll([HeaderInterceptor(),RetryInterceptor()]);
    apiService = ApiService(dio);
  }

  static final Repository instance = Repository._initialize();

  late Dio dio;

  late ApiService apiService;

  Future<BaseModel<List<Article>>> getLatestArticles() async {
    try {
      final response = await apiService.getLatestArticles();
      return BaseModel(data: response.data);
    } on DioException catch (e) {
      return BaseModel(error: ServerError.withError(error: e));
    }
    // return fetchData<List<Article>, ApiResponse<List<Article>>>(
    //   apiService.getArticles(),
    // );
  }

  Future<BaseModel<List<Article>>> getTopicWiseArticles({
    required String topic,
    required int page,
    int? pageSize,
  }) async {
    try {
      final response = await apiService.getTopicWiseArticles(
        topic: topic,
        page: page,
        pageSize: pageSize,
      );
      return BaseModel(data: response.data);
    } on DioException catch (e) {
      return BaseModel(error: ServerError.withError(error: e));
    }
  }
}

// Future<BaseModel<T>> fetchData<T, S>(Future<S> function) async {
//   try {
//     final response = await function;
//     if (response is ApiResponse<T>) {
//       return BaseModel(data: response.data);
//     }
//     return BaseModel(data: response);
//   } on DioException catch (error,stackTrace) {
//     debugPrintStack(stackTrace: stackTrace);
//     debugPrint(error.toString());
//     return BaseModel(error: ServerError.withError(error: error));
//   }
// }
