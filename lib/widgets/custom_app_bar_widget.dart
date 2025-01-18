import 'package:flutter/material.dart';
import 'package:weather_node/widgets/search_bar_widget.dart';

import '../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double deviceWidth;
  final double deviceHeight;
  final TextEditingController searchController;
  final void Function() onLogoTap;
  final void Function(String) onSearchSubmitted;

  const CustomAppBar({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.searchController,
    required this.onLogoTap,
    required this.onSearchSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blackColor,
      elevation: 0,
      titleSpacing: 0,
      leading: Padding(
        padding: EdgeInsets.only(left: deviceWidth * 0.02),
        child: GestureDetector(
          onTap: onLogoTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.01),
            height: deviceHeight * 0.06,
            child: Image.asset(
              "assets/images/logo/logo_letter.png",
            ),
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
        child: SearchBarWidget(
          searchController: searchController,
          onSubmitted: onSearchSubmitted,
        ),
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
