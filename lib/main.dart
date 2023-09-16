import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fixer/Controller/firebase_datebase_get.dart';
import 'package:fixer/Controller/fixed_list_controller.dart';
import 'package:fixer/Controller/users_controller.dart';
import 'package:fixer/Model/issue.dart';
import 'package:fixer/Model/techniation.dart';
import 'package:fixer/Model/user_model.dart';
import 'package:fixer/Services/firebase_data_set.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/error_screen.dart';
import 'package:fixer/View/Home/home.dart';
import 'package:fixer/View/Home/mangerDetailScreen.dart';
import 'package:fixer/View/Registrations/register_detail.dart';
import 'package:fixer/View/admin/all_user_screen.dart';
import 'package:fixer/View/admin/fixed_user_issue.dart';
import 'package:fixer/View/authentication/auth_screen.dart';
import 'package:fixer/View/authentication/otp_screeen2.dart';
import 'package:fixer/View/authentication/otp_screen.dart';
import 'package:fixer/View/authentication/sign_in_screen.dart';
import 'package:fixer/View/authentication/sign_up.dart';
import 'package:fixer/View/maintainer/Mark%20Done/done_screen.dart';
import 'package:fixer/View/maintainer/Mark%20Done/unsolved_issue_mark_done.dart';
import 'package:fixer/View/maintainer/add_issue_detail_screen1.dart';
import 'package:fixer/View/maintainer/add_issue_detail_screen2.dart';
import 'package:fixer/View/maintainer/assign_issue.dart';
import 'package:fixer/View/maintainer/maintainer_unsoled_issue_screen.dart';
import 'package:fixer/View/user/building_name_screen.dart';
import 'package:fixer/View/user/categorey_screen.dart';
import 'package:fixer/View/user/fixed_issue.dart';
import 'package:fixer/View/user/issue_confirm_screen.dart';
import 'package:fixer/View/user/issue_list_screen.dart';
import 'package:fixer/View/user/still_not_fixed.dart';
import 'package:fixer/View/user/unsoled_issue_screen.dart';
import 'package:fixer/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'View/admin/fixed_issue_time_take_screen.dart';
import 'View/maintainer/Add progress/add_progess_screen.dart';
import 'View/maintainer/Add progress/unsolved_issue_progress_screen.dart';
import 'View/maintainer/maintainer_fixed_issue.dart';
import 'View/user/Progress/progress_screen.dart';
import 'View/user/Progress/unsolved_issue_progress_screen.dart';

Technicians? techniation;
late AudioPlayer audioPlayer;
void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  audioPlayer = await AudioPlayer();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegistrationDetailC(),
        ),
        ChangeNotifierProvider(
          create: (context) => FixedController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserController(),
        ),
      ],
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        color: MaterialColr.primaryColor,
        home: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor: MaterialColr.primaryColor,
                  body: Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                );
              } else if (snapshot.hasError) {
                // Handle error
                return ErrorScreen(error: snapshot.error.toString());
              } else if (snapshot.hasData && snapshot.data!.exists) {
                userModel = UserModel.fromMap(
                    snapshot.data!.data() as Map<String, dynamic>);

                print(
                    "Here is user role##############################${userModel!.role}");
                if (userModel!.role == 'user' &&
                    userModel!.addDetail == false) {
                  return const RegisterDetailScreen();
                } else if (userModel!.role == 'maintainer') {
                  print(
                      "Here is user role##############################${userModel!.apartmentName}");
                  FirebaseDataSet.updateData(
                    userModel!.name,
                    userModel!.email,
                    userModel!.phoneNumber,
                  );
                  // todo remove this
                  return HomeScreeen();
                } else {
                  userModel = UserModel.fromMap(
                      snapshot.data!.data() as Map<String, dynamic>);
                  return HomeScreeen();
                }
              } else {
                return AuthScreen();
              }
            }),
        onGenerateRoute: generateRoutes,
      ),
    );
  }
}

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routName:
      return MaterialPageRoute(
        builder: (context) => AuthScreen(),
      );
    case SignInScreen.routName:
      return MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      );
    case SignUpScreen.routName:
      return MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      );
    case OtpScreen.routName:
      var argument = settings.arguments as Map<String, dynamic>;
      ;
      final name = argument['name'];
      final email = argument['email'];
      final id = argument['id'];
      final phoneNumber = argument['phoneNumber'];
      return MaterialPageRoute(
        builder: (context) => OtpScreen(
          name: name,
          email: email,
          verificationId: id,
          phoneNumber: phoneNumber,
        ),
      );

    case RegisterDetailScreen.routName:
      return MaterialPageRoute(
        builder: (context) => const RegisterDetailScreen(),
      );
    case CategoryScreen.routName:
      return MaterialPageRoute(
        builder: (context) => CategoryScreen(),
      );

    case OtpScreen2.routName:
      final arguments = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => OtpScreen2(verificationId: arguments.toString()),
      );
    case BuildingNameScreen.routName:
      return MaterialPageRoute(
        builder: (context) => const BuildingNameScreen(),
      );

    case MangerDetailScreen.routName:
      final argumenets = settings.arguments;
      return MaterialPageRoute(
        builder: (context) =>
            MangerDetailScreen(buildinName: argumenets.toString()),
      );

    case IssueListScreen.routName:
      return MaterialPageRoute(
        builder: (context) => IssueListScreen(),
      );
    case IssueConfirmScreen.routName:
      final arguments = settings.arguments.toString();
      return MaterialPageRoute(
        builder: (context) => IssueConfirmScreen(
          identicationNumber: arguments,
        ),
      );
    case FixedIssueTableScreen.routName:
      return MaterialPageRoute(
        builder: (context) => FixedIssueTableScreen(),
      );
    case UnFixedIssueTableScreen.routName:
      return MaterialPageRoute(
        builder: (context) => UnFixedIssueTableScreen(),
      );
    case FixedMaintainerScreen.routName:
      return MaterialPageRoute(
        builder: (context) => FixedMaintainerScreen(),
      );
    case UnFixedIssueMaintainerScreen.routName:
      return MaterialPageRoute(
        builder: (context) => UnFixedIssueMaintainerScreen(),
      );
    case AssignIssueScreen.routName:
      IssueModel issueModel = settings.arguments as IssueModel;
      return MaterialPageRoute(
        builder: (context) => AssignIssueScreen(
          issueModel: issueModel,
        ),
      );
    case AddIssueDetailScreen1.routName:
      IssueModel issueModel = settings.arguments as IssueModel;
      return MaterialPageRoute(
        builder: (context) => AddIssueDetailScreen1(
          issueModel: issueModel,
        ),
      );
    case AddIssueDetailScreen2.routName:
      IssueModel issueModel = settings.arguments as IssueModel;
      return MaterialPageRoute(
        builder: (context) => AddIssueDetailScreen2(
          issueModel: issueModel,
        ),
      );
    case AddProgressScreen.routName:
      IssueModel issueModel = settings.arguments as IssueModel;
      return MaterialPageRoute(
        builder: (context) => AddProgressScreen(
          issueModel: issueModel,
        ),
      );
    case IssueDoneScreen.routName:
      IssueModel issueModel = settings.arguments as IssueModel;
      return MaterialPageRoute(
        builder: (context) => IssueDoneScreen(
          issueModel: issueModel,
        ),
      );
    case ViewProgressScreen.routName:
      IssueModel issueModel = settings.arguments as IssueModel;
      return MaterialPageRoute(
        builder: (context) => ViewProgressScreen(
          issueModel: issueModel,
        ),
      );
    case StillNotFixedIssueScreen.routName:
      IssueModel issueModel = settings.arguments as IssueModel;
      return MaterialPageRoute(
        builder: (context) => StillNotFixedIssueScreen(
          issueModel: issueModel,
        ),
      );
    case UnfixedProgressScreen.routName:
      return MaterialPageRoute(
        builder: (context) => UnfixedProgressScreen(),
      );
    case UnfixedIssueDoneScreen.routName:
      return MaterialPageRoute(
        builder: (context) => UnfixedIssueDoneScreen(),
      );
    case UnFixedIssueProgressScreen.routName:
      return MaterialPageRoute(
        builder: (context) => UnFixedIssueProgressScreen(),
      );
    case AllUserScreen.routName:
      return MaterialPageRoute(
        builder: (context) => AllUserScreen(),
      );
    case IssueTimeDisplayScreen.routName:
      return MaterialPageRoute(
        builder: (context) => IssueTimeDisplayScreen(),
      );

    case FixedUserScreen.routName:
      String id = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => FixedUserScreen(
          id: id,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) =>
            ErrorScreen(error: "${settings.name} Something went wront"),
      );
  }
}
