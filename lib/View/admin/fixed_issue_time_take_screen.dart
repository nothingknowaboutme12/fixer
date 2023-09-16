import 'package:fixer/Controller/fixed_list_controller.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/user/fixed_issue_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IssueTimeDisplayScreen extends StatelessWidget {
  static const String routName = '/IssueTimeDisplay';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = context.read<FixedController>();
    return Scaffold(
      bottomSheet: Container(
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
                      "FIXED ISSUES",
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
                        future: controller.fetchFixedMaintainerIssues(),
                        builder: (context, snapshot) {
                          print(
                              "Here is data${controller.fixedMaintainerIssue}");
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
                          } else if (controller.fixedMaintainerIssue.isEmpty) {
                            return Center(
                                child: const Text(
                              "No fixed issue yet",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ));
                          } else {
                            return Center(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  final issue =
                                      controller.fixedMaintainerIssue[index];

                                  final startDate =
                                      DateTime.parse(issue.dateReported);
                                  print(
                                      "Here is start date++++++++++++++++++$startDate");
                                  final finalDate =
                                      DateTime.parse(issue.fixedDate);
                                  print(
                                      "Here is end date +++++++++++++++++++++++++++++++$finalDate");
                                  final Duration timeDifference =
                                      finalDate.difference(startDate);
                                  print(
                                      "Here is end date +++++++++++++++++++++++++++++++$finalDate");
                                  final int years =
                                      finalDate.year - startDate.year;
                                  final month =
                                      finalDate.month - startDate.month;

                                  final int days = timeDifference.inDays % 365;

                                  return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: index == 0
                                            ? const BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                topLeft: Radius.circular(10))
                                            : controller.fixedIssue.length -
                                                        1 ==
                                                    index
                                                ? const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10))
                                                : null),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FixedIssueDetailScreen(
                                                    issueModel: issue,
                                                  ),
                                                ));
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Averge Time: ",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "$years years, $month,  $days days",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Wrap(
                                                children: issue.issuesList
                                                    .map((i) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      8.0),
                                                          child: Text(
                                                            i,
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                              Divider(
                                                thickness: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount:
                                    controller.fixedMaintainerIssue.length,
                              ),
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
    );
  }
}
