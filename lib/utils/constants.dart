import 'package:flutter/material.dart';
import 'package:lettutor_app/utils/types.dart';

double DEFAULT_PADDING = 10;
const PRIMARY_COLOR = Color(0xFF0071F0);
const ASSET_FILE_PATH = "assets/images";
var CHIP_COLOR = Colors.blue[50];
var COMMENTS_FILE = "tutor_detail_info_comments.json";

var DEFAULT_AVATAR =
    "https://www.lewesac.co.uk/wp-content/uploads/2017/12/default-avatar.jpg";

Map<String, SkillFilter> skillFilters = {
  "all": SkillFilter(0, "all", "All"),
  "english-for-kids": SkillFilter(3, "english-for-kids", "English for Kids"),
  "business": SkillFilter(4, "business", "Business English"),
  'conversational-english': SkillFilter(
      5, 'conversational-english', "Conversational English"),
  'starters': SkillFilter(1, 'starters', "STARTERS"),
  "movers": SkillFilter(2, "movers", 'MOVERS'),
  'flyers': SkillFilter(3, 'flyers', 'FLYERS'),
  'ket': SkillFilter(4, 'ket', 'KET'),
  'pet': SkillFilter(5, 'pet', "PET"),
  'ielts': SkillFilter(6, 'ielts', 'IELTS'),
  'toefl': SkillFilter(7, 'toefl', 'TOEFL'),
  'toeic': SkillFilter(8, 'toeic', 'TOEIC'),
};


List<Nationality> nationalities = [
  Nationality("Chọn quốc gia", "all"),
  Nationality("Gia sư nước ngoài", "oversea"),
  Nationality("Gia sư Viêt Nam", "vn"),
  Nationality("Gia sư Bản Ngữ", "native"),
];

