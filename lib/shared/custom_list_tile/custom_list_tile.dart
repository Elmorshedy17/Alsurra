import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CustomAnimatedOpenTile extends StatelessWidget {
  // final vsync;
  final String? headerTxt;
  final Widget? body;
  final bool? outValue;

  CustomAnimatedOpenTile({
    Key? key,
    // this.vsync,
    this.headerTxt,
    this.body,
    this.outValue,
  }) : super(key: key);

  // static bool? listener;

  final BehaviorSubject<bool> open = BehaviorSubject<bool>.seeded(false);
  final prefs = locator<PrefsService>();

  void dispose() {
    // open.add(false);
    open.close();
  }

  void openToggle() {
    if (open.value == false) {
      open.add(true);
    } else {
      open.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: outValue,
        stream: open.stream,
        builder: (context, openSnapshot) {
          return AnimatedSize(
            duration: const Duration(milliseconds: 400),
            reverseDuration: const Duration(milliseconds: 400),
            alignment: Alignment.topCenter,
            // vsync: vsync,
            curve: Curves.easeIn,
            child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      openToggle();
                    },
                    child: Container(
                        key: UniqueKey(),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '$headerTxt',
                                  style: AppFontStyle.blueLabel,
                                ),
                                openSnapshot.data == true
                                    ? Icon(
                                        Icons.keyboard_arrow_up,
                                        color: AppStyle.darkOrange.withOpacity(.4),
                                      )
                                    : Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppStyle.darkOrange.withOpacity(.4),
                                      )
                              ],
                            ),
                            openSnapshot.data == true
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    width: double.infinity,
                                    color: AppStyle.darkOrange,
                                    height: 1,
                                  )
                                : Container(),
                          ],
                        )),
                  ),
                  openSnapshot.data == true
                      ? SizedBox(
                          width: double.infinity,
                          key: UniqueKey(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                // padding: EdgeInsets.symmetric(vertical:bodyPaddingV! ,horizontal: bodyPaddingH !),
                                child: body!,
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        });
  }
}
