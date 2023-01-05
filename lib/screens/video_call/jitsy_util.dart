import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lettutor_app/models/class_history/class_history.dart';

joinMeetingJitsi(String studentToken) async {
  var token =studentToken.split("token=")[1];
  Map<String, dynamic> meetObject = JwtDecoder.decode(token);
  final String roomId = meetObject['room'];
  final options = JitsiMeetingOptions(room: roomId)
    ..serverURL = "https://meet.lettutor.com"
    ..audioOnly = true
    ..audioMuted = true
    ..token = token
    ..videoMuted = true;
  await JitsiMeet.joinMeeting(options);
}