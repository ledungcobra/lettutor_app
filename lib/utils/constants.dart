import 'package:flutter/material.dart';
import 'package:lettutor_app/utils/types.dart';

double DEFAULT_PADDING = 10;
const PRIMARY_COLOR = Color(0xFF0071F0);
const ASSET_FILE_PATH = "assets/images";
var CHIP_COLOR = Colors.blue[50];

var DEFAULT_AVATAR =
    "https://www.lewesac.co.uk/wp-content/uploads/2017/12/default-avatar.jpg";

List<Nationality> nationalities = [
  Nationality("Chọn quốc gia", "all"),
  Nationality("Gia sư nước ngoài", "isOversea"),
  Nationality("Gia sư Viêt Nam", "isVietNamese"),
  Nationality("Gia sư Bản Ngữ", "isNative"),
];

List<Reason> reportReason = [
  Reason(0, 'Select reason'),
  Reason(1, 'Tutor was late'),
  Reason(2, 'Tutor was absent'),
  Reason(3, 'Network unstable'),
  Reason(4, 'Other'),
];

List<Reason> cancelReason = [
  Reason(0, 'Select reason'),
  Reason(1, 'Reschedule at another time'),
  Reason(2, 'Busy at that time'),
  Reason(3, 'Asked by the tutor'),
  Reason(4, 'Other'),
];

const LevelToText = {
  "1": "Beginner",
  "2": "Upper-Beginner",
  "3": "Pre-Intermediate",
  "4": "Intermediate",
  "5": "Upper-Intermediate"
};