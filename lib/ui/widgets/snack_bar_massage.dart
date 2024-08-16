import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void successSnackbarMassage(
  String title,
  String massage,
) {
  final snackBar =  SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: massage,
      contentType: ContentType.success,
    ),
  );

  scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
}

void failedSnackbarMassage(
    String title,
    String massage,
    ) {
  final snackBar =  SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: massage,
      contentType: ContentType.failure,
    ),
  );

  scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
}