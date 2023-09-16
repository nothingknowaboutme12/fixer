import 'package:fixer/Services/firebase_data_set.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/Home/home.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:fixer/Widget/snackbar.dart';
import 'package:flutter/material.dart';

class AuthConfirmScreen extends StatelessWidget {
  static const String routName = "/authConfirmScreen";
  AuthConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MaterialColr.primaryColor,
      bottomSheet: Container(
        color: MaterialColr.primaryColor,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
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
              SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              Container(
                height: size.height * 0.6,
                width: size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Confirmation",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeExtraLarge,
                    ),
                    Center(
                      child: Text(
                        "Thank you".toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.fontSizeExtraLarge,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    const Text(
                      'we value your confidentiality. our TEAM will verify your details. PLEASE ALLOW US UP TO 03 working dayS. We will SEND YOU A CONFIRMATION TEXT after we have done this.',
                      style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: Dimensions.paddingSizeDefault,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    CustomButton(
                      backgroundColor: MaterialColr.secondaryColor,
                      onpressed: () async {
                        showSnackBar(
                            context: context, message: "Loading please...");
                        await FirebaseDataSet.userDetailApproved();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreeen(),
                            ),
                            (route) => false);
                        showSnackBar(context: context, message: "Approved");
                      },
                      title: "Confirm/Dashboard",
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
