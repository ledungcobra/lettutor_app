import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
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
import '../../widgets/search_bar.dart';

class TutorsScreen extends StatefulWidget {
  TutorsScreen();

  @override
  State<TutorsScreen> createState() => _TutorsScreenState();
}

class _TutorsScreenState extends State<TutorsScreen> with HandleUIError {
  final controller = Get.find<TutorsController>();
  final TutorService _tutorService = Get.find();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  final GlobalKey _refresherKey = GlobalKey();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TutorsController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Row(
          children: [
            Text(
              'Tutors',
              style: TextStyle(color: Colors.blue),
            ),
            SearchBar(
                handleSearch: _handleSearch, placeholder: 'Enter tutor name')
          ],
        )),
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
              child: MultiSelectDialogField(
                chipDisplay: MultiSelectChipDisplay<Nationality>()
                  ..disabled = true,
                decoration: BoxDecoration(borderRadius: BorderRadius.zero),
                title: Text('Chọn quốc gia'),
                buttonText: Text('Chọn quốc gia'),
                items: nationalities
                    .map((e) => MultiSelectItem(e, e.display))
                    .toList(),
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
          enablePullDown: true,
          header: WaterDropHeader(),
          physics: BouncingScrollPhysics(),
          footer: LoadMoreFooter(),
          controller: refreshController,
          onRefresh: () async {
            await controller.refreshTutors();
            if (mounted) {
              setState(() {});
            }
            refreshController.refreshCompleted();
          },
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
                    likable: controller))
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
    Get.to(
        TutorDetailScreen(tutorDetail: response.data!, tutorId: tutor.userId!));
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
