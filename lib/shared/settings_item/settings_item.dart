import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  Widget? leadingWidget, trailingWidget;
  String title;
  VoidCallback? onClick;
  SettingsItem(
      {Key? key,
      required this.title,
      this.onClick,
      this.leadingWidget,
      this.trailingWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick ?? () {},
      child: Row(
        children: [
          if (trailingWidget != null)
            Row(
              children: [
                trailingWidget!,
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          Text(
            title,
            style: AppFontStyle.darkGreyLabel
                .copyWith(color: AppStyle.darkGrey.withOpacity(.7)),
          ),
          const Spacer(),
          leadingWidget == null
              ? const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 15,
                  color: AppStyle.mediumGrey,
                )
              : leadingWidget!
        ],
      ),
    );
  }
}
