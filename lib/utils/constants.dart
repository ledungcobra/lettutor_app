import 'package:flutter/material.dart';
import 'package:lettutor_app/utils/types.dart';

double DEFAULT_PADDING = 10;
const PRIMARY_COLOR = Color(0xFF0071F0);
const ASSET_FILE_PATH = "assets/images";
var CHIP_COLOR = Colors.blue[50];
var COMMENTS_FILE = "tutor_detail_info_comments.json";

var DEFAULT_AVATAR =
    "https://www.lewesac.co.uk/wp-content/uploads/2017/12/default-avatar.jpg";

List<Nationality> nationalities = [
  Nationality("Chọn quốc gia", "all"),
  Nationality("Gia sư nước ngoài", "isOversea"),
  Nationality("Gia sư Viêt Nam", "isVietNamese"),
  Nationality("Gia sư Bản Ngữ", "isNative"),
];

