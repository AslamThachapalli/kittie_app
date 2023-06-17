import 'package:cat_brochure_app/core/constants/app_colors.dart';
import 'package:cat_brochure_app/core/utils/widgets/big_text.dart';
import 'package:cat_brochure_app/features/cat_detail/presentation/pages/wiki_webview_page.dart';
import 'package:flutter/material.dart';

class DetailPageBottomNav extends StatelessWidget {
  final String url;
  const DetailPageBottomNav({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WikiWebViewPage(wikiUrl: url),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.accentColor,
              ),
              child: const BigText(
                text: 'Open In Wiki',
                textColor: Colors.white,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
