import 'package:cat_brochure_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DetailPageAppBar extends StatelessWidget {
  const DetailPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 45,
      left: 15,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40 / 2),
            color: AppColors.accentColor,
          ),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
