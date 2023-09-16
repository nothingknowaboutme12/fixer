import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixer/Model/issue.dart';
import 'package:fixer/Model/user_model.dart';
import 'package:flutter/material.dart';

class FixedController with ChangeNotifier {
  // user issue
  List<IssueModel> _fixedIssues = [];
  List<IssueModel> _unfixedIssues = [];
  List<IssueModel> get fixedIssue => [..._fixedIssues];
  List<IssueModel> get unfixedIssue => [..._unfixedIssues];
  int _totalIssueSolved = 0;

  int get totalIssueSolved => _totalIssueSolved;

  Future<void> fetchFixedIssues() async {
    try {
      // Reference to the Firestore collection where issues are stored
      final issuesCollection =
          await FirebaseFirestore.instance.collection('issues').get();

      // Query Firestore to get documents where 'fixed' is true

      // Loop through the query snapshot and convert each document to an Issue object
      _fixedIssues.clear();
      for (final doc in issuesCollection.docs) {
        final fixed = doc.data()['fixed'] ?? false;
        final currentUserIssues = doc.data()['userId'] ?? '';
        print("........................................" + currentUserIssues ==
            userModel!.id);
        if (fixed == true && currentUserIssues == userModel!.id) {
          print(
              "Here is data inside the fixed issue@@@@@@@@@@@@@@@@@@@@@@@@@@@${doc.data()}");
          IssueModel issueModel = IssueModel.fromMap(doc.data());
          _fixedIssues.add(issueModel);
        }
      }
      notifyListeners();
    } catch (e) {
      _fixedIssues.clear();
      print('Error fetching fixed issues: $e');
    }
  }

  // Future<void> fetchUnFixedIssues() async {
  //   try {
  //     // Reference to the Firestore collection where issues are stored
  //     final issuesCollection = await FirebaseFirestore.instance
  //         .collection('issues')
  //         .orderBy('dateReported', descending: true)
  //         .get();
  //
  //     // Query Firestore to get documents where 'fixed' is true
  //
  //     // Loop through the query snapshot and convert each document to an Issue object
  //     _unfixedIssues.clear();
  //     for (final doc in issuesCollection.docs) {
  //       final fixed = doc.data()['fixed'] ?? false;
  //       final currentUserIssues = doc.data()['userId'] ?? '';
  //       if (fixed == false && currentUserIssues == userModel!.id) {
  //         IssueModel issueModel = IssueModel.fromMap(doc.data());
  //         _unfixedIssues.add(issueModel);
  //       }
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     _unfixedIssues.clear();
  //     print('Error fetching fixed issues: $e');
  //   }
  // }
  Future<void> fetchUnFixedIssues() async {
    try {
      // Reference to the Firestore collection where issues are stored
      final issuesCollection =
          await FirebaseFirestore.instance.collection('issues').get();

      // Clear the list of unresolved issues
      _unfixedIssues.clear();

      // Create a list to store issues that match the filter criteria
      List<IssueModel> filteredIssues = [];

      // Loop through the query snapshot and filter documents
      for (final doc in issuesCollection.docs) {
        final fixed = doc.data()['fixed'] ?? false;
        final currentUserIssues = doc.data()['userId'] ?? '';

        if (fixed == false && currentUserIssues == userModel!.id) {
          IssueModel issueModel = IssueModel.fromMap(doc.data());
          filteredIssues.add(issueModel);
        }
      }

      // Sort the filtered issues by descending date
      filteredIssues.sort((a, b) => a.dateReported.compareTo(b.dateReported));

      // Add the sorted issues to the _unfixedIssues list
      _unfixedIssues.addAll(filteredIssues);

      // Notify listeners after populating the list
      notifyListeners();
    } catch (e) {
      _unfixedIssues.clear();
      print('Error fetching unresolved issues: $e');
    }
  }

  //admin issue
  List<IssueModel> _fixedUserIssues = [];
  List<IssueModel> _unfixedUserIssues = [];
  List<IssueModel> get fixedUserIssue => [..._fixedUserIssues];
  List<IssueModel> get unfixedUserIssue => [..._unfixedUserIssues];
  // Future<void> fetchUnFixedAdminIssues() async {
  //   try {
  //     // Reference to the Firestore collection where issues are stored
  //     final issuesCollection =
  //         await FirebaseFirestore.instance.collection('issues').get();
  //
  //     // Query Firestore to get documents where 'fixed' is true
  //
  //     // Loop through the query snapshot and convert each document to an Issue object
  //     _unfixedAdminIssues.clear();
  //     for (final doc in issuesCollection.docs) {
  //       final fixed = doc.data()['fixed'] ?? false;
  //       final periority = doc.data()[' periority'];
  //
  //       if (fixed == false) {
  //         if (periority == 'high') {
  //           IssueModel issueModel = IssueModel.fromMap(doc.data());
  //           _unfixedAdminIssues.insert(0, issueModel);
  //         } else {
  //           IssueModel issueModel = IssueModel.fromMap(doc.data());
  //           _unfixedAdminIssues.add(issueModel);
  //         }
  //       }
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     _unfixedAdminIssues.clear();
  //     print('Error fetching fixed issues: $e');
  //   }
  // }

  Future<void> fetchFixedUserIssues(String id) async {
    try {
      // Reference to the Firestore collection where issues are stored
      final issuesCollection =
          await FirebaseFirestore.instance.collection('issues').get();

      // Query Firestore to get documents where 'fixed' is true

      // Loop through the query snapshot and convert each document to an Issue object
      _fixedUserIssues.clear();
      for (final doc in issuesCollection.docs) {
        print("here is all doces $doc+++++++++++++++++++++++++++++");
        final fixed = doc.data()['fixed'] ?? false;
        final uid = doc.data()['userId'] ?? '';
        if (fixed == true && uid == id) {
          IssueModel issueModel = IssueModel.fromMap(doc.data());
          _fixedUserIssues.add(issueModel);
        }
      }
      notifyListeners();
    } catch (e) {
      _fixedUserIssues.clear();
      print('Error fetching fixed issues: $e');
    }
  }

  //maintainer
  List<IssueModel> _fixedMaintainerIssues = [];
  List<IssueModel> _unfixedMaintainerIssues = [];
  List<IssueModel> get fixedMaintainerIssue => [..._fixedMaintainerIssues];
  List<IssueModel> get unfixedMaintainerIssue => [..._unfixedMaintainerIssues];

  Future<void> fetchFixedMaintainerIssues() async {
    try {
      // Reference to the Firestore collection where issues are stored
      final issuesCollection =
          await FirebaseFirestore.instance.collection('issues').get();

      // Query Firestore to get documents where 'fixed' is true

      // Loop through the query snapshot and convert each document to an Issue object
      _fixedMaintainerIssues.clear();
      for (final doc in issuesCollection.docs) {
        final fixed = doc.data()['fixed'] ?? false;

        if (fixed == true) {
          IssueModel issueModel = IssueModel.fromMap(doc.data());
          _fixedMaintainerIssues.add(issueModel);
        }
      }
      notifyListeners();
    } catch (e) {
      _fixedMaintainerIssues.clear();
      print('Error fetching fixed issues: $e');
    }
  }

  Future<void> fetchTotalIssues() async {
    try {
      // Reference to the Firestore collection where issues are stored
      final issuesCollection =
          await FirebaseFirestore.instance.collection('issues').get();

      // Query Firestore to get documents where 'fixed' is true

      // Loop through the query snapshot and convert each document to an Issue object
      _totalIssueSolved = 0;
      int coutner = 0;
      for (final doc in issuesCollection.docs) {
        final fixed = doc.data()['fixed'] ?? false;

        if (fixed == true) {
          coutner++;
        }
      }
      _totalIssueSolved = coutner;

      notifyListeners();
    } catch (e) {
      _totalIssueSolved = 0;
      print('Error fetching fixed issues: $e');
    }
  }

  Future<void> fetchUnFixedMaintainerIssues() async {
    try {
      // Reference to the Firestore collection where issues are stored
      final issuesCollection =
          await FirebaseFirestore.instance.collection('issues').get();

      // Query Firestore to get documents where 'fixed' is true
      // Loop through the query snapshot and convert each document to an Issue object
      _unfixedMaintainerIssues.clear();
      List<IssueModel> filteredIssues = [];
      for (final doc in issuesCollection.docs) {
        final fixed = doc.data()['fixed'] ?? false;

        if (fixed == false) {
          IssueModel issueModel = IssueModel.fromMap(doc.data());
          filteredIssues.add(issueModel);
        }
      }

      filteredIssues.sort((a, b) => a.dateReported.compareTo(b.dateReported));

      _unfixedMaintainerIssues.addAll(filteredIssues);

      notifyListeners();
    } catch (e) {
      _unfixedMaintainerIssues.clear();
    }
  }
}
