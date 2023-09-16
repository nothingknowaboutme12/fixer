import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fixer/Model/issue.dart';
import 'package:fixer/Services/firebase_data_set.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/Home/home.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:fixer/Widget/custom_textfield.dart';
import 'package:fixer/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../Model/user_model.dart';

class StillNotFixedIssueScreen extends StatefulWidget {
  static const String routName = "/StillNotFixedScreen";
  IssueModel issueModel;
  StillNotFixedIssueScreen({super.key, required this.issueModel});

  @override
  State<StillNotFixedIssueScreen> createState() =>
      _StillNotFixedIssueScreenState();
}

class _StillNotFixedIssueScreenState extends State<StillNotFixedIssueScreen> {
  late TextEditingController detailController;

  @override
  void initState() {
    detailController = TextEditingController();
    super.initState();
  }

  bool loading = false;
  String newImage = '';
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
              SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              Container(
                height: size.height * 0.6,
                width: size.width,
                padding: EdgeInsets.all(10),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: Dimensions.paddingSizeExtraSmall,
                      ),
                      Text(
                        "My issue was not fixed. Here are the details:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.paddingSizeExtraSmall,
                      ),
                      CustomTextField(
                        maxLines: 5,
                        borderColor: MaterialColr.primaryColor,
                        controller: detailController,
                        hintText: "Write something here",
                        hintColor: MaterialColr.primaryColor,
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeSmall,
                      ),
                      Center(
                        child: SizedBox(
                          width: size.width * 0.5,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              String url = await uploadImage(context) ?? '';
                              print(url);
                              if (url.isNotEmpty) {
                                newImage = url.toString();
                              }

                              setState(() {
                                loading = false;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                loading
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                Text("Upload Image"),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MaterialColr.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeSmall,
                      ),
                      Container(
                        height: size.height * 0.6,
                        width: size.width,
                        padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10)
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
                                  color: Colors.red,
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                ),
                                              ),
                                              TextSpan(
                                                text: widget
                                                    .issueModel.dateReported,
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
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                ),
                                              ),
                                              TextSpan(
                                                text: widget
                                                    .issueModel.assignedTo,
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
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                ),
                                              ),
                                              TextSpan(
                                                text: widget.issueModel.project,
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
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                ),
                                              ),
                                              TextSpan(
                                                text: widget
                                                    .issueModel.apartmentName,
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
                                          children: widget.issueModel.issuesList
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
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                ),
                                              ),
                                              TextSpan(
                                                text: widget
                                                    .issueModel.discriptions,
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
                    onpressed: () async {
                      if (detailController.text.isEmpty) {
                        vibrateDevice();
                        showSnackBar(
                            context: context,
                            message: "Please write the descriptions",
                            error: true);
                      } else if (newImage.isEmpty) {
                        vibrateDevice();
                        showSnackBar(
                            context: context,
                            message: "Please upload an image",
                            error: true);
                      } else {
                        showSnackBar(
                            context: context,
                            message: "Loading please wait...");
                        FirebaseDataSet.issueSubmitAgain(detailController.text,
                            widget.issueModel.issueNumber, newImage, context);
                        await sendEmailToMaintainer();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreeen(),
                            ),
                            (route) => false);
                      }
                    },
                    title: "Send/Dashboard",
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

  Future<String?> uploadImage(BuildContext context) async {
    try {
      int counter = 0;
      final source = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Image Source'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () {
                      Navigator.of(context).pop(ImageSource.gallery);
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop(ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );

      if (source == null) {
        return null;
      }

      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        // Crop the selected image
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1), // You can customize the aspect ratio
        );

        if (croppedFile != null) {
          final imageFile = croppedFile.path;
          final storage = FirebaseStorage.instance;

          final Reference storageRef =
              storage.ref().child('Images').child(userModel!.id).child(
                    widget.issueModel.issueNumber,
                  );
          final UploadTask uploadTask = storageRef.putFile(File(imageFile));

          final TaskSnapshot snapshot = await uploadTask;
          final downloadUrl = await snapshot.ref.getDownloadURL();
          showSnackBar(context: context, message: "Image uploaded");

          return downloadUrl;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), error: true);
    }
  }

  Future<void> sendEmailToMaintainer({required}) async {
    try {
      final smtpServer = gmail(
        "atik.firebase@gmail.com",
        "vuaz gaoz eisk rqbf",
      );

      final message = Message()
        ..from = Address(userModel!.email, userModel!.name)
        ..recipients.add(userModel!.maintainerEmail)
        ..subject =
            " Still not fixed issue reported ${widget.issueModel.issuesList} ${widget.issueModel.project} ${widget.issueModel.apartmentName}  ${widget.issueModel.priority} ${widget.issueModel.dateReported} "
        ..html = '''
<b>APARTMENT Issue Identification Number:</b> ${widget.issueModel.issueNumber}<br>
<b>Priority:</b> ${widget.issueModel.priority}<br>
<b>Status:</b> ${widget.issueModel.fixed}<br>
<b>Date reported:</b> ${widget.issueModel.dateReported}<br>

<b>Reported By:</b> ${widget.issueModel.userName}<br>
<b>Mobile Number:</b> ${widget.issueModel.userPhone}<br>
<b>Email:</b> ${widget.issueModel.userEmail}<br>
<b>Project:</b> ${widget.issueModel.project}<br>
<b>Apartment:</b> ${widget.issueModel.apartmentName}<br>

<br>
<b>Issue(s):</b> ${widget.issueModel.issuesList}<br>
<br>
<b>Details:</b><br>
${widget.issueModel.discriptions}<br>
<br>
<b>PHOTOS:</b>
<br>
<img src="${widget.issueModel.imageUrl}" alt="Image" /></br><br>
''';

      await send(message, smtpServer);
    } catch (e) {}
  }
}
