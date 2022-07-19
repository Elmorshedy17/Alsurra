import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerticalCardWidget extends StatelessWidget {
  final String imagePath, title;
  const VerticalCardWidget(
      {Key? key, required this.imagePath, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        side: BorderSide(width: 0.1, color: Colors.grey),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: 160.w,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: Colors.grey[200]!),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SvgPicture.asset(
                  imagePath,
                ),
                // child: const NetworkAppImage(
                //   boxFit: BoxFit.fill,
                //   // imageUrl: '${e.image}',
                //   imageUrl:
                //       'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/briget-side-table-1582143245.jpg?crop=1.00xw:0.770xh;0,0.129xh&resize=768:*',
                // ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            // width: 40.w,
            margin: const EdgeInsets.only(bottom: 30),
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
      ),
    );
  }
}
