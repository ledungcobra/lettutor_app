import 'package:flutter/material.dart';

double DEFAULT_PADDING = 10;
const PRIMARY_COLOR = Color(0xFF0071F0);
const ASSET_FILE_PATH = "assets/images";
var CHIP_COLOR = Colors.blue[50];
var COMMENTS_FILE = "tutor_detail_info_comments.json";

String getAssetImage(String file) {
  return "$ASSET_FILE_PATH/$file";
}
