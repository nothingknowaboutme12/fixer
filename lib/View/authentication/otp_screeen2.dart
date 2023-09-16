import 'package:fixer/Services/Auth/auth_repository.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../Widget/snackbar.dart';

class OtpScreen2 extends StatefulWidget {
  static const String routName = "/OtpScreen2";

  String verificationId;
  OtpScreen2({super.key, required this.verificationId});

  @override
  State<OtpScreen2> createState() => _OtpScreen2State();
}

class _OtpScreen2State extends State<OtpScreen2> {
  late TextEditingController otpController;
  @override
  void initState() {
    otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
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
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              logoWithName,
              const SizedBox(
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
                  children: [
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Text(
                      "We have just sent a six digit verification code number to your mobile phone by SMS. To activate your app, please enter the 6 digit code below:",
                      style: TextStyle(
                        // color: Colors.black,
                        color: MaterialColr.secondaryColor,
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeExtremeLarge,
                    ),
                    OtpTextField(
                      fieldWidth: 30,
                      numberOfFields: 6,
                      cursorColor: MaterialColr.primaryColor,
                      // disabledBorderColor: MaterialColr.primaryColor,
                      disabledBorderColor: MaterialColr.primaryColor,
                      enabledBorderColor: MaterialColr.primaryColor,
                      onSubmit: (value) {
                        otpController.text = value;
                      },
                      textStyle: const TextStyle(
                        color: MaterialColr.primaryColor,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      onpressed: () {
                        if (otpController.text.isEmpty ||
                            otpController.text.length < 6) {
                          vibrateDevice();
                          showSnackBar(
                              context: context,
                              message: "Please enter 6 digit code",
                              error: true);
                        } else {
                          showSnackBar(
                              context: context,
                              message: "Loading please wait",
                              time: 2);
                          AuthRepository.verifyOtp2(
                            context: context,
                            verificationId: widget.verificationId,
                            smsCode: otpController.text,
                          );
                        }
                      },
                      backgroundColor: MaterialColr.primaryColor,
                      title: "Verify",
                      titleColor: Colors.white,
                      titleSize: Dimensions.fontSizeLarge,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
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
