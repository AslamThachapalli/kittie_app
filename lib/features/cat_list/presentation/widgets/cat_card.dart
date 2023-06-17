import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_brochure_app/core/constants/app_colors.dart';
import 'package:cat_brochure_app/core/utils/widgets/big_text.dart';
import 'package:cat_brochure_app/core/utils/widgets/small_text.dart';
import 'package:cat_brochure_app/features/cat_detail/presentation/pages/cat_detail_page.dart';
import 'package:cat_brochure_app/features/cat_list/domain/entities/cats.dart';
import 'package:cat_brochure_app/features/cat_list/presentation/widgets/icon_with_text_widget.dart';
import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final Cat cat;
  const CatCard({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CatDetailPage(cat: cat),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        height: 120,
        child: Row(
          children: [
            Container(
              width: 130,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: cat.imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  ),
                  errorWidget: (context, url, error) => const SizedBox.shrink(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: const BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(
                      text: cat.breed,
                      fontSize: 20,
                    ),
                    SizedBox(height: 4),
                    SmallText(
                      text: cat.description,
                      maxLines: 2,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconWithTextWidget(
                            icon: Icons.location_on_rounded,
                            iconColor: Color(0xFFC34271),
                            text: cat.countryCode),
                        IconWithTextWidget(
                            icon: Icons.lightbulb,
                            iconColor: Color(0xFF4285F4),
                            text: generateStars(cat.intelligence)),
                        IconWithTextWidget(
                            icon: Icons.fitness_center,
                            iconColor: Color(0xFF000080),
                            text: "${cat.weight} kg"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String generateStars(int num) {
    String text = "";
    for (var e in List.generate(cat.intelligence, (_) => "✰")) {
      text += e;
    }
    return text;
  }
}
