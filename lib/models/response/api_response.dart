import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class ApiResponse<T> {
  String? status;
  @JsonKey(name: 'total_hits')
  int? totalHits;
  int? page;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'page_size')
  int? pageSize;
  @JsonKey(name: 'articles')
  T? data;

  ApiResponse({
    this.status,
    this.totalHits,
    this.page,
    this.totalPages,
    this.pageSize,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);
}
