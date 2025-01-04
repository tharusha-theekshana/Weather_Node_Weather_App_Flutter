import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  TextEditingController searchController;
  final void Function(String) onSubmitted;

  SearchBarWidget({required this.searchController,required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onSubmitted: (value) {
        if (value.isEmpty) {
         _showErrorValidationPopUp();
        } else {
          onSubmitted(value); // Call the provided callback function if input is not empty
        }
      },
      style: const TextStyle(color: Colors.white,fontSize: 13.0),
      decoration: const InputDecoration(
        suffixIcon: Icon(
          Icons.search,
          color: Colors.white60,
        ),
        filled: true,
        fillColor: Colors.black26,
        hintText: 'Search .... ',
        hintStyle: TextStyle(color: Colors.white60),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: AppColors.whiteColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white38),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }

  void _showErrorValidationPopUp() {
    Get.snackbar(
      "",
      "",
      titleText: Container(
        margin: EdgeInsets.only(left: 20.0),
        child: const Text(
          "Enter search value",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.0),
        ),
      ),
      messageText: Container(
        margin: const EdgeInsets.only(left: 20.0),
        child: const Text(
          "Search text can not be empty.",
          style: TextStyle(color: AppColors.whiteColor, fontSize: 12.0),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.redColor,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 5),
      icon: Container(
          margin: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: const Icon(
            Icons.cancel_outlined,
            color: AppColors.whiteColor,
          )),
    );
  }
}
