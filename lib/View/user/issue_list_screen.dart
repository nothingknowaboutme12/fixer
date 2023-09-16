import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fixer/Services/firebase_data_set.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/user/categorey_screen.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:fixer/Widget/custom_textfield.dart';
import 'package:fixer/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/user_model.dart';

class IssueListScreen extends StatefulWidget {
  static const String routName = "/IssueList";

  @override
  _IssueListScreenState createState() => _IssueListScreenState();
}

class _IssueListScreenState extends State<IssueListScreen> {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  String imageUrl = '';
  bool loading = false;
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: issueList.length,
                        primary: false,
                        itemBuilder: (context, index) {
                          final issue = issueList[index];
                          return Row(
                            // mainAxisAlignment: MainAxisAl.ignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  issue,
                                  style: TextStyle(
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                  // overflow: TextOverflow.clip,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: () {
                                  // Remove the issue when the minus button is clicked
                                  setState(() {
                                    issueList.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: Dimensions.paddingSizeDefault,
                      ),
                      CustomTextField(
                        controller: _descriptionController,
                        borderColor: MaterialColr.primaryColor,
                        showBorder: true,
                        hintText: "Enter description here...",
                        // hintFontSize: 18,
                        hintColor: MaterialColr.secondaryColor,
                        maxLines: 6,
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeSmall,
                      ),
                      SizedBox(
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
                              imageUrl = url.toString();
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
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(5).copyWith(bottom: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    CustomButton(
                      onpressed: () async {
                        print(imageUrl);
                        if (_descriptionController.text.isEmpty) {
                          vibrateDevice();

                          showSnackBar(
                              context: context,
                              message: "Write a discriptions",
                              error: true);
                        } else if (issueList.isEmpty) {
                          vibrateDevice();

                          showSnackBar(
                              context: context,
                              error: true,
                              message: "Define some issue to report");
                        } else {
                          showSnackBar(
                            context: context,
                            message: "Sending issue…please wait",
                          );
                          await FirebaseDataSet.publishIssue(
                            issueList,
                            imageUrl,
                            context,
                            _descriptionController.text,
                          );
                          issueList.clear();
                          _descriptionController.clear();
                          imageUrl = '';
                        }
                      },
                      title: "Send",
                      backgroundColor: MaterialColr.primaryColor,
                    ),
                  ],
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
          final issuesCollection =
              await FirebaseFirestore.instance.collection('issues').get();

          for (var doc in issuesCollection.docs) {
            final currentUserIssues = doc.data()['userId'] ?? '';
            if (currentUserIssues == userModel!.id) {
              counter++;
            }
          }

          final imageFile = croppedFile.path;
          final storage = FirebaseStorage.instance;

          final Reference storageRef = storage
              .ref()
              .child('Images')
              .child(userModel!.id)
              .child('${counter}');
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
      vibrateDevice();
      showSnackBar(context: context, message: e.toString(), error: true);
    }
  }
}
