import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityItem extends StatelessWidget {
  final String imageUrl, title, date, price;
  final VoidCallback? onTap;

  const ActivityItem(
      {Key? key,
      required this.title,
      required this.imageUrl,
      this.onTap,
      required this.date,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: InkWell(
            onTap: onTap ?? () {},
            child: SizedBox(
              // width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NetworkAppImage(
                    height: 150.h,
                    width: double.infinity,
                    boxFit: BoxFit.fill,
                    // imageColor: Colors.red,
                    imageUrl: imageUrl,
                    // imageUrl: '${e}',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, bottom: 5, left: 10),
                    child: Text(
                      title,
                      style: AppFontStyle.blueLabel,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, bottom: 5, left: 10),
                    child: Text(
                      date,
                      style: AppFontStyle.descFont,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, bottom: 15, left: 10),
                    child: Text(
                      price,
                      style: AppFontStyle.darkGreyLabel,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
