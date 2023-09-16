import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/View/admin/admin_screen.dart';
import 'package:fixer/View/maintainer/maintainer_screen.dart';
import 'package:fixer/View/user/user_screen.dart';
import 'package:flutter/material.dart';

class HomeScreeen extends StatelessWidget {
  static const String routName = "/HomeScreen";
  const HomeScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(
        "Here is current user data${FirebaseAuth.instance.currentUser}_++++++++++++++++++++++++++++++++++++");
    return Scaffold(
      // backgroundColor: MaterialColr.primaryColor,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MaterialColr.secondaryColor,
              MaterialColr.primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error.toString()}'));
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('User data not found.'));
            } else {
              // Extract the user's role from Firestore
              final userRole = snapshot.data!['role'] as String?;

              // Conditionally navigate to different screens based on the role
              if (userRole == 'user') {
                return const UserWidget();
              } else if (userRole == 'admin') {
                return const AdminWidget();
              } else if (userRole == 'maintainer') {
                return const MaintainerWidget();
              } else {
                // Default screen or handle other roles as needed
                return const Center(child: Text('Unknown role.'));
              }
            }
          },
        ),
      ),
    );
  }
}
