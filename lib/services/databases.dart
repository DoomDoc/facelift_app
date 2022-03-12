import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facelift_constructions/constants.dart';

import '../models/models.dart';

class DatabaseService {
  final CollectionReference userCol =
      FirebaseFirestore.instance.collection('userData');

  final DocumentReference userData = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('Usr')
      .doc('userData');

  final DocumentReference userPremiumDoc = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('Usr')
      .doc('premiumData');

  // final DocumentReference userPremiumBool =
  //     FirebaseFirestore.instance.collection('userData').doc(number);

  final CollectionReference userHousePlan = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('housePlan');

  final CollectionReference userLaborer = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('laborer');

  final CollectionReference userHousebill = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('houseBills');

  final DocumentReference userHousebillAmount = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('Usr')
      .doc('amount');

  final DocumentReference userProfileDoc = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('Usr')
      .doc('profilePic');

  final DocumentReference userSiteSuperviserDoc = FirebaseFirestore.instance
      .collection('userData')
      .doc(number)
      .collection('Usr')
      .doc('superviser');

  final DocumentReference userRequestsLabor =
      FirebaseFirestore.instance.collection('RequestsLabor').doc(number);

  final DocumentReference userRequestForSuperDoc =
      FirebaseFirestore.instance.collection('RequestsSuperviser').doc(number);

  //-----------------------------------------------------------------------------------------

  Future<bool> checkUser() async {
    try {
      var d = await userCol.doc(number).get();
      return d.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> checkRequests() async {
    try {
      var d = await userRequestsLabor.get();
      return d.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> checkSuperviser() async {
    try {
      var d = await userRequestForSuperDoc.get();
      return d.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUserData() async {
    bool exist = await checkUser();
    if (exist) {
      return await userCol.doc(number).update({"phone": number});
    } else {
      return await userCol
          .doc(number)
          .set({"name": "new User", "phone": number});
    }
  }

  Future<void> updateUserName(String? val) async {
    return await userCol.doc(number).update({"name": val});
  }

  Future<void> updateUserPremium(bool val) async {
    return await userCol.doc(number).update({"premium": val});
  }

  Future<void> updateUserPremiumData(String name, int len, int bre, int area,
      String valueChose, String city, String state) async {
    return await userPremiumDoc.set({
      "name": name,
      "front": len,
      "back": bre,
      "type": valueChose,
      "area": area,
      "city": city,
      "state": state,
    });
  }

  Future<void> updateUserHousePlan(String? val, String? url) async {
    return await userHousePlan.doc().set({"name": val, "image": url});
  }

  Future<void> updateUserHouseBill(
    String? name,
    int? amount,
    int? warranty,
    String? url,
    int cDate,
    int cMonth,
    int cYear,
    int uDate,
    int uMonth,
    int uYear,
  ) async {
    return await userHousebill.doc().set({
      "name": name,
      "amount": amount,
      "warranty": warranty,
      "image": url,
      "current_date": cDate,
      "current_month": cMonth,
      "current_year": cYear,
      "user_date": uDate,
      "user_month": uMonth,
      "user_year": uYear,
    });
  }

  Future<void> updateUserHouseBillAmount(int? amount) async {
    return await userHousebillAmount.set({"total": amount});
  }

  Future<void> updateUserProfilePic(String? val) async {
    return await userProfileDoc.set({"url": val});
  }

  Future<void> updateUserRequestSuper(String? time, bool b, bool change) async {
    bool exist = await checkSuperviser();
    if (exist) {
      return await userRequestForSuperDoc
          .update({"time": time, "change": change});
    } else {
      return await userRequestForSuperDoc
          .set({"request": b, "time": time, "change": change});
    }
  }

  Future<void> updateUserRequestLabor(String? time, bool b, String name) async {
    bool exist = await checkRequests();
    if (exist) {
      return await userRequestsLabor.update({"time": time, name: true});
    } else {
      return await userRequestsLabor
          .set({"request": b, "time": time, name: true});
    }
  }

  //--------------------------------------------------------------------------------------------

  PremiumDataModel _premiumDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> dat = snapshot.data() as Map<String, dynamic>;
    return PremiumDataModel(
      houseName: dat["name"] ?? "House Name",
      length: dat["front"] ?? 0,
      bredth: dat["back"] ?? 0,
      type: dat["type"] ?? "Select",
      area: dat["area"] ?? 0,
      city: dat["city"] ?? "City",
      state: dat["state"] ?? "State",
    );
  }

  Uuser _userDataFromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> dat = snap.data() as Map<String, dynamic>;
    return Uuser(
        name: dat["name"] ?? "new user", phone: dat["phone"] ?? number);
  }

  UserPremiumBool _userPremiumBoolDataFromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> dat = snap.data() as Map<String, dynamic>;
    return UserPremiumBool(premium: dat["premium"] ?? false);
  }

  UserProfilePicModel _userProfilePicFromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> dat = snap.data() as Map<String, dynamic>;
    return UserProfilePicModel(url: dat["url"] ?? "");
  }

  SuperviserModel _userSuperviseFromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> dat = snap.data() as Map<String, dynamic>;
    return SuperviserModel(
        name: dat["name"] ?? "name",
        age: dat["age"] ?? "age",
        image: dat["image"] ??
            "https://cdn.searchenginejournal.com/wp-content/uploads/2019/08/c573bf41-6a7c-4927-845c-4ca0260aad6b-760x400.jpeg");
  }

  UserAmountModel _userAmountFromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> dat = snap.data() as Map<String, dynamic>;
    return UserAmountModel(total: dat["total"] ?? 0);
  }

  //-------------------------------------------------------------------------------------

  Stream<Uuser> get userDataStream {
    return userCol.doc(number).snapshots().map(_userDataFromSnapshot);
  }

  Stream<UserPremiumBool> get userPremiumBoolStream {
    return userCol
        .doc(number)
        .snapshots()
        .map(_userPremiumBoolDataFromSnapshot);
  }

  Stream<PremiumDataModel> get userPrmiumDataStream {
    return userPremiumDoc.snapshots().map(_premiumDataFromSnapshot);
  }

  Stream<UserProfilePicModel> get userProfilePicStream {
    return userProfileDoc.snapshots().map(_userProfilePicFromSnapshot);
  }

  Stream<SuperviserModel> get userSuperviserStream {
    return userSiteSuperviserDoc.snapshots().map(_userSuperviseFromSnapshot);
  }

  Stream<UserAmountModel> get userAmountStream {
    return userHousebillAmount.snapshots().map(_userAmountFromSnapshot);
  }
}
