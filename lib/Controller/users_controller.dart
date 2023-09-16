import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixer/Model/user_model.dart';
import 'package:fixer/Widget/snackbar.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  List<UserModel> _allUser = [];

  List<UserModel> get allUser => [..._allUser];

  Future<void> fetchAllUserFromFirebase(BuildContext context) async {
    try {
      final QuerySnapshot userCollection =
          await FirebaseFirestore.instance.collection('users').get();
      List<UserModel> temparayList = [];
      for (var doc in userCollection.docs) {
        _allUser = [];
        if (doc.data() != null) {
          Map<String, dynamic> userMap =
              await doc.data() as Map<String, dynamic>;
          final user = UserModel.fromMap(userMap);
          temparayList.add(user);
        }
      }

      _allUser = temparayList;
      notifyListeners();
    } catch (e) {
      _allUser = [];
      showSnackBar(context: context, message: e.toString(), error: true);
    }
  }

  // Future<void> fetchUserFixedFirebase(BuildContext context, String id) async {
  //   try {
  //     final DocumentSnapshot<Map<String, dynamic>> user =
  //         await FirebaseFirestore.instance.collection('users').doc(id).get();
  //     List<UserModel> temparayList = [];
  //     for (var doc in userCollection.docs) {
  //       _allUser = [];
  //       if (doc.data() != null) {
  //         Map<String, dynamic> userMap =
  //             await doc.data() as Map<String, dynamic>;
  //         final user = UserModel.fromMap(userMap);
  //         temparayList.add(user);
  //       }
  //     }
  //
  //     _allUser = temparayList;
  //     notifyListeners();
  //   } catch (e) {
  //     _allUser = [];
  //     showSnackBar(context: context, message: e.toString(), error: true);
  //   }
  // }
}
