import 'package:flutter/material.dart';
import 'package:lettutor_app/widgets/button.dart';

class Booking {
  late String tutorId;

  Booking.showFullModal(BuildContext context, String tutorId) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Booking",
      transitionDuration: Duration(milliseconds: 2),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                "Booking",
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Overpass',
                    fontSize: 20),
              ),
              elevation: 0.0),
          backgroundColor: Colors.white.withOpacity(0.90),
          body: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: const Color(0xfff8f8f8),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Button(
                    title: '10:20 - 8:30 10-10-2022', onClick: _handleBooking),
                Button(
                    title: '10:20 - 8:30 10-10-2022', onClick: _handleBooking),
                Button(
                    title: '10:20 - 8:30 10-10-2022', onClick: _handleBooking),
                Button(
                    title: '10:20 - 8:30 10-10-2022', onClick: _handleBooking),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleBooking() {
    print('A date clicked');
  }
}
