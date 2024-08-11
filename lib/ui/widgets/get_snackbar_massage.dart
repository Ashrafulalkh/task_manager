import 'package:flutter/material.dart';
import 'package:get/get.dart';

void getSnackbar(String title, String massage, Color colors) {
    Get.snackbar(
        title,
        massage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: colors,
        colorText: Colors.white,
    );
}
