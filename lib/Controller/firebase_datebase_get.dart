import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixer/Model/manger.dart';
import 'package:fixer/Model/techniation.dart';
import 'package:fixer/main.dart';
import 'package:flutter/material.dart';

class RegistrationDetailC extends ChangeNotifier {
  List<String> _projectName = [];
  List<String> _floorName = [];
  List<String> _apartName = [];
  List<String> _buildingName = [];
  List<String> _mangerName = [];
  List<MangerDetail> _mangerlist = [];
  List<String> _techniationList = [];
  String _termConditions = '';

  List<String> get projectName => [..._projectName];
  List<String> get floorName => [..._floorName];
  List<String> get apartName => [..._apartName];
  List<String> get buildingName => [..._buildingName];
  List<String> get mangerName => [..._mangerName];
  List<MangerDetail> get mangerlist => [..._mangerlist];
  List<String> get techniationList => [..._techniationList];
  String get termsConditions => _termConditions;

  Future<void> fetchProductNames() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Projects').get();

      _projectName.clear();
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          _projectName.add(doc.id.toString());
          notifyListeners();
        });
      } else {
        _projectName.clear();
      }
    } catch (e) {
      print('Error fetching product names: $e');
      _projectName.clear();
    }
  }

  Future<void> fetchfloorName(String doc) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Projects')
          .doc(doc)
          .collection("floor")
          .get();

      _floorName.clear();
      print(
          "Here is floor name+++++++++++++++++++++++++++++++++++++++++++${querySnapshot.docs}");

      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          _floorName.add(doc.id.toString());
        });
      } else {
        _floorName.clear();
      }
      print(
          "Here is floor name+++++++++++++++++++++++++++++++++++++++++++$_floorName");

      notifyListeners();
    } catch (e) {
      print('Error fetching product names: $e');
      _floorName.clear();
    }
  }

  Future<void> fetchApartmentName(String doc) async {
    print("Here is project name+++++++++++++++++++++++++++++++$doc");
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Projects')
          .doc(doc)
          .collection("apartment")
          .get();
      print(
          "Here is apartment name+++++++++++++++++++++++++++++++++++++++++++${apartName}");

      print(querySnapshot.docs);
      _apartName.clear();
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          _apartName.add(doc.id.toString());
        });
      } else {
        _apartName.clear();
      }
      notifyListeners();
    } catch (e) {
      _apartName.clear();
    }
  }

  Future<void> fetchBuildingNames() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Buildings').get();

      _buildingName.clear();
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          _buildingName.add(doc.id.toString());
        });
      } else {
        _buildingName.clear();
      }
      notifyListeners();
    } catch (e) {
      _buildingName.clear();
    }
  }

  Future<void> fetchTechniationNames() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Technician').get();

      _techniationList.clear();
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          _techniationList.add(doc.id.toString());
        });
      } else {
        _techniationList.clear();
      }
      notifyListeners();
    } catch (e) {
      _techniationList.clear();
    }
  }

  Future<void> fetchTechnicianDetails(String technicianDocName) async {
    try {
      final DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('Technician')
          .doc(technicianDocName)
          .get();

      if (docSnapshot.exists) {
        final Map<String, dynamic> data =
            docSnapshot.data() as Map<String, dynamic>;
        techniation = Technicians.fromMap(data);
      } else {
        return null; // Document doesn't exist
      }
    } catch (e) {
      return null; // An error occurred
    }
  }

  Future<void> fetchTermsCondition() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('termsConditions').get();

      _termConditions = '';
      if (querySnapshot.docs.isNotEmpty) {
        _termConditions = querySnapshot.docs[0].id.toString() ?? '';
      } else {
        _termConditions = '';
      }
      notifyListeners();
    } catch (e) {
      _termConditions = '';
    }
  }

  Future<void> fetchMangerNames(String buildingName) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Buildings')
          .doc(buildingName)
          .collection('manger')
          .get();

      _mangerName.clear();
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          _mangerName.add(doc.id.toString());
        });
      } else {
        _mangerName.clear();
      }
      notifyListeners();
    } catch (e) {
      _mangerName.clear();
    }
  }

  Future<void> fetchMangerDetail(String buildingName, String mangerName) async {
    try {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Buildings')
          .doc(buildingName)
          .collection('manger')
          .doc(mangerName)
          .get();

      _mangerlist.clear();
      if (documentSnapshot.data() != null) {
        MangerDetail? mangerDetail = MangerDetail.fromMap(
            documentSnapshot.data() as Map<String, dynamic>);
        _mangerlist.add(mangerDetail);
      } else {
        _mangerlist.clear();
      }
      notifyListeners();
    } catch (e) {
      _mangerlist.clear();
    }
  }
}
