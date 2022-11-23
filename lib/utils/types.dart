import 'package:lettutor_app/models/category_items.dart';
import 'package:lettutor_app/models/tutor.dart';

class Nationality {
  String display;
  String val;

  Nationality(this.display, this.val);
}

class FilterCriteria {
  final String name;
  final Category skillFilter;
  final Nationality nationality;

  FilterCriteria(
      {required this.nationality,
      required this.skillFilter,
      required this.name});

  bool _isNameOk(Tutor tutor) {
    print("Name searching $name");
    return tutor.name!.contains(RegExp(name, caseSensitive: false));
  }

  bool _isSkillOk(Tutor tutor){
    if(skillFilter.key == "all"){
      return true;
    }
    var specialties =  tutor.getSpecialties();
    return specialties.any((specialty) => specialty.key == skillFilter.key);
  }

  bool _isNationalityOk(Tutor tutor) {
    if(nationality.val == "all"){
      return true;
    }

    if (nationality.val == "native") {
      return tutor.isNative!;
    }

    if (nationality.val == "vn") {
      return  tutor.country!.toLowerCase() == "vn";
    }

    if (nationality.val == "oversea") {
      return tutor.country!.toLowerCase() != "vn" && !tutor.isNative!;
    }
    return true;
  }

  bool isOk(Tutor tutor) {
    return _isNameOk(tutor) && _isNationalityOk(tutor) && _isSkillOk(tutor);
  }
}
