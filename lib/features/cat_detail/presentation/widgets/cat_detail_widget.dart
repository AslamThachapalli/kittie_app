import 'package:cat_brochure_app/core/constants/app_colors.dart';
import 'package:cat_brochure_app/core/utils/widgets/big_text.dart';
import 'package:cat_brochure_app/core/utils/widgets/small_text.dart';
import 'package:cat_brochure_app/features/cat_list/domain/entities/cats.dart';
import 'package:flutter/material.dart';

class CatDetailWidget extends StatelessWidget {
  final Cat cat;
  const CatDetailWidget({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 320,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 1,
        ),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            BigText(text: cat.breed),
            SizedBox(height: 8),
            SmallText(
              text: cat.temperament.replaceAll(", ", " . "),
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            SmallText(
              text: cat.description,
              textAlign: TextAlign.left,
              maxLines: 15,
              fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
