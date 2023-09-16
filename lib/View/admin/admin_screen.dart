import 'package:fixer/Controller/fixed_list_controller.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/admin/all_user_screen.dart';
import 'package:fixer/View/admin/fixed_issue_time_take_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Services/Auth/auth_repository.dart';

class AdminWidget extends StatelessWidget {
  const AdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<FixedController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: MaterialColr.secondaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<void>(
                        future: controller.fetchTotalIssues(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return SizedBox(
                                height: 25,
                                width: 25,
                                child: Text(
                                  snapshot.error.toString(),
                                  style: TextStyle(color: Colors.white),
                                ));
                          } else {
                            return Text(
                              controller.totalIssueSolved.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        }),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    const Text(
                      'Total Issue Solved',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.paddingSizeSmall,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AllUserScreen.routName);
              },
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/users.png",
                        height: 40,
                        width: 40,
                        color: MaterialColr.secondaryColor,
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeSmall,
                      ),
                      const Text(
                        'All Users',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MaterialColr.secondaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Dimensions.paddingSizeSmall,
            ),
            GestureDetector(
              onTap: () async {
                await AuthRepository.signOut(context);
              },
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logout.png",
                        height: 40,
                        width: 40,
                        color: MaterialColr.secondaryColor,
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeDefault,
                      ),
                      const Text(
                        'Sign out',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MaterialColr.secondaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.paddingSizeSmall,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, IssueTimeDisplayScreen.routName);
              },
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: MaterialColr.secondaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/average.png",
                        height: 40,
                        width: 40,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeSmall,
                      ),
                      const Text(
                        'Average Time',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.paddingSizeExtremeLarge,
        ),
        Spacer(),
      ],
    );
  }
}
