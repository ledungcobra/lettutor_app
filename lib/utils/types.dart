import 'package:lettutor_app/models/category_items.dart';

class Nationality {
  String display;
  String val;

  Nationality(this.display, this.val);
}

class FilterCriteria {
  final String name;
  final Category skillFilter;
  final List<Nationality> nationality;

  FilterCriteria(
      {required this.nationality,
      required this.skillFilter,
      required this.name});

  Map getNationalities(){
    var result = {};
    if(nationality.isEmpty){
      return result;
    }
    for (var value in nationality) {
      if(value.val == "all"){
        result.clear();
        return result;
      }
      if(value.val == "isOversea"){
        result['isVietNamese'] = false;
        result['isNative'] = false;
        return result;
      }
      result[value.val] = true;
    }
    return result;
  }
}
