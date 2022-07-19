import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManagementItem extends StatelessWidget {
  final String? imgUrl, title, job, special;

  const ManagementItem(
      {Key? key, this.job, this.title, this.imgUrl, this.special = "no"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color:
                special == "yes" ? AppStyle.darkOrange : Colors.black.withOpacity(.2),
            width: special == "yes" ? 1 : 1),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: InkWell(
          // onTap: onTap ?? () {},
          child: SizedBox(
            // width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: NetworkAppImage(
                    height: 120.h,
                    width: double.infinity,
                    boxFit: BoxFit.fill,
                    // imageColor: Colors.red,
                    imageUrl: '$imgUrl',
                    // imageUrl: '${e}',
                  ),
                ),
                // const SizedBox(
                //   height: 12,
                // ),
                Expanded(
                  flex: 6,
                  child: Container(
                    color: special == "yes"
                        ? AppStyle.darkOrange
                        : AppStyle.darkOrange.withOpacity(.1),
                    height: 120.h,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$title",
                          style: special == "yes"
                              ? AppFontStyle.biggerBlueLabel.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                )
                              : AppFontStyle.biggerBlueLabel.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "$job",
                          style: special == "yes"
                              ? AppFontStyle.darkGreyLabel
                                  .copyWith(color: Colors.white)
                              : AppFontStyle.darkGreyLabel,
                          maxLines: 2,
                        ),
                      ],
                    ),
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
