import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/screens/tutor_detail/tutor_detail.dart';
import 'package:lettutor_app/screens/tutors/tutors_controller.dart';
import 'package:lettutor_app/screens/tutors/widgets/tutor_card.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/constants.dart';
import 'package:lettutor_app/utils/mixing.dart';
import 'package:lettutor_app/utils/types.dart';
import 'package:lettutor_app/widgets/skill_chip.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../widgets/load_more_footer.dart';

class TutorsScreen extends StatefulWidget {
  TutorsScreen();

  @override
  State<TutorsScreen> createState() => _TutorsScreenState();
}

class _TutorsScreenState extends State<TutorsScreen> with HandleUIError {
  final controller = Get.find<TutorsController>();
  final TutorService _tutorService = Get.find();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey _refresherKey = GlobalKey();

  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TutorsController());
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
                _filterSpecialtiesBar(),
                tutorsList(),
              ],
            ),
          ),
        ));
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
              child:  MultiSelectDialogField(
                chipDisplay: MultiSelectChipDisplay<Nationality>()..disabled=true,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.zero
                ),

                  title:Text('Chọn quốc gia') ,
                  buttonText:Text('Chọn quốc gia'),
                  items: nationalities.map((e) => MultiSelectItem(e, e.display)).toList(),
                  listType: MultiSelectListType.LIST,
                  initialValue: [nationalities.first],
                  onConfirm: (values) {
                    controller.selectedNationalities.value = values;
                    filter();
                  },
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _filterSpecialtiesBar() {
    var skills = controller.skills;
    return SizedBox(
      width: Get.width,
      height: 0.06 * Get.height,
      child: ListView.separated(
        itemCount: skills.keys.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Obx(
          () => SkillChip(
            onClick: () {
              controller.selectedFilterIndex.value = index;
              filter();
            },
            selected: controller.selectedFilterIndex.value == index,
            value: skills.values.toList()[index].description ?? "Unknown",
          ),
        ),
        separatorBuilder: ((context, index) => SizedBox(
              width: 4,
            )),
      ),
    );
  }

  tutorsList() {
    return Expanded(
      child: Obx(
        () => SmartRefresher(
          key: _refresherKey,
          enablePullUp: true,
          header: WaterDropHeader(),
          physics: BouncingScrollPhysics(),
          footer: LoadMoreFooter(),
          controller: refreshController,
          onLoading: () async {
            await controller.loadTutors();
            if (mounted) {
              setState(() {});
            }
            refreshController.loadComplete();
          },
          child: ListView(
            children: controller.tutors
                .map((tutor) => TutorCard(
                    tutor: tutor,
                    onClick: () => _handleShowTutorDetail(tutor),
                    onLikeClick: () => controller.like(tutor.userId!)))
                .toList(),
          ),
        ),
      ),
    );
  }

  void _handleShowTutorDetail(Tutor tutor) async {
    var response = await _tutorService.getTutorDetail(tutor.userId!);
    if (response.hasError) {
      handleError(response.error!);
      return;
    }
    Get.to(TutorDetailScreen(tutorDetail: response.data!));
  }

  void _handleSearch(String? newValue) {
    if (newValue == null) {
      return;
    }
    controller.tutorName = newValue;
    filter();
  }

  filter() {
    controller.filter();
  }
}
