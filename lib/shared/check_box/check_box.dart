import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCheckBox extends StatelessWidget {
  bool isChecked;
  CustomCheckBox({Key? key, required this.isChecked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: isChecked ? AppStyle.darkOrange.withOpacity(.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: isChecked ? AppStyle.darkOrange : AppStyle.darkGrey.withOpacity(.3),
        ),
      ),
      child: isChecked
          ? const Center(
              child: FaIcon(
                FontAwesomeIcons.check,
                color: AppStyle.darkOrange,
                size: 12,
              ),
            )
          : const SizedBox(),
    );
  }
}
