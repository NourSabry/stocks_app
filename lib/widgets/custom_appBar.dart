// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:stocks_app/colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  CustomAppBar(this.title);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:   Text(
       title!,
        style: const TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: appBarColor,
      elevation: 0,
      centerTitle: true,
    );
  }
}
