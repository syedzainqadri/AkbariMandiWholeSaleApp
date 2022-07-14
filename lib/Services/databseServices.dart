import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:akbarimandiwholesale/data/model/response/firebaseuserModel.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //! Regarding Users

  Future<bool> createUser(FirebaseUserModel userModel) async {
    try {
      await firestore
          .collection("users")
          .doc(userModel.id)
          .collection('userDetials')
          .doc('userDetials')
          .set({
        "id": userModel.id,
        "fcmToken": userModel.fcmToken,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<String> getFcmToken(String uid) async {
    DocumentReference documentReference = firestore
        .collection('users')
        .doc(uid)
        .collection('userDetials')
        .doc('userDetials');
    String token;
    await documentReference.get().then((snapshot) {
      token = snapshot.get('fcmToken').toString();
      print('Token from Firebase is $token');
      List<FirebaseUserModel> retVal = [];
      retVal.add(FirebaseUserModel(
          id: snapshot.get('id').toString(), fcmToken: token));
    });
    return token;
  }

  Future<String> getId(String uid) async {
    DocumentReference documentReference = firestore
        .collection('users')
        .doc(uid)
        .collection('userDetials')
        .doc('userDetials');
    String id;
    await documentReference.get().then((snapshot) {
      id = snapshot.get('id').toString();
      List<FirebaseUserModel> retVal = [];
      retVal.add(FirebaseUserModel(
          id: snapshot.get('id').toString(),
          fcmToken: snapshot.get('fcmToken').toString()));
    });
    return id;
  }

  Stream<List<FirebaseUserModel>> userStreamm(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('userDetials')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<FirebaseUserModel> retVal = [];
      querySnapshot.docs.forEach((element) {
        retVal.add(FirebaseUserModel.fromFirestore(element));
      });
      return retVal;
    });
  }
}
