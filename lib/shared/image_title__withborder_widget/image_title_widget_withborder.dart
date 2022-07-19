import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageTitleBorder extends StatelessWidget {
  final String? imageUrl, title, desc, price;
  final VoidCallback? onTap;

  const ImageTitleBorder(
      {Key? key, this.title, this.imageUrl, this.onTap, this.desc, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(.2), width: 1),
      ),
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
                  height: 140.h,
                  width: double.infinity,
                  boxFit: BoxFit.fill,
                  // imageColor: Colors.red,
                  imageUrl: '$imageUrl',
                  // imageUrl: '${e}',
                ),
                // const SizedBox(
                //   height: 12,
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 15,
                      right: 10,
                      bottom: desc == null && price == null ? 18 : 0,
                      left: 10),
                  child: Text(
                    "$title",
                    style: AppFontStyle.biggerBlueLabel
                        .copyWith(fontWeight: FontWeight.w500),
                    maxLines: 2,
                  ),
                ),
                if (desc != null)
                  Padding(
                    padding: EdgeInsets.only(
                        top: 5,
                        right: 10,
                        bottom: price == null ? 18 : 0,
                        left: 10),
                    child: Text(
                      "$desc",
                      style: AppFontStyle.biggerBlueLabel.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                    ),
                  ),
                if (price != null)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, right: 10, bottom: 18, left: 10),
                    child: Text(
                      "$price",
                      style: AppFontStyle.biggerBlueLabel.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                      maxLines: 2,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
