import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridItem extends StatelessWidget {
  final String title, imagePath;
  final VoidCallback onClick;
  final Color itemColor;
  const GridItem(
      {Key? key,
      required this.title,
      required this.imagePath,
      required this.onClick,
      required this.itemColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              // padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                // color: itemColor,
                color: AppStyle.lightGrey.withOpacity(.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                  // height: 40.w,
                  // width: 40.w,
                  // color: Colors.red,
                ),
              ),
            )
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            title,
            style:const TextStyle(
              // color: AppStyle.darkOrange,
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
              // fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
