import 'package:dio/dio.dart';
import 'package:news_app/models/model.dart';
import 'package:news_app/models/response/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'apiservice.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  /// latest_headlines
  @GET('latest_headlines')
  Future<ApiResponse<List<Article>>> getLatestArticles({
    @Query('page') required int page,
    @Query('page_size') required int pageSize,
  });

  /// get articles based on topics
  @GET('latest_headlines')
  Future<ApiResponse<List<Article>>> getTopicWiseArticles({
    @Query('topic') required String topic,
    @Query('page') required int page,
    @Query('page_size') int? pageSize = 10,
    @Query('ranked_only') bool rankedOnly = true,
  });
}
