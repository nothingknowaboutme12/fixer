import 'package:fixer/Services/Auth/auth_repository.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/user/building_name_screen.dart';
import 'package:fixer/View/user/categorey_screen.dart';
import 'package:fixer/View/user/fixed_issue.dart';
import 'package:fixer/View/user/unsoled_issue_screen.dart';
import 'package:flutter/material.dart';

import 'Progress/unsolved_issue_progress_screen.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Spacer(),
          SizedBox(
            height: Dimensions.paddingSizeExtremeLarge,
          ),
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
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, BuildingNameScreen.routName);
                      },
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: MaterialColr.secondaryColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusLarge),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/call_help.png",
                                height: 30,
                                width: 30,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: Dimensions.paddingSizeExtraSmall,
                              ),
                              const Text(
                                'Ring Building Manger',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
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
                        Navigator.pushNamed(context, CategoryScreen.routName);
                      },
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusLarge),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/report_logo.png",
                                height: 30,
                                width: 30,
                                color: MaterialColr.secondaryColor,
                              ),
                              const SizedBox(
                                height: Dimensions.paddingSizeExtraSmall,
                              ),
                              const Text(
                                'Report Issue',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: MaterialColr.secondaryColor,
                                  fontSize: 11,
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
                        Navigator.pushNamed(
                            context, UnFixedIssueProgressScreen.routName);
                      },
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: MaterialColr.secondaryColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusLarge),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/work_progress.png",
                                height: 30,
                                width: 30,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: Dimensions.paddingSizeExtraSmall,
                              ),
                              const Text(
                                'Progress',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.paddingSizeSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, FixedIssueTableScreen.routName);
                    },
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusLarge),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/solved_issue.png",
                              height: 30,
                              width: 30,
                              color: MaterialColr.secondaryColor,
                            ),
                            const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall,
                            ),
                            const Text(
                              'Fixed issue',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MaterialColr.secondaryColor,
                                fontSize: 11,
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
                      Navigator.pushNamed(
                          context, UnFixedIssueTableScreen.routName);
                    },
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: MaterialColr.secondaryColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusLarge),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/unsolved.png",
                              height: 30,
                              width: 30,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: Dimensions.paddingSizeExtraSmall,
                            ),
                            const Text(
                              'Unsolved Issue',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
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
                    onTap: () async {
                      await AuthRepository.signOut(context);
                    },
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusLarge),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/logout.png",
                              height: 30,
                              width: 30,
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
                                fontSize: 11,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
