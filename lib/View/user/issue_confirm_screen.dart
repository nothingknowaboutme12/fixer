import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/Home/home.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:flutter/material.dart';

class IssueConfirmScreen extends StatelessWidget {
  String identicationNumber;
  static const String routName = "/issueConfirm";
  IssueConfirmScreen({super.key, required this.identicationNumber});

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
              SizedBox(height: Dimensions.paddingSizeDefault),
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
                    Text(
                      'We have received your issue REPORT. Your APARTMENT Issue Identification Number is: $identicationNumber. Your issue is important to us. We will resolve as soon as possible.',
                      style: const TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: Dimensions.paddingSizeDefault,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    CustomButton(
                      backgroundColor: MaterialColr.primaryColor,
                      onpressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreeen(),
                            ),
                            (route) => false);
                      },
                      title: "Home/Dashboard",
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
