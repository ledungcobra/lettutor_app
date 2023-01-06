import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/error/error.dart';
import '../models/response_entity.dart';
import '../services/token_service.dart';

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
      print(e);
      String message = e.response!.data['message'].toString();
      return ResponseEntity(
          data: null, error: ErrorResponse(message: message, statusCode: 400));
    } else {
      print(e);
    }
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
  Dio get dio => Get.find<Dio>();
  final baseUrl = 'https://sandbox.api.lettutor.com';

  TokenService get tokenService => Get.find<TokenService>();

  buildUrl(String endpoint) {
    return "$baseUrl$endpoint";
  }

  reloadToken() async {
    var accessToken = await tokenService.getAccessToken();
    if (accessToken.isNotEmpty) {
      dio.options.headers['Authorization'] = "Bearer $accessToken";
    }
  }
}

extension ToString on Duration {
  String print() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    return "${twoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
