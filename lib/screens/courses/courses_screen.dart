import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/courses/tabs/books_controller.dart';
import 'package:lettutor_app/screens/courses/tabs/books_tab.dart';
import 'package:lettutor_app/screens/courses/tabs/courses_controller.dart';
import 'package:lettutor_app/screens/courses/tabs/courses_tab.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../widgets/search_bar.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  CoursesController get coursesController => Get.find<CoursesController>();

  BooksController get booksController => Get.find<BooksController>();

  late CoursesTab coursesTab;
  late BooksTab booksTab;
  final selectedTab = "Courses".obs;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      print('change');
      if (_tabController.index == 0) {
        selectedTab.value = "Courses";
      } else {
        selectedTab.value = "Books";
      }
    });
    coursesTab = CoursesTab();
    booksTab = BooksTab();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      enableLoadingWhenFailed: true,
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() => Row(
                children: [
                  Text(selectedTab.value),
                  SearchBar(
                    placeholder: 'Search ${selectedTab.value}',
                    handleSearch: _handleSearch,
                  )
                ],
              )),
          bottom: TabBar(
            // isScrollable: true,
            controller: _tabController,
            tabs: const [
              Tab(
                  icon: Icon(
                Icons.school,
                color: Colors.black,
              )),
              Tab(
                  icon: Icon(
                Icons.book,
                color: Colors.black,
              )),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            Scrollbar(child: coursesTab),
            Scrollbar(child: booksTab),
          ],
        ),
      ),
    );
  }

  _handleSearch(String? value) {
    print('Value $value');
    if (_tabController.index == 0) {
      coursesController.courseName = value;
      coursesTab.refreshController.requestRefresh();
    } else if (_tabController.index == 1) {
      booksController.bookName = value;
      booksTab.refreshController.requestRefresh();
    }
  }
}
