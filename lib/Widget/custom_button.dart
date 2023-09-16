import 'package:fixer/Utilies/dimention.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  void Function()? onpressed;
  String? title;
  double? titleSize;
  double? height;
  double? width;
  double? horizontalMargin;
  double? verticalMargin;
  Color? titleColor;

  Color? backgroundColor;
  double? radius;

  CustomButton({
    required this.onpressed,
    this.title,
    this.titleSize,
    this.titleColor,
    this.backgroundColor,
    this.radius,
    this.elevation,
    this.height,
    this.width,
    this.horizontalMargin,
    this.verticalMargin,
    this.iconData,
  });

  double? elevation;
  IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      width: width ?? double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin ?? 10, vertical: verticalMargin ?? 0),
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10)),
          elevation: elevation ?? 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconData != null ? Icon(iconData) : const SizedBox(),
            Text(
              title ?? "Tap",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleSize ?? Dimensions.fontSizeDefault,
                color: titleColor ?? Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  void Function()? onpressed;
  String? title;
  double? titleSize;
  Color? titleColor;

  double? radius;

  CustomTextButton({
    required this.onpressed,
    this.title,
    this.titleSize,
    this.titleColor,
    this.radius,
    this.elevation,
    this.iconData,
  });

  double? elevation;
  IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpressed,
      style: TextButton.styleFrom(
        elevation: elevation ?? 2,
      ),
      child: Text(
        title ?? "Tap",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: titleSize ?? Dimensions.fontSizeDefault,
          color: titleColor ?? Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
