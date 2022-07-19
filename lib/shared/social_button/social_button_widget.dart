import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SocialType {
  facebook,
  apple,
  google,
}

class SocialButtonWidget extends StatelessWidget {
  final double? width, marginTop;
  final double horizontalPadding;
  final Color? color, shadowColor, borderColor;
  final String title;

  final VoidCallback? onClick;
  final SocialType socialType;

  const SocialButtonWidget({
    Key? key,
    this.width,
    this.marginTop,
    this.color,
    this.shadowColor,
    this.borderColor,
    required this.title,
    required this.socialType,
    this.onClick,
    this.horizontalPadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      margin: EdgeInsets.only(top: marginTop ?? 0, bottom: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: borderColor ?? AppStyle.darkOrange)),
          primary: color ?? AppStyle.darkOrange,
          shadowColor: shadowColor ?? AppStyle.darkOrange,
          fixedSize: width == 0
              ? null
              : Size.fromWidth(width ?? MediaQuery.of(context).size.width),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: socialType == SocialType.facebook
                      ? Colors.blue[600]
                      : socialType == SocialType.apple
                          ? Colors.black
                          : Colors.red[600],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Icon(
                    socialType == SocialType.facebook
                        ? FontAwesomeIcons.facebookF
                        : socialType == SocialType.apple
                            ? FontAwesomeIcons.apple
                            : FontAwesomeIcons.google,
                    color: Colors.white,
                    // size: 20,
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        onPressed: onClick,
      ),
    );
  }
}
