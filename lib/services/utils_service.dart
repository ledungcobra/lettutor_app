import 'package:lettutor_app/models/category_items.dart';
import 'package:lettutor_app/utils/mixing.dart';

class UtilService with AppAPI, CatchError {

  Map<String?, Category> languages = {};
  Map<String?, Category> specialties = {};

  // todo calling /category
  loadSkillFilter() async {
    try {
      var response = await dio.get(buildUrl("/category"));
      var categoryList = <CategoryItems>[];
      for (var skill in response.data) {
        categoryList.add(CategoryItems.fromJson(skill));
      }

      for (var item in categoryList) {
        if(item.title == "languages"){
          for (var value in item.categories!) {
            languages[value.key] = value;
          }
        }
      }

      for (var item in categoryList) {
        if(item.title == "specialties"){
          for (var value in item.categories!) {
            specialties[value.key] = value;
          }
        }
      }
    } catch (e) {
      handleError(e);
    }
  }

  init() async {
    await loadSkillFilter();
  }
}
