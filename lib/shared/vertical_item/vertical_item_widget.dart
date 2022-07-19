import 'dart:developer';

import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalItemWidget extends StatelessWidget {
  final String imagePath, title;
  final bool isFavorite;
  const VerticalItemWidget(
      {Key? key,
      required this.imagePath,
      required this.title,
      this.isFavorite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 200.h,
              width: 160.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: NetworkAppImage(
                  boxFit: BoxFit.fill,
                  // imageUrl: '${e.image}',
                  imageUrl: imagePath,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  log('Favorite');
                },
                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 160.w,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              height: 1.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
