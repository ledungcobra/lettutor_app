import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/screens/tutor_detail/tutor_detail.dart';
import 'package:lettutor_app/screens/tutors/tutors_controller.dart';
import 'package:lettutor_app/screens/tutors/widgets/tutor_card.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/types.dart';
import 'package:lettutor_app/widgets/center_error.dart';
import 'package:lettutor_app/widgets/loading.dart';
import 'package:lettutor_app/widgets/skill_chip.dart';
import 'package:lettutor_app/widgets/not_found.dart';

class TutorsScreen extends GetView<TutorsController> {
  late double _width;
  late double _height;
  Rx<Nationality> selectedNationality = nationalities.first.obs;
  RxInt selectedFilterIndex = 0.obs;
  final TutorService _tutorService = Get.find();
  var tutorName = "";

  TutorsScreen();

  @override
  Widget build(BuildContext context) {
    _width = Get.width;
    _height = Get.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Row(
              children: [
                Text(
                  'Tutors',
                  style: TextStyle(color: Colors.blue),
                ),
                _searchField()
              ],
            ),
            backgroundColor: Colors.white),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                _filterNationalityBar(),
                _filterSkillsBar(),
                _tutorsList(),
              ],
            ),
          ),
        ));
  }

  Widget _filterNationalityBar() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "Tutor Nationality",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(50)),
              child: Obx(
                () => DropdownButton(
                  underline: Container(),
                  onChanged: (value) {
                    selectedNationality.value = (nationalities
                        .firstWhere((element) => element.val == value));
                    doFilter();
                  },
                  value: selectedNationality.value.val,
                  items: nationalities
                      .map(
                        (e) => DropdownMenuItem(
                            value: e.val, child: Text(e.display)),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _searchField() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          onFieldSubmitted: _handleSearch,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            hintText: 'Enter tutor name',
            prefixIcon: Icon(Icons.search),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterSkillsBar() {
    return SizedBox(
      width: _width,
      height: 0.06 * _height,
      child: ListView.separated(
        itemCount: skillFilters.keys.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Obx(
          () => SkillChip(
            onClick: () {
              selectedFilterIndex.value = index;
              doFilter();
            },
            selected: selectedFilterIndex.value == index,
            value: skillFilters.values.toList()[index].name,
          ),
        ),
        separatorBuilder: ((context, index) => SizedBox(
              width: 4,
            )),
      ),
    );
  }

  Widget _tutorsList() {
    return controller.obx(
      onLoading: Loading(),
      onError: (error) => CenterError(error: error ?? ""),
      (tutors) => controller.isInit.value
          ? Loading()
          : tutors!.isEmpty
              ? NotFound()
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => TutorCard(
                      onLikeClick: () => controller.like(tutors[index].userId!),
                      onClick: () => _handleShowTutorDetail(tutors[index]),
                      tutor: tutors[index],
                      key: Key(index.toString()),
                    ),
                    itemCount: tutors.length,
                  ),
                ),
    );
  }

  void _handleShowTutorDetail(Tutor tutor) async {
    var tutorDetail = await _tutorService.getTutorDetail(tutor.userId!);
    Get.to(TutorDetailScreen(tutorDetail: tutorDetail));
  }

  void _handleSearch(String? newValue) {
    if (newValue == null) {
      return;
    }
    tutorName = newValue;
    doFilter();
  }

  doFilter() {
    controller.filter(filterCriteria);
  }

  SkillFilter get selectedSkillFilter =>
      skillFilters.entries.toList()[selectedFilterIndex.value].value;

  FilterCriteria get filterCriteria => FilterCriteria(
      nationality: selectedNationality.value,
      skillFilter: selectedSkillFilter,
      name: tutorName);
}
