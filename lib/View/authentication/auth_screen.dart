import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/authentication/sign_in_screen.dart';
import 'package:fixer/View/authentication/sign_up.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static const String routName = "/authScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MaterialColr.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: Dimensions.paddingSizeLarge,
          ),
          Spacer(),
          Image.asset(
            appLogo,
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          const Text(
            appName,
            textScaleFactor: 1.3,
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              letterSpacing: 10,
              fontSize: 28,
            ),
          ),
          SizedBox(
            height: Dimensions.paddingSizeExtraSmall,
          ),
          const Text(
            "Apartment maintenance app",
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              // fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          Spacer(),
          CustomButton(
            backgroundColor: MaterialColr.secondaryColor,
            onpressed: () {
              Navigator.pushNamed(context, SignInScreen.routName);
            },
            title: "Sign In",
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          CustomButton(
            onpressed: () {
              Navigator.pushNamed(context, SignUpScreen.routName);
            },
            backgroundColor: Colors.white,
            title: "Sign up",
            titleColor: MaterialColr.primaryColor,
          ),
          const SizedBox(
            height: Dimensions.paddingSizeExtraLarge,
          ),
        ],
      ),
    );
  }
}
