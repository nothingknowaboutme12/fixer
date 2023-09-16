import 'package:fixer/Utilies/app_color.dart';
import 'package:fixer/Utilies/dimention.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String titleText;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function? onChanged;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final Widget? prefixIcon;
  final double prefixSize;
  final TextAlign textAlign;
  final bool isNumber;
  final bool showTitle;
  final bool showBorder;
  final double iconSize;
  final bool isPhone;
  final Color? hintColor;
  final Color? cursorColor;
  final Color? fillColor;
  final Color? borderColor;
  final double? hintFontSize;

  const CustomTextField({
    Key? key,
    this.titleText = 'Write something...',
    this.hintText = '',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSubmit,
    this.onChanged,
    this.cursorColor,
    this.hintColor,
    this.hintFontSize,
    this.prefixIcon,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.prefixSize = Dimensions.paddingSizeSmall,
    this.textAlign = TextAlign.start,
    this.isNumber = false,
    this.showTitle = false,
    this.showBorder = true,
    this.iconSize = 18,
    this.fillColor,
    this.isPhone = false,
    this.borderColor,
  }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.showTitle
            ? Text(
                widget.titleText,
                style: TextStyle(fontSize: Dimensions.fontSizeSmall),
              )
            : const SizedBox(),
        TextField(
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          textAlign: widget.textAlign,
          style: TextStyle(
              fontSize: Dimensions.fontSizeLarge,
              color: MaterialColr.primaryColor),
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          cursorColor: widget.cursorColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone
              ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
              : widget.isNumber
                  ? [FilteringTextInputFormatter.allow(RegExp(r'\d'))]
                  : null,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              borderSide: BorderSide(
                style: widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                width: 0.5,
                color: widget.borderColor ?? Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              borderSide: BorderSide(
                  style:
                      widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                  width: 1,
                  color: widget.borderColor ?? Colors.white),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              borderSide: BorderSide(
                  style:
                      widget.showBorder ? BorderStyle.solid : BorderStyle.none,
                  width: 0.5,
                  color: widget.borderColor ?? Colors.white),
            ),
            isDense: true,
            hintText: widget.hintText,
            fillColor: widget.fillColor,
            hintStyle: TextStyle(
              fontSize: widget.hintFontSize ?? 12,
              color: widget.hintColor ?? Colors.grey.shade300,
            ),
            filled: true,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: MaterialColr.primaryColor,
                    ),
                    onPressed: _toggle,
                  )
                : null,
          ),
          onSubmitted: (text) => widget.nextFocus != null
              ? FocusScope.of(context).requestFocus(widget.nextFocus)
              : widget.onSubmit != null
                  ? widget.onSubmit!(text)
                  : null,
          onChanged: widget.onChanged as void Function(String)?,
        ),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
