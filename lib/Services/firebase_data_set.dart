import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixer/Model/techniation.dart';
import 'package:fixer/Model/user_model.dart';
import 'package:fixer/View/user/issue_confirm_screen.dart';
import 'package:fixer/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:uuid/uuid.dart';

class FirebaseDataSet {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<void> publishIssue(
    List<String> issuesList,
    String imageUrl,
    BuildContext context,
    String discriptions,
  ) async {
    try {
      final issueId = Uuid().v1().substring(0, 8);
      if (userModel != null) {
        final String userId = userModel!.id;

        // Query the sub-collection to check the length of previous issues
        final CollectionReference issuesCollection =
            firestore.collection('issues');

        // Publish the new issue with the incremented issue number
        await issuesCollection.doc(issueId).set({
          'apartmentName': userModel!.apartmentName,
          'userId': userModel?.id,
          'periority': 'normal',
          'dateReported': DateTime.now().toString(),
          'reportedBy': userModel!.name,
          'imageUrl': imageUrl,
          'discriptions': discriptions,
          'projectName': userModel!.projectName,
          'assignedTo': 'pending',
          'issuesList': issuesList,
          'fixed': false,
          'issueNumber': issueId.toString(),
          "userName": userModel!.name,
          "userPhone": userModel!.phoneNumber,
          "userEmail": userModel!.email,
          "techniationId": "",
          "techniationName": "",
          "techniationEmail": "",
          "techniationPhone": "",
        }).then((_) async {
          print("Here is issue id+++++++++++++++++++++++++++++++++$issueId");

          await sendEmail(
            subject: 'Issue Reported Confirmations',
            email: userModel!.email,
            text:
                "We have received your issue REPORT. Your APARTMENT Issue Identification Number is:$issueId. Your issue is important to us. We will resolve as soon as possible.Your issues; $issuesList ",
          );

          await sendEmail(
              subject: 'New Issue Reported',
              email: userModel!.maintainerEmail,
              text:
                  "A new issue is reported. Issue Identification Number is:$issueId.");
          showSnackBar(context: context, message: "Issues submit successfully");
          Navigator.pushReplacementNamed(
            context,
            IssueConfirmScreen.routName,
            arguments: issueId,
          );
        });
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
    }
  }

  static Future<void> addDetailofIssue({
    required String issueID,
    required bool lineOk,
    required supplierName,
    required bool supplierCalled,
    required String proposed,
    required String productName,
    required String productModel,
    required bool warrenty,
    required String price,
  }) async {
    final CollectionReference issuesCollection = firestore.collection('issues');

    await issuesCollection.doc(issueID).collection('Details').doc(issueID).set({
      "lineOk": lineOk,
      'supplierName': supplierName,
      'supplierCalled': supplierCalled,
      'proposed': proposed,
      "productName": productName,
      "productModel": productModel,
      "warrenty": warrenty,
      'price': price,
    });
  }

  static Future<void> addMoreDetailofIssue({
    required String planOfAction,
    required bool accoutApproved,
    required bool mangementApproved,
    required String issueID,
  }) async {
    final CollectionReference issuesCollection = firestore.collection('issues');

    await issuesCollection
        .doc(issueID)
        .collection('Details')
        .doc(issueID)
        .update({
      "planOfAction": planOfAction,
      'accoutApproved': accoutApproved,
      'mangementApproved': mangementApproved,
    });
  }

  static Future<void> updateIssue({
    required String planOfAction,
    required bool accoutApproved,
    required bool mangementApproved,
    required String proposed,
    required String issueID,
    required String updateProgress,
  }) async {
    final CollectionReference issuesCollection = firestore.collection('issues');

    await issuesCollection
        .doc(issueID)
        .collection('Progress')
        .doc(issueID)
        .set({
      "planOfAction": planOfAction,
      'accoutApproved': accoutApproved,
      'mangementApproved': mangementApproved,
      'proposed': proposed,
      'updateProgress': updateProgress,
    });
  }

  static Future<void> doneIssue({
    required String planOfAction,
    required bool accoutApproved,
    required bool mangementApproved,
    required String proposed,
    required String issueID,
    required String issueHappend,
    required String fixedissue,
    required bool firstPhoneCall,
    required bool reminderPhoneCall,
  }) async {
    final CollectionReference issuesCollection = firestore.collection('issues');

    await issuesCollection.doc(issueID).update({
      'fixed': true,
      'fixedDate': DateTime.now().toString(),
    });

    await issuesCollection.doc(issueID).collection('Done').doc(issueID).set({
      "planOfAction": planOfAction,
      'accoutApproved': accoutApproved,
      'mangementApproved': mangementApproved,
      'firstPhoneCall': firstPhoneCall,
      'reminderPhoneCall': reminderPhoneCall,
      'issueHappened': issueHappend,
      'fixedIssue': fixedissue,
      'proposed': proposed,
    });
  }

  static Future<void> updateData(String maintainerName, String maintainerEmail,
      String maintainerPhone) async {
    // Reference to the Firestore collection
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Retrieve all documents from the 'user' collection
    QuerySnapshot usersSnapshot = await usersCollection.get();
    print(
        "Here is user snapshot##############################${usersSnapshot.docs}");
    // Iterate through each document and update it
    for (QueryDocumentSnapshot userDoc in usersSnapshot.docs) {
      // Get the user ID
      String userId = userDoc.id;

      // Update the user document with the desired fields
      await usersCollection.doc(userId).update({
        'maintainerName': maintainerName,
        'maintainerEmail': maintainerEmail,
        'maintainerPhone': maintainerPhone,
      });

      print(
          'Updated user document for user ID: $userId+++++++++++++++++++++++++++++++++++++++=');
    }
  }

  static Future<void> userDetailApproved() async {
    final CollectionReference issuesCollection = firestore.collection('users');

    await issuesCollection.doc(userModel!.id).update({
      'addDetail': true,
    });
  }

  Future<List<String>> fetchData() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('issues')
            .doc(user.uid)
            .get();

        final List<dynamic>? data = doc['data'];

        if (data != null && data is List<String>) {
          return data;
        }
      }
    } catch (e) {
      print('Error fetching data: $e +++++++++++');
    }

    return [];
  }

  static Future<void> updateTechniationsData(
      String issueNumber,
      String techniationName,
      String techniationEmail,
      String techniationPhone,
      BuildContext context) async {
    try {
      final CollectionReference issuesCollection =
          FirebaseFirestore.instance.collection('issues');
      // Use the update method to update specific fields in the document.

      await issuesCollection.doc(issueNumber).update({
        'assignedTo': 'Assign',
      });

      await issuesCollection.doc(issueNumber).update(Technicians(
              techniationName: techniationName,
              techniationEmail: techniationEmail,
              techniationPhone: techniationPhone)
          .toMap());
    } catch (e) {
      vibrateDevice();
      print('Error updating document: ++++++++++++++++++++++++++++++++$e');
    }
  }

  static Future<DocumentSnapshot> fetchProgressData(String issueId) async {
    try {
      // Reference to the Firestore collection "Issues"

      print(
          "here is issue number +++++++++++++++++++++++++++++++++++++++++$issueId");
      CollectionReference issuesCollection =
          FirebaseFirestore.instance.collection("issues");

      // Reference to the specific issue document using the provided ID
      DocumentReference issueDoc = issuesCollection.doc(issueId);

      // Reference to the "Progress" subcollection of the issue document
      CollectionReference progressCollection = issueDoc.collection("Progress");

      // Reference to the specific progress document using the provided ID
      DocumentReference progressDoc = progressCollection.doc(issueId);

      // Fetch the data from Firestore
      DocumentSnapshot progressSnapshot = await progressDoc.get();

      return progressSnapshot;
    } catch (e) {
      // Handle errors here
      print("Error fetching progress data: $e");
      throw e; // Rethrow the error for the FutureBuilder to handle
    }
  }

  static Future<void> issueSubmitAgain(
    String description,
    String issueID,
    String newImage,
    BuildContext context,
  ) async {
    final CollectionReference issuesCollection = firestore.collection('issues');

    await issuesCollection.doc(issueID).update({
      'fixed': false,
    });

    await issuesCollection
        .doc(issueID)
        .collection('againSubmit')
        .doc(issueID)
        .set({
      'descriptions': description,
      'imageUrl': newImage,
    });
  }
}

Future<void> sendEmail(
    {required String subject, required String text, String? email}) async {
  try {
    final smtpServer = gmail(
      "atik.firebase@gmail.com",
      // "@#Firebase#@"
      "vuaz gaoz eisk rqbf",
    );

    final message = Message()
      ..from = Address("atik.firebase@gmail.com",
          "Fixer Admin") // Replace with your email and name
      ..recipients.add(email) // Replace with the recipient's email address
      ..subject = subject
      ..text = text;
    await send(message, smtpServer);
  } catch (e) {
    print("Here is error +++++++++++++++++++++++++++++++++++");
    print(e.toString());
  }
}
