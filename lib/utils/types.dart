import 'package:lettutor_app/models/category_items.dart';

import '../models/tutor.dart';

class Nationality {
  String display;
  String val;

  Nationality(this.display, this.val);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Nationality &&
          runtimeType == other.runtimeType &&
          display == other.display &&
          val == other.val;

  @override
  int get hashCode => display.hashCode ^ val.hashCode;
}

class FilterCriteria {
  final String name;
  final Category specialty;
  final List<Nationality> nationality;

  FilterCriteria(
      {required this.nationality,
      required this.specialty,
      required this.name}) {}

  Map getNationalities() {
    var result = {};
    if (nationality.isEmpty) {
      return result;
    }
    if (nationality.contains(Nationality("Gia sư nước ngoài", "isOversea")) &&
        nationality.contains(Nationality("Gia sư Viêt Nam", "isVietNamese")) &&
        nationality.contains(Nationality("Gia sư Bản Ngữ", "isNative"))) {
      return result;
    }
    for (var value in nationality) {
      if (value.val == "all") {
        result.clear();
        return result;
      }
      if (value.val == "isOversea") {
        result['isVietNamese'] = false;
        result['isNative'] = false;
        return result;
      }
      result[value.val] = true;
    }
    return result;
  }

  List<String?> getSpecialties() {
    var result = <String?>[];
    if (specialty.key == 'all') {
      return result;
    }
    result.add(specialty.key);
    return result;
  }
}

class Reason {
  int id;
  String description;

  Reason(this.id, this.description);
}

abstract class Likable {
  Future<dynamic> like(Tutor tutor);
}
