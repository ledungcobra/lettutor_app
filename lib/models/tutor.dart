
class Tutor {
  String name;
  List<String> language;
  List<String> specialties;
  String avatar;
  double rating;
  String interests;
  String description;
  String teachingExperience;
  String id;

  Tutor(
      {required this.id,
      required this.name,
      required this.language,
      required this.specialties,
      required this.avatar,
      required this.rating,
      required this.interests,
      required this.description,
      this.teachingExperience = 'Teaching experience'});
}
