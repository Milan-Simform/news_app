import 'package:dio/dio.dart';
import 'package:news_app/apibase/apiservice.dart';
import 'package:news_app/apibase/base_model.dart';
import 'package:news_app/apibase/header_interceptor.dart';
import 'package:news_app/apibase/retry_interceptor.dart';
import 'package:news_app/apibase/server_error.dart';
import 'package:news_app/flavors/flavor_values.dart';
import 'package:news_app/models/model.dart';
import 'package:news_app/models/response/api_response.dart';

class Repository {
  factory Repository() => instance;

  Repository._initialize() {
    dio = Dio(BaseOptions(baseUrl: FlavorValues.instance.baseUrl));
    dio.interceptors.addAll([HeaderInterceptor(), RetryInterceptor()]);
    apiService = ApiService(dio);
  }

  static final Repository instance = Repository._initialize();

  late Dio dio;

  late ApiService apiService;

  Future<BaseModel<List<Article>>> getLatestArticles({
    required int page,
    required int pageSize,
  }) =>
      fetchData<List<Article>>(
        apiService.getLatestArticles(page: page, pageSize: pageSize),
      );

  Future<BaseModel<List<Article>>> getTopicWiseArticles({
    required String topic,
    required int page,
    int? pageSize,
  }) =>
      fetchData<List<Article>>(
        apiService.getTopicWiseArticles(
          topic: topic,
          page: page,
          pageSize: pageSize,
        ),
      );
  Future<BaseModel<List<Article>>> getSearchedArticles({
    required String query,
    required int page,
    int? pageSize,
  }) =>
      fetchData<List<Article>>(
        apiService.getSearchedArticles(
          query: query,
          page: page,
          pageSize: pageSize,
        ),
      );
}

Future<BaseModel<T>> fetchData<T>(Future<dynamic> future) async {
  try {
    final result = await future;
    if (result is ApiResponse<T>) {
      return BaseModel<T>(data: result.data, maxPages: result.totalPages);
    } else {
      return BaseModel<T>(data: result as T?);
    }
  } on DioException catch (e) {
    return BaseModel<T>(error: ServerError.withError(error: e));
  }
}
