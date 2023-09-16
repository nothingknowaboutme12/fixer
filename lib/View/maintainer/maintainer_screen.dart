import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/maintainer/Add%20progress/unsolved_issue_progress_screen.dart';
import 'package:fixer/View/maintainer/Mark%20Done/unsolved_issue_mark_done.dart';
import 'package:fixer/View/maintainer/maintainer_fixed_issue.dart';
import 'package:fixer/View/maintainer/maintainer_unsoled_issue_screen.dart';
import 'package:flutter/material.dart';

import '../../Services/Auth/auth_repository.dart';

class MaintainerWidget extends StatelessWidget {
  const MaintainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(),
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, FixedMaintainerScreen.routName);
              },
              child: Container(
                height: 90,
                width: 90,
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
                    context, UnFixedIssueMaintainerScreen.routName);
              },
              child: Container(
                height: 90,
                width: 90,
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
                Navigator.pushNamed(context, UnfixedIssueDoneScreen.routName);
              },
              child: Container(
                height: 90,
                width: 90,
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
                        "assets/done_setting.png",
                        height: 30,
                        width: 30,
                        color: MaterialColr.secondaryColor,
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeExtraSmall,
                      ),
                      const Text(
                        'Mark As Done',
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, UnfixedProgressScreen.routName);
              },
              child: Container(
                height: 90,
                width: 90,
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
                        "assets/add_progress.png",
                        height: 30,
                        width: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeExtraSmall,
                      ),
                      const Text(
                        'Add progress',
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
                  borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
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
                        height: Dimensions.paddingSizeExtraSmall,
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
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
