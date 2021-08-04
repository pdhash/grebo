import 'package:flutter/material.dart';
import 'package:greboo/core/utils/config.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  String? title,
  required Widget content,
  Function()? onTap,
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
            height: getProportionateScreenHeight(188),
            child: Column(
              children: [
                getHeightSizedBox(h: 27),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: content,
                ),
                getHeightSizedBox(h: 29),
                Spacer(),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                  width: double.infinity,
                  child: MaterialButton(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    onPressed: onTap,
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: color,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

res(double input) {}
