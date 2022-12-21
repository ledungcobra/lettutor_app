import 'package:flutter/material.dart';
import 'package:lettutor_app/screens/courses/tabs/books_tab.dart';
import 'package:lettutor_app/screens/courses/tabs/courses_tab.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CoursesScreen extends StatefulWidget {
  CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      enableLoadingWhenFailed: true,
      context: context,
      child: Scaffold(
        appBar: AppBar(
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
            Scrollbar(child: CoursesTab()),
            Scrollbar(child: BooksTab()),
          ],
        ),
      ),
    );
  }
}

