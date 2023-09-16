import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixer/Services/player.dart';
import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:fixer/View/user/issue_list_screen.dart';
import 'package:fixer/Widget/custom_button.dart';
import 'package:fixer/Widget/snackbar.dart';
import 'package:flutter/material.dart';

List<String> issueList = [];

class CategoryScreen extends StatelessWidget {
  static const String routName = "/catergoryScreen";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MaterialColr.primaryColor,
      bottomSheet: Container(
        color: MaterialColr.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
            Container(
                height: size.height * 0.65,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: CategoryList()),
                    CustomButton(
                      onpressed: () {
                        if (issueList.isEmpty) {
                          vibrateDevice();
                          showSnackBar(
                            context: context,
                            message: "Please select atleast one issue",
                            error: true,
                          );
                        } else {
                          Navigator.pushNamed(
                              context, IssueListScreen.routName);
                        }
                      },
                      title: "Next",
                      backgroundColor: MaterialColr.primaryColor,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection(' IssueCategories').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("You have no data!"),
            ),
          );
        } else {
          final categories = snapshot.data!.docs;
          print(categories);
          return ListView.builder(
            itemCount: categories.length,
            primary: true,
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryTile(category: category);
            },
          );
        }
      },
    );
  }
}

class CategoryTile extends StatelessWidget {
  final QueryDocumentSnapshot category;

  CategoryTile({required this.category});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: Icon(Icons.add),
      iconColor: MaterialColr.secondaryColor,
      onExpansionChanged: (value) {
        playDripSound();
      },

      title: Text(category.id), // Category name

      children: [
        SubCategoryList(categoryRef: category.id),
      ],
    );
  }
}

class SubCategoryList extends StatelessWidget {
  final String categoryRef;

  SubCategoryList({required this.categoryRef});

  @override
  Widget build(BuildContext context) {
    print(categoryRef);
    return Column(
      // Wrap ExpansionTile widgets in a Column
      children: [
        FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection(' IssueCategories')
              .doc(categoryRef)
              .collection('sub')
              .get(),
          // stream: categoryRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final subcategories = snapshot.data!.docs;
              return Column(
                children: subcategories.map((subcategory) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: SubCategoryTile(
                      subcategory: subcategory,
                      catergoryRef: categoryRef,
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ],
    );
  }
}

class SubCategoryTile extends StatefulWidget {
  final QueryDocumentSnapshot subcategory;
  final String catergoryRef;

  SubCategoryTile({
    required this.subcategory,
    required this.catergoryRef,
  });

  @override
  State<SubCategoryTile> createState() => _SubCategoryTileState();
}

class _SubCategoryTileState extends State<SubCategoryTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (value) {
        playCrackSound();
      },
      trailing: widget.subcategory.id.contains("*")
          ? Checkbox(
              value: issueList.contains(widget.subcategory.id),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    if (issueList.contains(widget.subcategory.id)) {
                      showSnackBar(
                          context: context, message: "Removed", error: true);
                      issueList.remove(widget.subcategory.id);
                    } else {
                      showSnackBar(context: context, message: "Added");
                      issueList.add(widget.subcategory.id);
                    }
                  });
                }
              },
            )
          : null,
      title: Text(
        widget.subcategory.id,
      ), // Subcategory name
      children: [
        SubCategoryList2(
            categoryRef: widget.catergoryRef,
            subcategoryRef: widget.subcategory.id)
      ],
    );
  }
}

class SubCategoryList2 extends StatelessWidget {
  final String categoryRef;
  final String subcategoryRef;

  SubCategoryList2({required this.categoryRef, required this.subcategoryRef});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection(' IssueCategories')
              .doc(categoryRef)
              .collection('sub')
              .doc(subcategoryRef)
              .collection('sub')
              .get(),
          // stream: categoryRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final subcategories = snapshot.data!.docs;

              return Column(
                children: subcategories.map((subcategory) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: SubCategoryTile2(
                      subcategory: subcategory,
                      categoryRef: categoryRef,
                      subcategoryRef: subcategoryRef,
                      // last: checklast,
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ],
    );
  }
}

class SubCategoryTile2 extends StatefulWidget {
  final QueryDocumentSnapshot subcategory;
  final String categoryRef;
  final String subcategoryRef;
  SubCategoryTile2({
    required this.subcategory,
    required this.categoryRef,
    required this.subcategoryRef,
  });

  @override
  State<SubCategoryTile2> createState() => _SubCategoryTile2State();
}

class _SubCategoryTile2State extends State<SubCategoryTile2> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (value) {
        playCrackSound();
      },
      trailing: widget.subcategory.id.contains("*")
          ? Checkbox(
              value: issueList.contains(widget.subcategory.id),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    print(issueList.contains(widget.subcategory.id));
                    if (issueList.contains(widget.subcategory.id)) {
                      showSnackBar(
                          context: context, message: "Removed", error: true);
                      issueList.remove(widget.subcategory.id);
                    } else {
                      showSnackBar(context: context, message: "Added");
                      issueList.add(widget.subcategory.id);
                    }
                  });
                }
              },
            )
          : null,

      title: Text(widget.subcategory.id), // Subcategory name
      children: [
        SubCategoryList3(
          categoryRef: widget.categoryRef,
          subcategoryRef: widget.subcategoryRef,
          subcategoryRef2: widget.subcategory.id,
        )
      ],
    );
  }
}

class SubCategoryList3 extends StatelessWidget {
  final String categoryRef;
  final String subcategoryRef;
  final String subcategoryRef2;

  SubCategoryList3(
      {required this.categoryRef,
      required this.subcategoryRef,
      required this.subcategoryRef2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection(' IssueCategories')
              .doc(categoryRef)
              .collection('sub')
              .doc(subcategoryRef)
              .collection('sub')
              .doc(subcategoryRef2)
              .collection('sub')
              .get(),
          // stream: categoryRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final subcategories = snapshot.data!.docs;
              return Column(
                children: subcategories.map((subcategory) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SubCategoryTile3(subcategory: subcategory),
                  );
                }).toList(),
              );
            }
          },
        ),
      ],
    );
  }
}

class SubCategoryTile3 extends StatefulWidget {
  final QueryDocumentSnapshot subcategory;

  SubCategoryTile3({required this.subcategory});

  @override
  State<SubCategoryTile3> createState() => _SubCategoryTile3State();
}

class _SubCategoryTile3State extends State<SubCategoryTile3> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: widget.subcategory.id.contains("*")
          ? Checkbox(
              value: issueList.contains(widget.subcategory.id),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    print(issueList.contains(widget.subcategory.id));
                    if (issueList.contains(widget.subcategory.id)) {
                      showSnackBar(
                          context: context, message: "Removed", error: true);
                      issueList.remove(widget.subcategory.id);
                    } else {
                      showSnackBar(context: context, message: "Added");
                      issueList.add(widget.subcategory.id);
                    }
                  });
                }
              },
            )
          : null,

      title: Text(widget.subcategory.id), // Subcategory name
      children: [
        // You can continue nesting more levels here if needed
      ],
    );
  }
}
