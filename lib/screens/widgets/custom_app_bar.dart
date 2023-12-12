

import 'package:ecommerce_training/core/managers/colors.dart';
import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
   MyCustomAppBar({this.text});
  final String? text;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color:AppColors.primaryColor, // Set your desired background color
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove the shadow
        title:   Text(text!,
            style: TextStyle(
                color: AppColors.backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
        centerTitle: true,
      ),
    );
  }
}
//AppBar(
//         backgroundColor: AppColors.primaryColor,
//         centerTitle: true,
//         title: const Text('Power Up Store',
//             style: TextStyle(
//                 color: AppColors.backgroundColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 25)),
//
//       ),