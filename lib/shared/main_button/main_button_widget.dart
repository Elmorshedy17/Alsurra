import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:flutter/material.dart';

// class MainButtonWidget extends StatelessWidget {
//   final double? width, marginTop;
//   final double horizontalPadding;
//   final Color? color, shadowColor, borderColor;
//   final String title;
//   final VoidCallback? onClick;
//
//   const MainButtonWidget({
//     Key? key,
//     this.width,
//     this.marginTop,
//     this.color,
//     this.shadowColor,
//     this.borderColor,
//     required this.title,
//     this.onClick,
//     this.horizontalPadding = 0,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//       margin: EdgeInsets.only(top: marginTop ?? 0, bottom: 25),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               side: BorderSide(
//                 color: borderColor ?? AppStyle.darkOrange,
//               )),
//           primary: color ?? AppStyle.darkOrange,
//           shadowColor: shadowColor ?? AppStyle.darkOrange,
//           fixedSize: width == 0
//               ? null
//               : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
//           padding: const EdgeInsets.symmetric(vertical: 12),
//         ),
//         onPressed: onClick,
//         child: Text(
//           title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             height: 1.3,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }


class MainButtonWidget extends StatelessWidget {
  final double? width, marginTop;
  final double horizontalPadding;
  final Color? color, shadowColor, borderColor;
  final List<Color> gradientColors;
  final String title;
  final VoidCallback? onClick;

  const MainButtonWidget({
    Key? key,
    this.width,
    this.marginTop,
    this.color,
    this.gradientColors = const[
            Color(0xffe5794c),
            Color(0xffe56c46),
            Color(0xffe75c40),
            Color(0xffe8503b),
            Color(0xffeb4537),
            Color(0xffeb3f34),
    ],
    this.shadowColor,
    this.borderColor,
    required this.title,
    this.onClick,
    this.horizontalPadding = 0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onClick,
      child: Container(
        width: width == 0
            ? null
            : width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? AppStyle.darkOrange,),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: shadowColor?? Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 6,
              offset:const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: color,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors

          ),

        ),
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        margin: EdgeInsets.only(top: marginTop ?? 0, bottom: 25),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
