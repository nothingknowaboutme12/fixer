import 'package:fixer/Controller/users_controller.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/admin/fixed_user_issue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllUserScreen extends StatelessWidget {
  static const String routName = '/allUserScreen';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = context.read<UserController>();
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
              SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              Container(
                height: size.height * 0.65,
                width: size.width,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2),
                      child: Text(
                        "All Users",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                    Expanded(
                      child: FutureBuilder<void>(
                          future: controller.fetchAllUserFromFirebase(context),
                          builder: (context, snapshot) {
                            print("Here is data${controller.allUser}");
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: MaterialColr.primaryColor,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(snapshot.error.toString()));
                            } else if (controller.allUser.isEmpty) {
                              return Center(
                                  child: const Text(
                                      "You have no user register yet"));
                            } else {
                              return ListView.builder(
                                primary: false,
                                itemBuilder: (context, index) {
                                  final user = controller.allUser[index];

                                  return Container(
                                    decoration: BoxDecoration(
                                        // color: Colors.green,
                                        border: Border.all(
                                          color: Colors.green,
                                        ),
                                        borderRadius: index == 0
                                            ? const BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                topLeft: Radius.circular(10))
                                            : controller.allUser.length - 1 ==
                                                    index
                                                ? const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10))
                                                : null),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            FixedUserScreen.routName,
                                            arguments: user.id,
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
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
                                                        text: "Name: ",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: Dimensions
                                                              .fontSizeLarge,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: user.name,
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
                                                        text: "Phone: ",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: Dimensions
                                                              .fontSizeLarge,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: user.phoneNumber,
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
                                                        text: "Email: ",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: Dimensions
                                                              .fontSizeLarge,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: user.email,
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
                                  );
                                },
                                itemCount: controller.allUser.length,
                              );
                            }
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
