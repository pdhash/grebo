import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obSecureText;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Widget? suffix;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final double? textSize;
  final Color? hintColor;
  final FocusNode? focusNode;
  final double? suffixWidth;
  final InputBorder? inputBorder;
  final TextInputAction? textInputAction;
  final int? maxLength;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obSecureText = false,
    this.onTap,
    this.validator,
    this.suffix,
    this.keyboardType,
    this.textCapitalization,
    this.textSize = 16.0,
    this.prefix,
    this.hintColor,
    this.focusNode,
    this.suffixWidth,
    this.inputBorder,
    this.textInputAction,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(40),
      child: TextFormField(
        textCapitalization: textCapitalization == null
            ? TextCapitalization.none
            : textCapitalization as TextCapitalization,
        key: key,
        validator: validator,
        controller: controller,
        maxLength: maxLength,
        focusNode: focusNode,
        textInputAction: textInputAction,
        obscureText: obSecureText,
        keyboardType: keyboardType,
        buildCounter: (BuildContext context,
                {required int currentLength,
                required bool isFocused,
                required int? maxLength}) =>
            null,
        decoration: InputDecoration(
            disabledBorder: inputBorder,
            hintStyle: TextStyle(
                fontSize: getProportionateScreenWidth(textSize!.toDouble()),
                color: hintColor == null
                    ? AppColor.kDefaultFontColor.withOpacity(0.5)
                    : hintColor),
            suffixIcon: suffix,
            prefixIcon: prefix,
            hintText: hintText,
            suffixIconConstraints: BoxConstraints(
                maxHeight: 19,
                maxWidth: suffixWidth == null ? 40 : suffixWidth!.toDouble())),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class CustomTextField2 extends StatelessWidget {
  final TextEditingController comment;
  final String hintText;
  final Function()? send;

  const CustomTextField2(
      {Key? key, required this.comment, required this.hintText, this.send})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: 45,
        color: AppColor.textField2Color,
        padding: EdgeInsets.only(right: 15),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment,
                cursorHeight: 15,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    fillColor: Colors.transparent,
                    hintStyle:
                        TextStyle(fontSize: getProportionateScreenWidth(15)),
                    filled: true,
                    hintText: hintText,
                    border: InputBorder.none),
              ),
            ),
            GestureDetector(
                onTap: send, child: buildWidget(AppImages.send, 20, 22))
          ],
        ),
      ),
    );
  }
}
