import 'package:flutter/material.dart';
import 'package:lettutor_app/utils/types.dart';

double DEFAULT_PADDING = 10;
const PRIMARY_COLOR = Color(0xFF0071F0);
const ASSET_FILE_PATH = "assets/images";
var CHIP_COLOR = Colors.blue[50];
var COMMENTS_FILE = "tutor_detail_info_comments.json";

var DEFAULT_AVATAR = "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png";

List<String> skillFilters = [
  "All",
  "English for kids",
  "Business English",
  "Conversational",
  "STARTERS",
  "MOVERS",
  "FLYERS",
  "KET",
  "PET",
  "IELTS",
  "TOEFL",
  "TOEIC",
];



List<Nationality> nationalities = [
  Nationality("Gia sư nước ngoài", "oversea"),
  Nationality("Gia sư Viêt Nam", "vietnamese"),
  Nationality("Gia sư Bản Ngữ", "native"),
];
