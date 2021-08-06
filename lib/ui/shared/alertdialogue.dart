import 'package:flutter/material.dart';
import 'package:greboo/core/utils/config.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required double height,
  String? title,
  required Widget content,
  required Function()? onTap,
  required Color color,
  required String okText,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)), //this right here
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            height: height,
            child: Column(
              children: [
                Spacer(
                  flex: 2,
                ),
                title == null
                    ? SizedBox()
                    : Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(16)),
                      ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: content,
                ),
                Spacer(
                  flex: 2,
                ),
                SizedBox(
                  height: getProportionateScreenWidth(45),
                  width: double.infinity,
                  child: MaterialButton(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    onPressed: onTap,
                    child: Text(
                      okText,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(15)),
                    ),
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

res(double input) {}
