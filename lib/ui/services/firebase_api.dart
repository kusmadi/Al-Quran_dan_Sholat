import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FirebaseApi {
  final String _fcmUrl = 'https://fcm.googleapis.com/fcm/send';
  final _fcmKey =
      "AAAApe9A618:APA91bGfe15k7IHSDzWJiJl3pMqd0_I7SPxv_u5qLS4kH_xW5j7Ty9C5d28m5hCAb6Z_1ln798Fsz0cT5cwzSU5dvZMcmIMZDEjLSHoIVkeGlgADfcNW_YJMQLN1VTPbDXtcLt34vn9k";

  void sendFcm(String title, String body, String image) {
    String fcmToken = '';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$_fcmKey'
    };
    var request = http.Request('POST', Uri.parse(_fcmUrl));

    FirebaseMessaging.instance.getToken().then((value) async {
      fcmToken = value.toString();
      request.body = '''{
              "to":"$fcmToken","priority":"high",
              "notification":{"title":"$title","body":"$body","sound":"default","image":"$image",},
          }''';
      request.headers.addAll(headers);
      log('Token: $fcmToken');

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        log('success : ${await response.stream.bytesToString()}');
      } else {
        log('no success : ${response.reasonPhrase}');
      }
    });
  }

  void subscribeFcm(String collection, token, String field) async {
    await FirebaseMessaging.instance.subscribeToTopic(field);

    await FirebaseFirestore.instance
        .collection(collection)
        .doc(token)
        .set({field: 'subscribed'}, SetOptions(merge: true));
  }
}
