import 'package:flutter/material.dart';

import '../Style/colors.dart';

void errorMessage(BuildContext? context, {required String message}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: AppColors.red,
  ));
}

void success(BuildContext? context, {required String message}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: AppColors.primaryColor,
  ));
}
