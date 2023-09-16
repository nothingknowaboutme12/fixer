import 'package:fixer/Controller/firebase_datebase_get.dart';
import 'package:fixer/Services/Auth/auth_repository.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/custom_dropdown.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Widget/snackbar.dart';

class RegisterDetailScreen extends StatefulWidget {
  static const String routName = '/RegisterDetailScreen';
  const RegisterDetailScreen({super.key});

  @override
  State<RegisterDetailScreen> createState() => _RegisterDetailScreenState();
}

class _RegisterDetailScreenState extends State<RegisterDetailScreen> {
  String year = '1 year';
  List<String> yearList = ['1 year', '2 year', '3 year'];
  // String projectName = 'Select Project Name';
  String? projectName;
  String? floorName;
  String? apartmentName;
  DateTime dateTime = DateTime.now();
  bool dateUpdate = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = context.read<RegistrationDetailC>();

    controller.fetchProductNames();
    return Scaffold(
      backgroundColor: MaterialColr.primaryColor,
      bottomSheet: Container(
        color: MaterialColr.primaryColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: Dimensions.paddingSizeDefault,
                      ),
                      FutureBuilder<void>(
                        future: controller.fetchProductNames(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Please select your project name:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
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
                                              controller.projectName),
                                          onChanged: (value) {},
                                          value: projectName,
                                          // iconStyleData: const IconStyleData(
                                          //   openMenuIcon:
                                          //       Icon(Icons.arrow_drop_up),
                                          //   iconEnabledColor:
                                          //       MaterialColr.primaryColor,
                                          // ),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MaterialColr.primaryColor,
                                          ),
                                        )),
                                        const SizedBox(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          } else if (controller.projectName.isEmpty) {
                            return Container(
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
                              child: Center(
                                child: const Text(
                                  'No project names found.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Please select your project name:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
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
                                          controller.projectName),
                                      value: projectName,
                                      // iconStyleData: const IconStyleData(
                                      //   openMenuIcon:
                                      //       Icon(Icons.arrow_drop_up),
                                      //   iconEnabledColor:
                                      //       MaterialColr.primaryColor,
                                      // ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MaterialColr.primaryColor,
                                      ),

                                      onChanged: (value) {
                                        setState(() {
                                          projectName = value.toString();
                                          controller
                                              .fetchfloorName(value.toString());
                                          controller.fetchApartmentName(
                                              value.toString());
                                        });
                                      },
                                      hint: Text("Select your project"),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      FutureBuilder<void>(
                        future:
                            controller.fetchfloorName(projectName.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Please select your floor:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
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
                                              controller.floorName),
                                          value: floorName,

                                          // iconStyleData: const IconStyleData(
                                          //   openMenuIcon:
                                          //       Icon(Icons.arrow_drop_up),
                                          //   iconEnabledColor:
                                          //       MaterialColr.primaryColor,
                                          // ),

                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MaterialColr.primaryColor,
                                          ),
                                          onChanged: (String? value) {},
                                        )),
                                        const SizedBox(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Please select your floor',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
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
                                        controller.floorName),
                                    value: floorName,
                                    // iconStyleData: const IconStyleData(
                                    //   openMenuIcon: Icon(Icons.arrow_drop_up),
                                    //   iconEnabledColor:
                                    //       MaterialColr.primaryColor,
                                    // ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MaterialColr.primaryColor,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        floorName = value.toString();
                                      });
                                    },
                                    hint: Text("Select your floor"),
                                  )),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeDefault,
                      ),
                      FutureBuilder<void>(
                        future: controller
                            .fetchApartmentName(projectName.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Please select your apartment:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
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
                                              controller.apartName),
                                          value: apartmentName,
                                          // iconStyleData: const IconStyleData(
                                          //   openMenuIcon:
                                          //       Icon(Icons.arrow_drop_up),
                                          //   iconEnabledColor:
                                          //       MaterialColr.primaryColor,
                                          // ),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MaterialColr.primaryColor,
                                          ),
                                          onChanged: (String? value) {},
                                        )),
                                        const SizedBox(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Please select your apartment',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
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
                                      controller.apartName,
                                    ),
                                    value: apartmentName,
                                    // iconStyleData: const IconStyleData(
                                    //   openMenuIcon: Icon(Icons.arrow_drop_up),
                                    //   iconEnabledColor:
                                    //       MaterialColr.primaryColor,
                                    // ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MaterialColr.primaryColor,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        apartmentName = value.toString();
                                      });
                                    },
                                    hint: Text("Select your apartment"),
                                  )),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeDefault,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Duration of Maintenance Contract:',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall,
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
                                    items: addDividersAfterItems(yearList),
                                    value: year,
                                    // iconStyleData: const IconStyleData(
                                    //   openMenuIcon: Icon(Icons.arrow_drop_up),
                                    //   iconEnabledColor:
                                    //       MaterialColr.primaryColor,
                                    // ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MaterialColr.primaryColor,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        year = value.toString();
                                      });
                                    })),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Date Maintenance Contract Started:',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null && picked != dateTime) {
                                setState(() {
                                  dateTime = picked;
                                  dateUpdate = true;
                                });
                              }
                            },
                            child: Text(
                              'Pick Date',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      dateUpdate
                          ? Text(dateTime.toString().substring(0, 10))
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              Container(
                width: size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5.0).copyWith(bottom: 10),
                  child: CustomButton(
                    onpressed: () async {
                      if (projectName == 'Select Value' ||
                          floorName == 'Select Value' ||
                          apartmentName == 'Select Value') {
                        vibrateDevice();
                        showSnackBar(
                          context: context,
                          message: "Please select all the data",
                          error: true,
                        );
                      } else {
                        showSnackBar(
                            context: context,
                            message: "Uploading please wait...");
                        await AuthRepository.saveRegistrationDataToFirestore(
                            projectName.toString(),
                            floorName.toString(),
                            apartmentName.toString(),
                            context,
                            dateTime,
                            year);
                      }
                    },
                    title: "Save",
                    backgroundColor: MaterialColr.primaryColor,
                    titleColor: Colors.white,
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
