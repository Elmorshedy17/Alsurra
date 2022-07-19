import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/hotel_or_chalet/hotel_or_chalet_manager.dart';
import 'package:flutter/material.dart';

class DateTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hotelOrChaletManager = context.use<HotelOrChaletManager>();
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder<DateTime>(
              valueListenable: hotelOrChaletManager.dateNotifier,
              builder: (context, value, _) {
                return InkWell(
                  onTap: () {
                    hotelOrChaletManager.selectDate(
                      context: context,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppStyle.darkGrey.withOpacity(.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'حدد تاريخ',
                          style: AppFontStyle.blueLabel.copyWith(fontSize: 13),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${value.day}/${value.month}/${value.year}',
                                style: AppFontStyle.darkGreyLabel
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppStyle.darkGrey.withOpacity(.6),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
