import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixer/Controller/firebase_datebase_get.dart';
import 'package:fixer/Model/issue.dart';
import 'package:fixer/Services/firebase_data_set.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/custom_dropdown.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/maintainer/add_issue_detail_screen1.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:fixer/main.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';

import '../../Model/user_model.dart';
import '../../Widget/snackbar.dart';

class AssignIssueScreen extends StatefulWidget {
  IssueModel issueModel;
  static const String routName = "/assignIssueScreen";
  AssignIssueScreen({super.key, required this.issueModel});

  @override
  State<AssignIssueScreen> createState() => _AssignIssueScreenState();
}

class _AssignIssueScreenState extends State<AssignIssueScreen> {
  String? techniationName;
  @override
  Widget build(BuildContext context) {
    print("Here is issue numerb${widget.issueModel.issueNumber}");

    final controller = context.read<RegistrationDetailC>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MaterialColr.primaryColor,
      bottomSheet: Container(
        color: MaterialColr.primaryColor,
        padding: EdgeInsets.zero,
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
              width: size.width,
              padding: const EdgeInsets.all(10).copyWith(bottom: 5),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                    FutureBuilder<void>(
                      future: controller.fetchTechniationNames(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Assign issue to:',
                                style: TextStyle(color: Colors.black),
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
                                              controller.techniationList),
                                          value: techniationName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MaterialColr.primaryColor,
                                          ),
                                          onChanged: (value) {},
                                          hint: Text("Select Technician"),
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
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        } else {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Assign issue to:',
                                  style: TextStyle(color: Colors.black),
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
                                          controller.techniationList),
                                      value: techniationName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MaterialColr.primaryColor,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          techniationName = value.toString();

                                          controller.fetchTechnicianDetails(
                                              value.toString());
                                        });
                                      },
                                      hint: Text("Select Technician"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Issue Detail",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: Dimensions.fontSizeExtraLarge,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.paddingSizeDefault,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                            ),
                                          ),
                                          TextSpan(
                                            text: widget.issueModel.issueNumber,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Wrap(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        // style: DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                            text: "Priority: ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                            ),
                                          ),
                                          TextSpan(
                                            text: widget.issueModel.priority,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
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
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                widget.issueModel.dateReported,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Wrap(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        // style: DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                            text: "Status: ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                widget.issueModel.fixed == false
                                                    ? "Unresolved"
                                                    : "Solved",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
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
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                            ),
                                          ),
                                          TextSpan(
                                            text: widget.issueModel.userName,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Wrap(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        // style: DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                            text: "Mobile Number: ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                            ),
                                          ),
                                          TextSpan(
                                            text: widget.issueModel.userPhone,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Wrap(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        // style: DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                            text: "Email: ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                            ),
                                          ),
                                          TextSpan(
                                            text: widget.issueModel.userEmail,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
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
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                            ),
                                          ),
                                          TextSpan(
                                            text: widget.issueModel.project,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
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
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                widget.issueModel.apartmentName,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
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
                                      children: widget.issueModel.issuesList
                                          .map(
                                            (issue) => Text(
                                              issue,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),
                                SizedBox(
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
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                widget.issueModel.discriptions,
                                            style: TextStyle(
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
                          SizedBox(
                            height: Dimensions.paddingSizeDefault,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: widget.issueModel.imageUrl,
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
                                  child: Center(
                                      child: Text(
                                          "An error occured to display image")),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10).copyWith(
                top: 1,
              ),
              child: CustomButton(
                title: "Assign/Next",
                backgroundColor: MaterialColr.primaryColor,
                onpressed: () async {
                  if (techniation == null) {
                    vibrateDevice();
                    showSnackBar(
                      context: context,
                      message: "Please select a valid techniation",
                      error: true,
                    );
                  } else {
                    showSnackBar(
                        context: context, message: "Assigning please wait...");

                    await FirebaseDataSet.updateTechniationsData(
                      widget.issueModel.issueNumber,
                      techniationName.toString(),
                      techniation?.techniationEmail ?? '',
                      techniation?.techniationPhone ?? '',
                      context,
                    ).then((_) async {
                      await sendEmailToTechniation();
                      showSnackBar(
                          context: context, message: "Assign to Technician");
                      Navigator.pushNamed(
                          context, AddIssueDetailScreen1.routName,
                          arguments: widget.issueModel);
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> sendEmailToTechniation() async {
    try {
      final smtpServer = gmail(
        "atik.firebase@gmail.com",
        "vuaz gaoz eisk rqbf",
      );

      final message = Message()
        ..from = Address(userModel!.email, userModel!.name)
        ..recipients.add(techniation!.techniationEmail)
        ..subject =
            "New issue reported ${widget.issueModel.issuesList} ${widget.issueModel.project} ${widget.issueModel.apartmentName} ${widget.issueModel.apartment} ${widget.issueModel.priority} ${widget.issueModel.dateReported} "
        ..html = '''
<b>APARTMENT Issue Identification Number:</b> ${widget.issueModel.issueNumber}<br>
<b>Priority:</b> ${widget.issueModel.priority}<br>
<b>Status:</b> ${widget.issueModel.fixed}<br>
<b>Date reported:</b> ${widget.issueModel.dateReported}<br>

<b>Reported By:</b> ${widget.issueModel.userName}<br>
<b>Mobile Number:</b> ${widget.issueModel.userPhone}<br>
<b>Email:</b> ${widget.issueModel.userEmail}<br>
<b>Project:</b> ${widget.issueModel.project}<br>

<br>
<b>Issue(s):</b> ${widget.issueModel.issuesList}<br>
<br>
<b>Details:</b><br>
${widget.issueModel.discriptions}<br>
<br>
<b>PHOTOS:</b>
<br>
<img src="${widget.issueModel.imageUrl}" alt="Image"  height="400"/></br><br>
''';

      await send(message, smtpServer);
    } catch (e) {}
  }
}
