import 'dart:io';

import 'package:flutter/foundation.dart';

class CertificateData {
  String certificateType;
  Uint8List data;
  String certificateFileName;
  File file;

  CertificateData(
      this.certificateType, this.data, this.certificateFileName, this.file);

  @override
  String toString() {
    return "Type $certificateType name: $certificateFileName";
  }

  Map<String, dynamic> toJson() {
    return {
      "certificateFileName": certificateFileName,
      "certificateType": certificateType
    };
  }
}
