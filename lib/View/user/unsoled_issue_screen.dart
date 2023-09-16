import 'package:fixer/Controller/fixed_list_controller.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/user/issue_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnFixedIssueTableScreen extends StatelessWidget {
  static const String routName = '/unfixedIssue';
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
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            Container(
              height: size.height * 0.65,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
                  .copyWith(
                bottom: 8,
              ),
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
                  Text(
                    "UNFIXED ISSUES",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeExtraSmall,
                  ),
                  Expanded(
                    child: FutureBuilder<void>(
                        future: controller.fetchUnFixedIssues(),
                        builder: (context, snapshot) {
                          print("Here is data${controller.unfixedIssue}");
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
                          } else if (controller.unfixedIssue.isEmpty) {
                            return const Text("You have no fixed issue yet");
                          } else {
                            return Center(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  final issue = controller.unfixedIssue[index];
                                  print(issue.apartmentName);
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: index == 0
                                            ? const BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                topLeft: Radius.circular(10))
                                            : controller.unfixedIssue.length -
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
                                                      IssueDetailScreen(
                                                    issueModel: issue,
                                                    color: Colors.red,
                                                  ),
                                                ));
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(issue.dateReported
                                                  .split(' ')[0]),
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
                                              const Divider(
                                                thickness: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: controller.unfixedIssue.length,
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
