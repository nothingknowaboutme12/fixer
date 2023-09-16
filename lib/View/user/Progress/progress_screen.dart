import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixer/Model/issue.dart';
import 'package:fixer/Services/firebase_data_set.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/Home/home.dart';
import 'package:flutter/material.dart';

import '../../../Widget/custom_button.dart';

class ViewProgressScreen extends StatelessWidget {
  IssueModel issueModel;
  static const String routName = '/ViewProgressScreen';
  ViewProgressScreen({super.key, required this.issueModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: Container(
        color: MaterialColr.primaryColor,
        width: size.width,
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
              height: size.height * 0.60,
              padding: EdgeInsets.all(12),
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.green,
                        ),
                      ),
                      child: FutureBuilder<DocumentSnapshot>(
                        future: FirebaseDataSet.fetchProgressData(
                            issueModel.issueNumber),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(
                                color: MaterialColr.primaryColor,
                              ),
                            ));
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('Error: ${snapshot.error}'),
                            ));
                          } else if (!snapshot.hasData ||
                              !snapshot.data!.exists) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('Progress document not found.'),
                            ));
                          } else {
                            // Access the 'updateProgress' field value
                            final progressData =
                                snapshot.data!.data() as Map<String, dynamic>;
                            final updateProgress =
                                progressData['updateProgress'] ?? '';

                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(updateProgress),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Text(
                      "Assigned To",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.green,
                        ),
                      ),
                      child: issueModel.assignedTo == "pending"
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text("Not assigned yet!"),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Wrap(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          // style: DefaultTextStyle.of(context).style,
                                          children: [
                                            TextSpan(
                                              text: "TechniationName:  ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    Dimensions.fontSizeLarge,
                                              ),
                                            ),
                                            TextSpan(
                                              text: issueModel.techniationName,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          // style: DefaultTextStyle.of(context).style,
                                          children: [
                                            TextSpan(
                                              text: "TechniationPhone:  ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    Dimensions.fontSizeLarge,
                                              ),
                                            ),
                                            TextSpan(
                                              text: issueModel.techniationPhone,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          // style: DefaultTextStyle.of(context).style,
                                          children: [
                                            TextSpan(
                                              text: "TechniationEmail:  ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    Dimensions.fontSizeLarge,
                                              ),
                                            ),
                                            TextSpan(
                                              text: issueModel.techniationEmail,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Text(
                      "Issue Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Wrap(
                            children: [
                              RichText(
                                text: TextSpan(
                                  // style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: "Identification Number: ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.fontSizeLarge,
                                      ),
                                    ),
                                    TextSpan(
                                      text: issueModel.issueNumber,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            children: [
                              RichText(
                                text: TextSpan(
                                  // style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: "Date Reported: ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.fontSizeLarge,
                                      ),
                                    ),
                                    TextSpan(
                                      text: issueModel.dateReported,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            children: [
                              RichText(
                                text: TextSpan(
                                  // style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: "Reported By: ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.fontSizeLarge,
                                      ),
                                    ),
                                    TextSpan(
                                      text: issueModel.userName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            children: [
                              RichText(
                                text: TextSpan(
                                  // style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: "Project: ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.fontSizeLarge,
                                      ),
                                    ),
                                    TextSpan(
                                      text: issueModel.project,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            children: [
                              RichText(
                                text: TextSpan(
                                  // style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: "Apartment No: ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.fontSizeLarge,
                                      ),
                                    ),
                                    TextSpan(
                                      text: issueModel.apartmentName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            // style: DefaultTextStyle.of(context).style,
                            children: [
                              Text(
                                "Issue(s): ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                              Wrap(
                                children: issueModel.issuesList
                                    .map(
                                      (issue) => Text(
                                        issue,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            children: [
                              RichText(
                                text: TextSpan(
                                  // style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: "Issue Detail: ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.fontSizeLarge,
                                      ),
                                    ),
                                    TextSpan(
                                      text: issueModel.discriptions,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: issueModel.imageUrl,
                        height: 150,
                        width: size.width,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) {
                          print(error);
                          return Container(
                            height: 150,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                            child: const Center(
                                child:
                                    Text("An error occured to display image")),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10)
                        .copyWith(top: 2),
                child: CustomButton(
                  onpressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreeen(),
                        ),
                        (route) => false);
                  },
                  title: "Home/Dashboard",
                  backgroundColor: MaterialColr.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
