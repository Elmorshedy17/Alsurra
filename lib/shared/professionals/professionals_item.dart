import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfessionalsWidget extends StatelessWidget {
  final String imagePath, title;
  const ProfessionalsWidget(
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
              // padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: Colors.grey[200]!),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                // child: SvgPicture.asset(imagePath),
                child: NetworkAppImage(
                  boxFit: BoxFit.fill,
                  // imageUrl: '${e.image}',
                  imageUrl: imagePath,
                ),
              ),
            ),
          ),
          Container(
            width: 160.w,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
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
          ),
        ],
      ),
    );
  }
}
