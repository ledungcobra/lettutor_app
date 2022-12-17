import 'package:lettutor_app/models/category_items.dart';
import 'package:lettutor_app/utils/mixing.dart';

class UtilService with AppAPI, CatchError {
  Map<String?, Category> languages = {};
  Map<String?, Category> specialties = {};
  Map<String?, Category> learnTopics = {};
  Map<String?, Category> testPreparations = {};
  Map<String?, Category> proficiencies = {
    "BEGINNER": Category(description: "Beginner", id: "0", key: "BEGINNER"),
    "HIGHER_BEGINNER":
        Category(description: "Higher Beginner", id: "0", key: "HIGHER_BEGINNER"),
    "PRE_INTERMEDIATE": Category(
        description: "Pre-Intermediate", id: "0", key: "PRE_INTERMEDIATE"),
    "INTERMEDIATE":
        Category(description: "Intermediate", id: "0", key: "INTERMEDIATE"),
    "UPPER_INTERMEDIATE": Category(
        description: "Upper-Intermediate", id: "0", key: "UPPER_INTERMEDIATE"),
    "ADVANCED": Category(description: "Advanced", id: "0", key: "ADVANCED"),
    "PROFICIENCY":  Category(description: "Proficiency", key: "PROFICIENCY"),
  };

  loadSkillFilter() async {
    try {
      var response = await dio.get(buildUrl("/category"));
      var categoryList = <CategoryItems>[];
      for (var skill in response.data) {
        categoryList.add(CategoryItems.fromJson(skill));
      }

      for (var item in categoryList) {
        if (item.title == "languages") {
          for (var value in item.categories!) {
            languages[value.key] = value;
          }
        }
      }
      specialties['all'] = Category(key: 'all', description: 'All');

      response = await dio.get(buildUrl('/learn-topic'));
      for (var item in response.data) {
        var category = Category(
            id: item['id'].toString(),
            key: item['key'],
            description: item['name']);
        specialties[category.key] = category;
        learnTopics[category.id] = category;
      }

      response = await dio.get(buildUrl('/test-preparation'));
      for (var item in response.data) {
        var category = Category(
            id: item['id'].toString(),
            key: item['key'],
            description: item['name']);
        specialties[category.key] = category;
        testPreparations[category.id] = category;
      }

      for (var item in categoryList) {
        if (item.title == "specialties") {
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
