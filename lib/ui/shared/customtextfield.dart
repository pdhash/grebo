import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/ui/screens/homeTab/home.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obSecureText;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;

  CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obSecureText = false,
      this.onTap,
      this.validator,
      this.suffix,
      this.keyboardType,
      this.textCapitalization})
      : super(key: key);

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
        obscureText: obSecureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: AppColor.kDefaultFontColor.withOpacity(0.5)),
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
