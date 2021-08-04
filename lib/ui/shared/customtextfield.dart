import 'package:flutter/material.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obSecureText;
  final String? Function(String?)? validator;
  Function()? onTap;
  final Widget? suffix;
  final TextInputType? keyboardType;

  CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obSecureText = false,
      this.onTap,
      this.validator,
      this.suffix,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(40),
      child: TextFormField(
        key: key,
        // textAlignVertical: TextAlignVertical.center,
        validator: validator,
        // textAlignVertical: TextAlignVertical.center,
        controller: controller,
        obscureText: obSecureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: AppColor.kDefaultFontColor.withOpacity(0.5)),
          // suffixIcon: suffix,
          suffixIcon: suffix,
          hintText: hintText,
        ),
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
