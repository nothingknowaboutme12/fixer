import 'package:fixer/Controller/firebase_datebase_get.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/custom_dropdown.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/Home/mangerDetailScreen.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:fixer/Widget/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildingNameScreen extends StatefulWidget {
  static const String routName = "/buildingName";
  const BuildingNameScreen({super.key});

  @override
  State<BuildingNameScreen> createState() => _BuildingNameScreenState();
}

class _BuildingNameScreenState extends State<BuildingNameScreen> {
  String? buildingName;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = context.read<RegistrationDetailC>();
    return Scaffold(
      backgroundColor: MaterialColr.primaryColor,
      bottomSheet: Container(
        // margin: EdgeInsets.symmetric(horizontal: 10),
        color: MaterialColr.primaryColor,
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
                    topLeft: Radius.circular(15),
                  )),
              child: FutureBuilder<void>(
                future: controller.fetchBuildingNames(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select your building name:',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Dimensions.paddingSizeSmall,
                        ),
                        Container(
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: addDividersAfterItems(
                                        controller.buildingName),
                                    value: buildingName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MaterialColr.primaryColor,
                                    ),
                                    hint: Text("Select your Building"),
                                    onChanged: (String? value) {},
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
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please select your building name:',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Dimensions.paddingSizeSmall,
                        ),
                        Container(
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              items: addDividersAfterItems(
                                  controller.buildingName),
                              value: buildingName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MaterialColr.primaryColor,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  buildingName = value.toString();
                                });
                              },
                              hint: Text("Select your Building"),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            Container(
              width: size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4.0).copyWith(bottom: 10),
                child: CustomButton(
                  onpressed: () {
                    if (buildingName == null) {
                      showSnackBar(
                        context: context,
                        message: "Select your building",
                        error: true,
                      );
                    } else {
                      Navigator.pushNamed(
                        context,
                        MangerDetailScreen.routName,
                        arguments: buildingName,
                      );
                    }
                  },
                  titleColor: Colors.white,
                  backgroundColor: MaterialColr.primaryColor,
                  title: "Next",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
