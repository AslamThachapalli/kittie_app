import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_brochure_app/features/cat_detail/presentation/widgets/cat_detail_widget.dart';
import 'package:cat_brochure_app/features/cat_detail/presentation/widgets/detail_page_app_bar.dart';
import 'package:cat_brochure_app/features/cat_detail/presentation/widgets/detail_page_bottom_nav.dart';
import 'package:cat_brochure_app/features/cat_list/domain/entities/cats.dart';
import 'package:flutter/material.dart';

class CatDetailPage extends StatelessWidget {
  final Cat cat;
  const CatDetailPage({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Background Image
          Positioned(
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.maxFinite,
              height: 350,
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

          //Page appbar
          const DetailPageAppBar(),

          //Cat Details
          CatDetailWidget(cat: cat),
        ],
      ),
      bottomNavigationBar: DetailPageBottomNav(
        url: cat.wikiUrl,
      ),
    );
  }
}
