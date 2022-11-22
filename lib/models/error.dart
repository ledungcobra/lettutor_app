class ErrorResponse {
  num? statusCode;
  String? message;

  ErrorResponse({this.statusCode, this.message});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  @override
  String toString() {
    return toJson().toString();
  }
}