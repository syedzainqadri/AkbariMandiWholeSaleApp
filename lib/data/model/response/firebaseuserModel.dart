import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserModel {
  String id;
  String fcmToken;

  FirebaseUserModel({this.id, this.fcmToken});

  FirebaseUserModel.fromFirestore(DocumentSnapshot doc) {
    id = doc['id'];
    fcmToken = doc['fcmToken'];
  }
}
