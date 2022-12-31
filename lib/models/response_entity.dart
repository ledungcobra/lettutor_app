

import 'error/error.dart';

class ResponseEntity<T> {
  T? data;
  ErrorResponse? error;

  ResponseEntity({this.data, this.error});

  get hasError => error != null;

  get hasData => data != null;

  @override
  String toString() {
    return '{"data":${data?.toString()}, "error":${error?.toString()}';
  }
}
