import 'server_error.dart';

class BaseModel<T> {
  BaseModel({
    this.data,
    this.error,
    this.maxPages,
  });

  ServerError? error;
  T? data;
  int? maxPages;
}
