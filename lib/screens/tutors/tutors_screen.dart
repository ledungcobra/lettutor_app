import 'package:flutter/material.dart';
import 'package:lettutor_app/mockdata/tutors.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/screens/tutor_detail/tutor_detail.dart';
import 'package:lettutor_app/screens/tutors/widgets/tutor_card.dart';
import 'package:lettutor_app/widgets/skill_chip.dart';

class TutorsScreen extends StatefulWidget {
  const TutorsScreen({Key? key}) : super(key: key);

  @override
  State<TutorsScreen> createState() => _TutorsScreenState();
}

class _TutorsScreenState extends State<TutorsScreen> {

  late double _width;
  late double _height;
  late Nationality selectedNationality = nationalities.first;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                _filterLanguageBar(),
                _filterSkillsBar(),
                _tutorsList(),
              ],
            ),
          ),
        ));
  }

  Widget _filterLanguageBar() {
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
              child: DropdownButton(
                underline: Container(),
                onChanged: (value) {
                  setState(() {
                    selectedNationality = nationalities
                        .firstWhere((element) => element.value == value);
                  });
                },
                value: selectedNationality.value,
                items: nationalities
                    .map(
                      (e) => DropdownMenuItem(
                          value: e.value, child: Text(e.display)),
                    )
                    .toList(),
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

  int selectedFilterIndex = 0;

  Widget _filterSkillsBar() {
    return SizedBox(
      width: _width,
      height: 0.06 * _height,
      child: ListView.separated(
        itemCount: tutorFilters.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedFilterIndex = index;
            });
          },
          child: SkillChip(
            selected: selectedFilterIndex == index,
            value: tutorFilters[index],
          ),
        ),
        separatorBuilder: ((context, index) => SizedBox(
              width: 4,
            )),
      ),
    );
  }

  Widget _tutorsList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => TutorCard(
          onClick: ()=> _handleShowTutorDetail(listTutors[index]),
          tutor: listTutors[index],
          key: Key(index.toString()),
        ),
        itemCount: listTutors.length,
      ),
    );
  }

 void _handleShowTutorDetail(Tutor tutor) {
    var destinationScreen = TutorDetailScreen(tutor: listTutorDetails.first,);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => destinationScreen));
 }
}
