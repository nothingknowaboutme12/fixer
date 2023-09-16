import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixer/Model/issue.dart';
import 'package:fixer/Services/firebase_data_set.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/Home/home.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:fixer/Widget/custom_textfield.dart';
import 'package:fixer/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../../Model/user_model.dart';

class AddProgressScreen extends StatefulWidget {
  IssueModel issueModel;
  static const String routName = "/addProgressScreen";
  AddProgressScreen({super.key, required this.issueModel});

  @override
  State<AddProgressScreen> createState() => _AddProgressScreenState();
}

class _AddProgressScreenState extends State<AddProgressScreen> {
  late TextEditingController updateProgress;
  late TextEditingController purposedC;
  late TextEditingController planOfAction;

  bool accountApproved = false;
  bool mangementApproved = false;

  @override
  void initState() {
    updateProgress = TextEditingController();
    purposedC = TextEditingController();
    planOfAction = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    updateProgress.dispose();
    purposedC.dispose();
    planOfAction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MaterialColr.primaryColor,
      bottomSheet: Container(
        color: MaterialColr.primaryColor,
        padding: EdgeInsets.zero,
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
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Update Progress:",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        CustomTextField(
                          controller: updateProgress,
                          hintText: "Write progress here",
                          hintColor: MaterialColr.primaryColor,
                          maxLines: 5,
                        ),

                        SizedBox(
                          height: Dimensions.paddingSizeDefault,
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
                                                text: widget
                                                    .issueModel.issueNumber,
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
                                                text:
                                                    widget.issueModel.priority,
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
                                                text: widget
                                                    .issueModel.dateReported,
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
                                                text: widget.issueModel.fixed ==
                                                        false
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
                                                text:
                                                    widget.issueModel.userName,
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
                                                text:
                                                    widget.issueModel.userPhone,
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
                                                text:
                                                    widget.issueModel.userEmail,
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
                                                text: widget
                                                    .issueModel.apartmentName,
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
                                                text: widget
                                                    .issueModel.discriptions,
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
                        SizedBox(
                          height: Dimensions.paddingSizeDefault,
                        ),

                        Text(
                          "Proposed Explanations:",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        CustomTextField(
                          controller: purposedC,
                          hintText: "Write proposed here",
                          hintColor: MaterialColr.primaryColor,
                          maxLines: 5,
                        ),
                        SizedBox(height: Dimensions.paddingSizeDefault),
                        Text(
                          "Plan Of Action:",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        CustomTextField(
                          controller: planOfAction,
                          hintText: "Write some plan here",
                          hintColor: MaterialColr.primaryColor,
                          maxLines: 5,
                        ),
                        SizedBox(height: Dimensions.paddingSizeDefault),

                        Text(
                          "Plan of action approved by accounts:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.paddingSizeDefault,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: true,
                                groupValue: accountApproved,
                                onChanged: (value) {
                                  setState(() {
                                    accountApproved = true;
                                  });
                                },
                              ),
                              Text("Yes"),
                              Radio(
                                value: false,
                                groupValue: accountApproved,
                                onChanged: (value) {
                                  setState(() {
                                    accountApproved = false;
                                  });
                                },
                              ),
                              Text("No"),
                            ],
                          ),
                        ),

                        SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        // Proposed

                        Text(
                          "Plan of action approved by mangements:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.paddingSizeDefault,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: true,
                              groupValue: mangementApproved,
                              onChanged: (value) {
                                setState(() {
                                  mangementApproved = true;
                                });
                              },
                            ),
                            Text("Yes"),
                            Radio(
                              value: false,
                              groupValue: mangementApproved,
                              onChanged: (value) {
                                setState(() {
                                  mangementApproved = false;
                                });
                              },
                            ),
                            Text("No"),
                          ],
                        ),

                        SizedBox(
                          height: Dimensions.paddingSizeDefault,
                        ),
                      ],
                    ),
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
                    onpressed: () async {
                      if (updateProgress.text.isEmpty ||
                          purposedC.text.isEmpty ||
                          planOfAction.text.isEmpty) {
                        vibrateDevice();
                        showSnackBar(
                            context: context,
                            message: "Please complete all the fields",
                            error: true);
                      } else {
                        showSnackBar(
                            context: context,
                            message: "Loading please wait...");

                        await FirebaseDataSet.updateIssue(
                            planOfAction: planOfAction.text,
                            accoutApproved: accountApproved,
                            mangementApproved: mangementApproved,
                            proposed: purposedC.text,
                            issueID: widget.issueModel.issueNumber,
                            updateProgress: updateProgress.text);

                        await sendEmailToUserToIssueUpdate();

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreeen(),
                            ),
                            (route) => false);
                      }
                    },

                    //
                    title: "Save/Dashboard",
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

  Future<void> sendEmailToUserToIssueUpdate() async {
    try {
      final smtpServer = gmail(
        "atik.firebase@gmail.com",
        "vuaz gaoz eisk rqbf",
      );

      final message = Message()
        ..from = Address(userModel!.email, userModel!.name)
        ..recipients.add(widget.issueModel.userEmail)
        ..subject =
            "Issue Update ${widget.issueModel.issuesList} ${widget.issueModel.project} ${widget.issueModel.apartmentName} ${widget.issueModel.apartment} ${widget.issueModel.priority} ${widget.issueModel.dateReported} "
        ..text = "Update: ${updateProgress.text}";

      await send(message, smtpServer);
    } catch (e) {}
  }
}
