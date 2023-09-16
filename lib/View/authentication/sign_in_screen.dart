import 'package:country_picker/country_picker.dart';
import 'package:fixer/Services/Auth/auth_repository.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/authentication/sign_up.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:fixer/Widget/custom_textfield.dart';
import 'package:fixer/Widget/snackbar.dart';
import 'package:flutter/material.dart';

enum Type {
  User,
  Admin,
  Maintainer,
}

class SignInScreen extends StatefulWidget {
  static const String routName = "/SignIn";

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController phoneController;

  @override
  void initState() {
    phoneController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();

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
                        "SIGN IN",
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
                    CustomTextField(
                      controller: phoneController,
                      borderColor: MaterialColr.primaryColor,
                      fillColor: Colors.white,
                      hintText: "Phone Number",
                      prefixIcon: TextButton(
                        onPressed: pickCountry,
                        child: Text(
                          "+" + countyCode + " |",
                        ),
                      ),
                      hintColor: MaterialColr.primaryColor,
                      inputAction: TextInputAction.done,
                      hintFontSize: Dimensions.fontSizeExtraLarge,
                    ),
                    Spacer(),
                    SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    CustomButton(
                      onpressed: () async {
                        if (phoneController.text.isEmpty) {
                          vibrateDevice();
                          showSnackBar(
                            context: context,
                            message: "Please enter a number",
                            error: true,
                          );
                        } else {
                          showSnackBar(
                            context: context,
                            message: "Loading please wait....",
                            time: 2,
                          );
                          await AuthRepository.signInWithPhone2(
                              context, '+${countyCode}${phoneController.text}');
                        }
                      },
                      backgroundColor: MaterialColr.primaryColor,
                      radius: 6,
                      title: "SIGN IN",
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
                          "CREATE ACCOUNT",
                          style: TextStyle(
                            color: MaterialColr.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.fontSizeExtraLarge,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.routName);
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
