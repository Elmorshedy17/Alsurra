import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HorizontalCardWithRatingAndPriceWidget extends StatelessWidget {
  final String imagePath, title, desc;
  const HorizontalCardWithRatingAndPriceWidget(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.desc})
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
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110.w,
            height: 110.w,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(color: Colors.grey[200]!),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SvgPicture.asset(imagePath),
              // child: const NetworkAppImage(
              //   boxFit: BoxFit.fill,
              //   // imageUrl: '${e.image}',
              //   imageUrl:
              //       'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/briget-side-table-1582143245.jpg?crop=1.00xw:0.770xh;0,0.129xh&resize=768:*',
              // ),
            ),
          ),
          // const SizedBox(
          //   width: 5,
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   // width: 40.w,
                  //   margin: const EdgeInsets.only(bottom: 5),
                  //   child: Text(
                  //     title,
                  //     style: TextStyle(
                  //       fontSize: 13.sp,
                  //       height: 1.3,
                  //     ),
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),
                  Text(
                    'PU Leather Dinning Chair Armless Sidepu Leather Dinning Chair',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[700],
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          color:
                              index < 4 ? Colors.yellow[600] : Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '1500 EGP',
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
