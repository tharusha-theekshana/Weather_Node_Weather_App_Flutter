import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController{

  final getStorage = GetStorage();

  static const String themeMode = "ThemeMode";

  // Change theme
  void changeThemeMode(){
    String? theme = getStorage.read(themeMode);
    if(theme == null || theme == "light"){
      getStorage.write(themeMode, "dark");
      Get.changeThemeMode(ThemeMode.dark);
    }else{
      getStorage.write(themeMode, "light");
      Get.changeThemeMode(ThemeMode.light);
    }
    update();
  }

  // Change icon according to theme
  IconData iconTheme(){
    String? theme = getStorage.read(themeMode);
    if(theme == "light" || theme == null){
      return Icons.dark_mode;
    }else{
      return Icons.light_mode;
    }
  }

}