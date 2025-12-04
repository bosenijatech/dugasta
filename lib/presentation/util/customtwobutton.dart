import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:flutter/material.dart';

Widget cancelbutton(
  onpress,
) =>
    TextButton(
        style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
            foregroundColor:
                WidgetStateProperty.all<Color>(AppColor.primaryColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: AppColor.primaryColor)))),
        onPressed: () => onpress,
        child: Text("Clear".toUpperCase(), style: TextStyle(fontSize: 14)));

Widget submitbutton(
  onpress,
) =>
    ElevatedButton(
      onPressed: () => onpress,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      child: Text("Submit"),
    );
