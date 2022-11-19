import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dto/ResponseEntity.dart';
import '../models/error.dart';

mixin Dimension {
  double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

mixin CatchError {
  handleError(Object e) {
    if (e is DioError) {
      String message = e.response!.data['message'].toString();
      return ResponseEntity(
          data: null, error: ErrorResponse(message: message, statusCode: 400));
    }
    print(e);
    return ResponseEntity(
      data: null,
      error: ErrorResponse(message: "Some thing went wrong", statusCode: 400),
    );
  }
}

mixin HandleUIError {
  handleError(ErrorResponse error) {
    Get.snackbar(
      'Error',
      error.message?.toString() ?? "",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

mixin AppAPI {
  final baseUrl = 'https://sandbox.api.lettutor.com';
  buildUrl(String endpoint){
    return "$baseUrl$endpoint";
  }
}