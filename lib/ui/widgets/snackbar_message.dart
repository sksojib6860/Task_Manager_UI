import 'package:flutter/material.dart';

void snackbarMessgae(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
      ),
    ),
  );
}
