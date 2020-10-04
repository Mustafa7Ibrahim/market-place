import 'package:flutter/material.dart';

void showToast(BuildContext context, String text) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(content: Text(text)),
  );
}
