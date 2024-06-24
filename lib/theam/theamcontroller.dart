import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkTheme = false.obs;

  void changeTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    Get.changeTheme(
      isDarkTheme.value
          ? ThemeData.dark().copyWith(
              primaryColor: Color.fromARGB(255, 206, 14, 155),
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
            )
          : ThemeData.light().copyWith(
              primaryColor: Colors.green,
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: Colors.yellow),
            ),
    );
  }
}
