import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CounterWidget extends StatelessWidget {
  Stream<int> stream;
  int maxCount;
  VoidCallback onDecrement, onIncrement;
  CounterWidget(
      {Key? key,
      required this.stream,
      required this.maxCount,
      required this.onDecrement,
      required this.onIncrement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        initialData: 1,
        stream: stream,
        builder: (context, counterSnapshot) {
          return Row(
            children: [
              Text(
                "العدد :",
                style: AppFontStyle.blueLabel,
              ),
              const SizedBox(
                width: 45,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        if (counterSnapshot.data! < maxCount) {
                          onIncrement();
                        } else {
                          locator<ToastTemplate>().show("لقد بلغت الحد الاقصي");
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppStyle.darkOrange,
                        ),
                        // width: double.infinity,
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.plus,
                            color: Colors.white,
                            // size: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "${counterSnapshot.data!}",
                    style: AppFontStyle.biggerBlueLabel
                        .copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        if (counterSnapshot.data! > 1) {
                          onDecrement();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppStyle.red,
                        ),
                        // width: double.infinity,
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.minus,
                            color: Colors.white,
                            // size: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          );
        });
  }
}
