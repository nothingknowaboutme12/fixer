import 'package:fixer/Controller/firebase_datebase_get.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/custom_dropdown.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/Home/home.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:fixer/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MangerDetailScreen extends StatefulWidget {
  String buildinName;
  static const String routName = "/mangerDetailScreen";
  MangerDetailScreen({super.key, required this.buildinName});

  @override
  State<MangerDetailScreen> createState() => _MangerDetailScreenState();
}

class _MangerDetailScreenState extends State<MangerDetailScreen> {
  String? mangerName;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = context.read<RegistrationDetailC>();
    return Scaffold(
      backgroundColor: MaterialColr.primaryColor,
      bottomSheet: Container(
        color: MaterialColr.primaryColor,
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
              SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              Container(
                height: size.height * 0.6,
                padding: EdgeInsets.all(10).copyWith(
                  top: 15,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(
                          15,
                        ))),
                child: Column(
                  children: [
                    FutureBuilder<void>(
                      future: controller.fetchMangerNames(widget.buildinName),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Please select your manger name:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: Dimensions.paddingSizeExtraSmall,
                              ),
                              Container(
                                height: 55,
                                width: size.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: MaterialColr.primaryColor,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          items: addDividersAfterItems(
                                              controller.mangerName),
                                          value: mangerName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MaterialColr.primaryColor,
                                          ),
                                          onChanged: (value) {},
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          color: MaterialColr.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Container(
                            height: 55,
                            width: size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: MaterialColr.primaryColor,
                              ),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Please select your manger name:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: Dimensions.paddingSizeExtraSmall,
                              ),
                              Container(
                                height: 55,
                                width: size.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: MaterialColr.primaryColor,
                                  ),
                                  color: Colors.white,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: addDividersAfterItems(
                                        controller.mangerName),
                                    value: mangerName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MaterialColr.primaryColor,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        mangerName = value.toString();
                                        controller.fetchMangerDetail(
                                            widget.buildinName,
                                            value.toString());
                                      });
                                    },
                                    hint: Text('Select manger name'),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: MaterialColr.primaryColor,
                          )),
                      child: Consumer<RegistrationDetailC>(
                          builder: (context, c, _) {
                        return Column(
                          children: c.mangerlist
                              .map(
                                (manger) => Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSmall,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              // style: DefaultTextStyle.of(context).style,
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "Your building manager’s first name: ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: manger.firstName
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Dimensions.paddingSizeExtraSmall,
                                      ),
                                      Wrap(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              // style: DefaultTextStyle.of(context).style,
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "Your building manager’s last name: ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: manger.lastName
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Dimensions.paddingSizeExtraSmall,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  "Your building Manager’s Number is: ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    Dimensions.fontSizeDefault,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  manger.phoneNumber.toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: Dimensions.paddingSizeDefault,
                                      ),
                                      Center(
                                        child: CustomButton(
                                          onpressed: () async {
                                            final Uri phoneUri = Uri(
                                                scheme: "tel",
                                                path: manger.phoneNumber
                                                    .toString());
                                            try {
                                              await launchUrl(phoneUri);
                                            } catch (error) {
                                              showSnackBar(
                                                  context: context,
                                                  message:
                                                      "Something went wrong",
                                                  error: true);
                                            }
                                          },
                                          height: 40,
                                          title: "Call",
                                          width: size.width * 0.6,
                                        ),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeSmall,
                                    vertical: Dimensions.paddingSizeSmall,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.paddingSizeExtraSmall,
                                    vertical: Dimensions.paddingSizeExtraSmall,
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(4.0).copyWith(
                    bottom: 10,
                  ),
                  child: CustomButton(
                    onpressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreeen(),
                          ),
                          (route) => false);
                    },
                    titleColor: Colors.white,
                    backgroundColor: MaterialColr.primaryColor,
                    title: "Home/Dashboard",
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
