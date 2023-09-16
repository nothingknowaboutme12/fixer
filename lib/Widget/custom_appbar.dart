import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  Widget? leading;
  IconData? leadingIcon;
  bool? centerTitle;
  String? title;
  bool? backbutton;
  double? elevations;
  CustomAppBar({
    super.key,
    this.leading,
    this.leadingIcon,
    this.centerTitle,
    this.title,
    this.titleColor,
    this.titleFontSize,
    this.backgroundColr,
    this.backbutton,
    this.elevations,
    this.trailing,
  });

  Color? titleColor;
  double? titleFontSize;
  Color? backgroundColr;
  List<Widget>? trailing;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backbutton == false
          ? SizedBox()
          : leading ??
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  leadingIcon ?? Icons.arrow_back_ios,
                ),
              ),
      elevation: elevations ?? 2,
      automaticallyImplyLeading: backbutton ?? true,
      centerTitle: centerTitle ?? false,
      backgroundColor: backgroundColr ?? Colors.blue,
      actions: trailing,
      title: Text(
        title ?? "AppBar",
        style: TextStyle(
          color: titleColor,
          fontSize: titleFontSize ?? 14,
        ),
      ),
    );
  }
}
