import 'package:fixer/Controller/firebase_datebase_get.dart';
import 'package:fixer/Services/Auth/auth_repository.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:fixer/Widget/snackbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  static const String routName = "/OtpScreen";

  String name;
  String email;
  String verificationId;
  String phoneNumber;
  OtpScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.verificationId,
      required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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

  bool agree = false;
  // bool agree2 = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = context.read<RegistrationDetailC>();
    print(
        "Phone number is here:${widget.phoneNumber}===========================");
    return Scaffold(
      backgroundColor: MaterialColr.primaryColor,
      bottomSheet: Container(
        // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                height: size.height * 0.6,
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
                      "We have just sent a four digit verification code number to your mobile phone by SMS. To activate your app, please enter the 4 digit code below:",
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
                      enabledBorderColor: MaterialColr.primaryColor,
                      disabledBorderColor: MaterialColr.primaryColor,
                      onSubmit: (value) {
                        otpController.text = value;
                      },
                      textStyle: const TextStyle(
                        color: MaterialColr.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeExtremeLarge,
                    ),
                    const Spacer(),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Checkbox(
                        value: agree,
                        checkColor: MaterialColr.secondaryColor,
                        activeColor: MaterialColr.primaryColor,
                        onChanged: (value) {
                          setState(() {
                            agree = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        child: Text.rich(
                          textAlign: TextAlign.start,
                          TextSpan(
                            text:
                                'I agree to FIXER APARTMENT MAINTENANCE app’s ',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Terms & Conditions.',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => FutureBuilder(
                                          future:
                                              controller.fetchTermsCondition(),
                                          builder: (context, snapshot) {
                                            // final id=snapshot.data.i
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              // While data is being fetched, display a loading indicator
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (snapshot.hasError) {
                                              // If there's an error, display an error message
                                              return Center(
                                                  child: Text(
                                                      'Error: ${snapshot.error.toString()}'));
                                            } else if (controller
                                                .termsConditions.isEmpty) {
                                              // If the document does not exist, display a message
                                              return const Center(
                                                  child: Text(
                                                      'Terms and Conditions not available.'));
                                            } else {
                                              // If data is available, display the text

                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Center(
                                                  child: Text(controller
                                                      .termsConditions),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      );

                                      // code to open / launch terms of service link here
                                    }),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5.0).copyWith(
                    bottom: 10,
                  ),
                  child: CustomButton(
                    onpressed: () {
                      if (otpController.text.isEmpty) {
                        vibrateDevice();
                        showSnackBar(
                            context: context,
                            message: "Enter a otp",
                            error: true);
                      } else if (agree == false) {
                        vibrateDevice();
                        showSnackBar(
                            context: context,
                            error: true,
                            message: "Must be agree with terms and conditions");
                      } else {
                        showSnackBar(
                            context: context, message: "Loading please wait");
                        AuthRepository.verifyOtp(
                          context: context,
                          verificationId: widget.verificationId,
                          smsCode: otpController.text,
                          name: widget.name,
                          email: widget.email,
                          phoneNumber: widget.phoneNumber,
                        );
                      }
                    },
                    backgroundColor: MaterialColr.primaryColor,
                    title: "Verify",
                    titleColor: Colors.white,
                    titleSize: Dimensions.fontSizeLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
