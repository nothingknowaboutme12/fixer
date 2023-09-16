import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixer/Controller/firebase_datebase_get.dart';
import 'package:fixer/Model/issue.dart';
import 'package:fixer/Services/firebase_data_set.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/maintainer/add_issue_detail_screen2.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:fixer/Widget/custom_textfield.dart';
import 'package:fixer/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddIssueDetailScreen1 extends StatefulWidget {
  IssueModel issueModel;
  static const String routName = "/addIssueDetailScreen1";
  AddIssueDetailScreen1({super.key, required this.issueModel});

  @override
  State<AddIssueDetailScreen1> createState() => _AddIssueDetailScreen1State();
}

class _AddIssueDetailScreen1State extends State<AddIssueDetailScreen1> {
  late TextEditingController supplierName;
  late TextEditingController purposedC;
  late TextEditingController productNameC;
  late TextEditingController productModelC;
  late TextEditingController priceC;
  String techniationName = "Select Value";
  bool lineOk = false;
  bool supplierCalled = false;
  bool underWarranty = false;

  @override
  void initState() {
    supplierName = TextEditingController();
    purposedC = TextEditingController();
    productNameC = TextEditingController();
    productModelC = TextEditingController();
    priceC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    supplierName.dispose();
    purposedC.dispose();
    productNameC.dispose();
    productModelC.dispose();
    priceC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<RegistrationDetailC>();
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
                        // SUPPLIER NAME
                        Row(
                          children: [
                            Text(
                              "Line Ok:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.paddingSizeDefault,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.paddingSizeDefault,
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: true,
                                  groupValue: lineOk,
                                  onChanged: (value) {
                                    setState(() {
                                      lineOk = true;
                                    });
                                  },
                                ),
                                Text("Yes"),
                                Radio(
                                  value: false,
                                  groupValue: lineOk,
                                  onChanged: (value) {
                                    setState(() {
                                      lineOk = false;
                                    });
                                  },
                                ),
                                Text("No"),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        Row(
                          children: [
                            Text(
                              "SUPPLIER NAME: ",
                              style: TextStyle(
                                color: Colors.black,
                                // fontSize: Dimensions.fontSizeLarge,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.55,
                              child: CustomTextField(
                                controller: supplierName,
                                titleText: "Supplier Name",
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Dimensions.paddingSizeExtraSmall),

                        // Supplier called?
                        Row(
                          children: [
                            Text(
                              "Supplier called?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.fontSizeLarge,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.paddingSizeDefault,
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: true,
                                  groupValue: supplierCalled,
                                  onChanged: (value) {
                                    setState(() {
                                      supplierCalled = true;
                                    });
                                  },
                                ),
                                Text("Yes"),
                                Radio(
                                  value: false,
                                  groupValue: supplierCalled,
                                  onChanged: (value) {
                                    setState(() {
                                      supplierCalled = false;
                                    });
                                  },
                                ),
                                Text("No"),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.paddingSizeDefault),
                        // Proposed
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

                        // Product Name
                        Text(
                          "Product Name:",
                          style: TextStyle(
                            color: Colors.black,
                            // fontSize: Dimensions.fontSizeLarge,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        CustomTextField(
                          controller: productNameC,
                          hintText: "Write product name here",
                          hintColor: MaterialColr.primaryColor,
                          maxLines: 5,
                        ),
                        SizedBox(height: Dimensions.paddingSizeDefault),

                        // Product model
                        Text(
                          "Product Model:",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimensions.paddingSizeExtraSmall),

                        CustomTextField(
                          controller: productModelC,
                          hintText: "Write product model here",
                          hintColor: MaterialColr.primaryColor,
                          maxLines: 5,
                        ),

                        SizedBox(height: Dimensions.paddingSizeSmall),

                        // warrenty
                        Row(
                          children: [
                            Text(
                              "Under Warranty?",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.paddingSizeSmall,
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: true,
                                  groupValue: underWarranty,
                                  onChanged: (value) {
                                    setState(() {
                                      underWarranty = true;
                                    });
                                  },
                                ),
                                Text("Yes"),
                                Radio(
                                  value: false,
                                  groupValue: underWarranty,
                                  onChanged: (value) {
                                    setState(() {
                                      underWarranty = false;
                                    });
                                  },
                                ),
                                Text("No"),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.paddingSizeExtraSmall,
                        ),
                        !underWarranty
                            ? Row(
                                children: [
                                  Text(
                                    "Price: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      // fontSize: Dimensions.fontSizeLarge,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingSizeDefault,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.55,
                                    child: CustomTextField(
                                      controller: priceC,
                                      titleText: "Price",
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(),
                        SizedBox(
                          height: Dimensions.paddingSizeExtraSmall,
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
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10)
                          .copyWith(top: 2),
                  child: CustomButton(
                    onpressed: () async {
                      if (supplierName.text.isEmpty ||
                          purposedC.text.isEmpty ||
                          productNameC.text.isEmpty ||
                          productModelC.text.isEmpty) {
                        vibrateDevice();
                        showSnackBar(
                            context: context,
                            message: "Please complete all the fields",
                            error: true);
                      } else {
                        showSnackBar(
                            context: context,
                            message: "Loading please wait...");
                        await FirebaseDataSet.addDetailofIssue(
                          issueID: widget.issueModel.issueNumber,
                          lineOk: lineOk,
                          supplierName: supplierName.text,
                          supplierCalled: supplierCalled,
                          proposed: purposedC.text,
                          productName: productNameC.text,
                          productModel: productModelC.text,
                          warrenty: underWarranty,
                          price: priceC.text.isEmpty ? '' : priceC.text,
                        );

                        Navigator.pushNamed(
                            context, AddIssueDetailScreen2.routName,
                            arguments: widget.issueModel);
                      }
                    },

                    //
                    title: "Next",
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
