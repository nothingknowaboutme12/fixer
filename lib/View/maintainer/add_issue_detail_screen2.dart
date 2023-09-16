import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

import '../../Model/user_model.dart';

class AddIssueDetailScreen2 extends StatefulWidget {
  IssueModel issueModel;
  static const String routName = "/addIssueDetailScreen2";
  AddIssueDetailScreen2({super.key, required this.issueModel});

  @override
  State<AddIssueDetailScreen2> createState() => _AddIssueDetailScreen2State();
}

class _AddIssueDetailScreen2State extends State<AddIssueDetailScreen2> {
  late TextEditingController planActionC;

  bool accountsApproved = false;
  bool mangementApproved = false;

  @override
  void initState() {
    planActionC = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    planActionC.dispose();

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: logoWithName),
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
                        // SUPPLIER NAME

                        Text(
                          "Plan of action:",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        CustomTextField(
                          controller: planActionC,
                          hintText: "Write plan of action here",
                          hintColor: MaterialColr.primaryColor,
                          maxLines: 5,
                        ),

                        SizedBox(
                          height: Dimensions.paddingSizeDefault,
                        ),

                        Row(
                          children: [
                            Text(
                              "Plan of action approved by accounts:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.paddingSizeDefault,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            TextButton(
                                onPressed: () {
                                  sendEmailToAccount();
                                },
                                child: Text("Notify"))
                          ],
                        ),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: true,
                                groupValue: accountsApproved,
                                onChanged: (value) {
                                  setState(() {
                                    accountsApproved = true;
                                  });
                                },
                              ),
                              Text("Yes"),
                              Radio(
                                value: false,
                                groupValue: accountsApproved,
                                onChanged: (value) {
                                  setState(() {
                                    accountsApproved = false;
                                  });
                                },
                              ),
                              Text("No"),
                            ],
                          ),
                        ),

                        SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        // Proposed

                        Row(
                          children: [
                            Text(
                              "Plan of action approved by mangements:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.paddingSizeDefault,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () async {
                                sendEmailToMangemet();
                              },
                              child: Text('Notify'),
                            )
                          ],
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
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5)
                          .copyWith(bottom: 10)
                          .copyWith(top: 2),
                  child: CustomButton(
                    onpressed: () async {
                      if (planActionC.text.isEmpty) {
                        vibrateDevice();
                        showSnackBar(
                            context: context,
                            message: "Enter some plan of action",
                            error: true);
                      } else {
                        showSnackBar(
                            context: context,
                            message: "Loading please wait...");
                        await FirebaseDataSet.addMoreDetailofIssue(
                            planOfAction: planActionC.text,
                            accoutApproved: accountsApproved,
                            mangementApproved: mangementApproved,
                            issueID: widget.issueModel.issueNumber);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreeen()),
                            (route) => false);
                      }
                    },
                    title: "Done/DashBoard",
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

  Future<void> sendEmailToAccount() async {
    try {
      final smtpServer = gmail(
        "atik.firebase@gmail.com",
        "vuaz gaoz eisk rqbf",
      );

      final document =
          await FirebaseFirestore.instance.collection("Accounts").get();
      final accoutEmail = await document.docs.first.id;

      final message = Message()
        ..from = Address(userModel!.email, userModel!.name)
        ..recipients.add(accoutEmail)
        ..subject =
            "New verfication ${widget.issueModel.userName} ${widget.issueModel.issuesList} ${widget.issueModel.project} ${widget.issueModel.apartmentName} ${widget.issueModel.apartment} ${widget.issueModel.priority} ${widget.issueModel.dateReported} "
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

<b>Plan Of Action:</b><br>
${planActionC.text}<br>


<br>
<b>PHOTOS:</b>
<br>
<img src="${widget.issueModel.imageUrl}" alt="Image"  height="400"/></br><br>
''';

      await send(message, smtpServer);
      showSnackBar(
        context: context,
        message: "Sent successfully",
      );
    } catch (e) {
      showSnackBar(context: context, message: "Failed", error: true);
    }
  }

  Future<void> sendEmailToMangemet() async {
    try {
      final smtpServer = gmail(
        "atik.firebase@gmail.com",
        "vuaz gaoz eisk rqbf",
      );

      final document =
          await FirebaseFirestore.instance.collection("Mangements").get();
      final accoutEmail = await document.docs.first.id;

      final message = Message()
        ..from = Address(userModel!.email, userModel!.name)
        ..recipients.add(accoutEmail)
        ..subject =
            "New verfication ${widget.issueModel.userName} ${widget.issueModel.issuesList} ${widget.issueModel.project} ${widget.issueModel.apartmentName} ${widget.issueModel.apartment} ${widget.issueModel.priority} ${widget.issueModel.dateReported} "
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
<b>Plan Of Action:</b><br>
${planActionC.text}<br>

<b>PHOTOS:</b>
<br>
<img src="${widget.issueModel.imageUrl}" alt="Image"  height="400"/></br><br>
''';

      await send(message, smtpServer);
      showSnackBar(
        context: context,
        message: "Sent successfully",
      );
    } catch (e) {
      showSnackBar(context: context, message: "Failed", error: true);
    }
  }
}
