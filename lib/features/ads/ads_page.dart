// import 'package:alsurrah/app_assets/app_assets.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/services/url_launcher/url_launcher.dart';
import 'package:alsurrah/features/app_settings/app_settings_response.dart';
// import 'package:alsurrah/shared/appbar/appbar.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:flutter/material.dart';

class AdsArgs {
  final Ads? ads;

  AdsArgs({this.ads});
}

class AdsPage extends StatelessWidget {
  const AdsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdsArgs args = ModalRoute.of(context)!.settings.arguments as AdsArgs;
    return Scaffold(
      body: Stack(
        children: [
          InkWell(
            onTap: () {
              if (args.ads?.link != null) {
                openURL('${args.ads?.link}');
              }
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: NetworkAppImage(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                boxFit: BoxFit.fill,
                imageUrl: '${args.ads?.image}',
              ),
            ),
          ),
          Positioned(
              bottom: 80,
              right: 25,
              left: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutesNames.mainTabsWidget);
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     AppRoutesNames.TABS_WIDGET, (route) => false);
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     AppRoutesNames.MainPageWithDrawer, (route) => false);
                    },
                    child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 8),
                          child: Text(
                            'تخطي',
                            style: AppFontStyle.darkGreyLabel,
                          ),
                        )),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
