import 'package:country_picker/country_picker.dart';
import 'package:fixer/Services/Auth/auth_repository.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/authentication/sign_in_screen.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:fixer/Widget/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../Widget/snackbar.dart';

class SignUpScreen extends StatefulWidget {
  static const String routName = "/SignUp";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController fController;
  late TextEditingController lController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  @override
  void initState() {
    fController = TextEditingController();
    lController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  bool loading = false;

  @override
  void dispose() {
    fController.dispose();
    lController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool hidePassword = false;

  String countyCode = '880';

  void pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (value) {
        setState(() {
          countyCode = value.phoneCode;
        });
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MaterialColr.primaryColor,
      bottomSheet: Container(
        color: MaterialColr.primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              logoWithName,
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
              const SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              Container(
                height: size.height * 0.65,
                width: size.width,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimensions.fontSizeDefault,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 4),
                      child: Text(
                        "REGISTRATION",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeLarge,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: fController,
                            borderColor: MaterialColr.primaryColor,
                            fillColor: Colors.white,
                            hintText: "First Name",
                            hintColor: MaterialColr.primaryColor,
                            hintFontSize: Dimensions.fontSizeExtraLarge,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.paddingSizeExtraSmall,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: lController,
                            borderColor: MaterialColr.primaryColor,
                            fillColor: Colors.white,
                            hintText: "Last Name",
                            hintColor: MaterialColr.primaryColor,
                            hintFontSize: Dimensions.fontSizeExtraLarge,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    CustomTextField(
                      controller: emailController,
                      borderColor: MaterialColr.primaryColor,
                      fillColor: Colors.white,
                      inputType: TextInputType.emailAddress,
                      hintText: "Email",
                      hintColor: MaterialColr.primaryColor,
                      hintFontSize: Dimensions.fontSizeExtraLarge,
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    CustomTextField(
                      controller: phoneController,
                      borderColor: MaterialColr.primaryColor,
                      showBorder: true,
                      inputType: TextInputType.phone,
                      fillColor: Colors.white,
                      hintColor: MaterialColr.primaryColor,
                      hintText: "Phone Number",
                      prefixIcon: TextButton(
                        onPressed: pickCountry,
                        child: Text(
                          "+" + countyCode + " |",
                          // style: TextStyle(color: MaterialColr.secondaryColor),
                        ),
                      ),
                      hintFontSize: Dimensions.fontSizeExtraLarge,
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeExtremeLarge,
                    ),
                    Spacer(),
                    CustomButton(
                      onpressed: () async {
                        if (phoneController.text.isEmpty) {
                          vibrateDevice();
                          showSnackBar(
                            context: context,
                            message: "Please enter your phone  number",
                            error: true,
                          );
                        } else if (!emailController.text.contains('@') ||
                            emailController.text.isEmpty) {
                          vibrateDevice();
                          showSnackBar(
                            context: context,
                            message: "please enter a valid email address",
                            error: true,
                          );
                        } else if (fController.text.isEmpty ||
                            lController.text.isEmpty) {
                          vibrateDevice();
                          {
                            showSnackBar(
                              context: context,
                              message: "Enter a valid name",
                              error: true,
                            );
                          }
                        } else {
                          showSnackBar(
                              context: context,
                              message: "Loading please wait...",
                              time: 2);
                          await AuthRepository.signUpWithPhone(
                            context,
                            "+${countyCode + phoneController.text.trim()}",
                            "${fController.text} ${lController.text}",
                            emailController.text,
                          );
                        }
                      },
                      backgroundColor: MaterialColr.primaryColor,
                      radius: 6,
                      title: "SIGN UP",
                      titleSize: Dimensions.fontSizeLarge,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1.5,
                          width: size.width * 0.25,
                          decoration: const BoxDecoration(
                            color: MaterialColr.primaryColor,
                          ),
                        ),
                        const Text(
                          "   OR   ",
                          style: TextStyle(
                            color: MaterialColr.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 1.5,
                          width: size.width * 0.25,
                          decoration: const BoxDecoration(
                            color: MaterialColr.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Center(
                      child: TextButton.icon(
                        icon: Text(
                          "SIGN IN",
                          style: TextStyle(
                            color: MaterialColr.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.fontSizeExtraLarge,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, SignInScreen.routName);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        label: const Icon(
                          Icons.arrow_forward_ios,
                          color: MaterialColr.primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
