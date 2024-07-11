import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';

void simpleSnackBarBoxWidget<T>({
  required BuildContext context,
  required String title,
  bool? showCloseButton,
  int? duration,
  Color? color,
  required bool isInfinite,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.showSnackBar(
    isInfinite
        ? SnackBar(
            dismissDirection: DismissDirection.startToEnd,
            backgroundColor: kRedColor,
            duration: Duration(days: duration!),
            behavior: SnackBarBehavior.floating,
            showCloseIcon: showCloseButton,
            content: Center(child: Text(title)),
          )
        : SnackBar(
            backgroundColor: color ?? kGreenColor,
            behavior: SnackBarBehavior.floating,
            showCloseIcon: showCloseButton,
            content: Center(child: Text(title)),
          ),
  );
}
