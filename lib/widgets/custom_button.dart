// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:stocks_app/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? function;
  final String? title;

  const CustomElevatedButton({this.function, this.title});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: dividerColor,
      ),
      child: Text(
        title!,
        style: const TextStyle(color: textColor),
      ),
    );
  }
}
