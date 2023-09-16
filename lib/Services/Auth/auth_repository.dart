import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixer/Model/user_model.dart';
import 'package:fixer/View/Home/home.dart';
import 'package:fixer/View/Registrations/register_detail.dart';
import 'package:fixer/View/authentication/auth_confirm_screen.dart';
import 'package:fixer/View/authentication/auth_screen.dart';
import 'package:fixer/View/authentication/otp_screeen2.dart';
import 'package:flutter/material.dart';

import '../../Widget/snackbar.dart';

class AuthRepository {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Future<void> signUpWithPhone(
    BuildContext context,
    String phoneNumber,
    String name,
    String email,
  ) async {
    try {
      print('THis button is pressed');
      print(phoneNumber);
      final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (result.docs.isNotEmpty) {
        vibrateDevice();
        showSnackBar(
            context: context, message: "Email already used", error: true);
        return;
      }

      final QuerySnapshot<Map<String, dynamic>> phoneNumberResult =
          await FirebaseFirestore.instance
              .collection('users')
              .where('phoneNumber', isEqualTo: phoneNumber)
              .get();

      if (phoneNumberResult.docs.isNotEmpty) {
        vibrateDevice();
        showSnackBar(
          context: context,
          message: "Phone number already used",
          error: true,
        );
        // Phone number already exist
        return;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(
        context: context,
        message: e.toString(),
        error: true,
      );
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
    }
  }

  // this method is for signIn otp
  static Future<void> signInWithPhone2(
    BuildContext context,
    String phoneNumber,
  ) async {
    try {
      print(
          'phone number is here===========================================$phoneNumber==========================');
      final QuerySnapshot<Map<String, dynamic>> phoneNumberResult =
          await FirebaseFirestore.instance
              .collection('users')
              .where('phoneNumber', isEqualTo: phoneNumber)
              .get();

      if (phoneNumberResult.docs.isEmpty) {
        vibrateDevice();
        showSnackBar(
          context: context,
          message:
              "We did not find your record in our system. Please register again",
          error: true,
        );
        return;
      } else {
        print(
            "here is aut ============================================+${FirebaseAuth.instance.currentUser?.uid}=======================");

        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => HomeScreeen(),
        //     ),
        //     (route) => false);
      }

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credntial) {
          _firebaseAuth.signInWithCredential(credntial);
        },
        verificationFailed: (error) {
          throw error.message.toString();
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.pushNamed(
            context,
            OtpScreen2.routName,
            arguments: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showSnackBar(
        context: context,
        message: e.toString(),
        error: true,
      );
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
    }
  }

  static Future<void> verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
    required String name,
    required String phoneNumber,
    required String email,
  }) async {
    try {
      final creditonal = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await _firebaseAuth.signInWithCredential(creditonal).then((_) async {
        await uploadUserDataToFirestore(name, email, phoneNumber).then((value) {
          FetchUserDetail(context).then((value) {
            Navigator.pushReplacementNamed(
                context, RegisterDetailScreen.routName);
            showSnackBar(context: context, message: "code verified");
          });
        });
      });
    } on FirebaseException catch (e) {
      showSnackBar(
          context: context, message: e.message.toString(), error: true);
    }
  }

// /to verify the otp screen
  static Future<void> verifyOtp2({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final creditonal = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await _firebaseAuth.signInWithCredential(creditonal).then((_) async {
        await AuthenticUser(context);
      });
    } on FirebaseException catch (e) {
      vibrateDevice();
      showSnackBar(
          context: context, message: e.message.toString(), error: true);
    } catch (e) {
      vibrateDevice();
      showSnackBar(context: context, message: e.toString(), error: true);
    }
  }

  static Future<void> FetchUserDetail(BuildContext context) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (userSnapshot.exists && userSnapshot.data() != null) {
      final userData = await userSnapshot.data() as Map<String, dynamic>;
      print(
          "Here is user data that needs to be update+++++++++++++++++++++++++");
      userModel = UserModel.fromMap(userData);
    } else {
      showSnackBar(
          context: context,
          message: "Your data is not exist in our database!",
          error: true);
    }
  }

  static Future<void> AuthenticUser(BuildContext context) async {
    print("here is authenticate is pr function is called");
    print(
        'Here is authection of the user +++++++++======================================+++++++++++++++++++++${FirebaseAuth.instance.currentUser?.uid}');
    DocumentSnapshot userSnapshot = await firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    print(
        "Here is user snapshot +++++++++++++++++++++++++++++++++++++${userSnapshot.data()}");
    if (userSnapshot.exists && userSnapshot.data() != null) {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      userModel = await UserModel.fromMap(userData);
      print(
          "Here is user data that needs to be update+++++++++++++++++++++++++$userData");
      print(
          "Here is user data that needs to be update+++++++++++++++++++++++++$userModel");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreeen(),
          ));
      showSnackBar(context: context, message: "Login successfully");
    } else {
      vibrateDevice();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ),
      );
      showSnackBar(
          context: context,
          message: "Your data is not exist in our database!",
          error: true);
    }
  }

  static Future<void> uploadUserDataToFirestore(
      String name, String email, String phoneNumber) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser?.uid)
          .set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'role': "user",
        'id': _firebaseAuth.currentUser?.uid,
      });
      print('User data uploaded to Firestore successfully');
    } catch (e) {
      print('Error uploading user data: $e');
    }
  }

  static Future<void> saveRegistrationDataToFirestore(
      String projectName,
      String floorName,
      String apartmentName,
      BuildContext context,
      DateTime contractYear,
      String duration) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel?.id)
          .update({
        'projectName': projectName,
        'floorName': floorName,
        'apartmentName': apartmentName,
        'contractStart': contractYear,
        'duration': duration,
      }).then((_) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AuthConfirmScreen(),
            ));
        showSnackBar(
          context: context,
          message: "Save info successfully",
        );
      });
    } catch (e) {
      print("Here is error++++++++++++++++++++++++++++++++++++$e");
      showSnackBar(context: context, message: e.toString(), error: true);
      vibrateDevice();
    }
  }

  static Future<void> signOut(BuildContext context) async {
    _firebaseAuth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ),
        (route) => false);
  }
}
