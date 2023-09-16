import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixer/Model/issue.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/Home/home.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:flutter/material.dart';

class IssueDetailScreen extends StatelessWidget {
  IssueModel issueModel;
  Color color;
  static const String routName = "/issueDetail";
  IssueDetailScreen({super.key, required this.issueModel, required this.color});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MaterialColr.primaryColor,
      bottomSheet: Container(
        color: MaterialColr.primaryColor,
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
              SizedBox(height: Dimensions.paddingSizeDefault),
              Container(
                height: size.height * 0.6,
                width: size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                        .copyWith(
                  bottom: 1,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Issue Detail",
                        style: TextStyle(
                          color: color,
                          fontSize: Dimensions.fontSizeExtraLarge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeExtraSmall,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: color,
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
                                        text: "Assigned: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimensions.fontSizeLarge,
                                        ),
                                      ),
                                      TextSpan(
                                        text: issueModel.assignedTo,
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
                                  child: Text(
                                      "An error occured to display image")),
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
      ),
    );
  }
}
