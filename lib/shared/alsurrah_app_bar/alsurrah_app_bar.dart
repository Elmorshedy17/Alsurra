import 'package:alsurrah/app_core/resources/app_assets/app_assets.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlsurrahAppBar extends StatelessWidget {
  final bool showNotification, showSearch, showBack;

  final String title;
  final VoidCallback? onClickBack, onClickNotification, onClickSearch;
  const AlsurrahAppBar({
    Key? key,
    this.showNotification = false,
    this.showSearch = false,
    this.showBack = true,
    this.title = '',
    this.onClickBack,
    this.onClickNotification,
    this.onClickSearch,
  }) : super(key: key);

  _defaultOnClickBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  _defaultOnClickNotification(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutesNames.notificationsPage);
  }

  _defaultOnClickSearch(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutesNames.searchPage,
    );

    /// TODO: _defaultOnClickSearch
  }

  @override
  Widget build(BuildContext context) {
    // final appBarManager = context.use<AppBarManager>();

    return AppBar(
      backgroundColor: AppStyle.darkOrange,
      toolbarHeight: 60.h,
      // leadingWidth: showNotification ? 100.w : null,
      elevation: 0.0,
      leading: showBack == false
          ? Container()
          : showNotification
              ? IconButton(
                  icon: SvgPicture.asset(
                    AppAssets.notification,
                    color: Colors.white,
                  ),
                  onPressed: onClickNotification ??
                      () {
                        _defaultOnClickNotification(context);
                      },
                )
              : IconButton(
                  icon: SvgPicture.asset(AppAssets.back),
                  onPressed: onClickBack ??
                      () {
                        _defaultOnClickBack(context);
                      },
                ),
      title: title.isNotEmpty
          ? Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w400),
            )
          : Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(AppAssets.logo,color: Colors.white,height: 60,),
          ),
      centerTitle: true,
      actions: [
        if (showSearch == true)
          IconButton(
            icon: SvgPicture.asset(
              AppAssets.search,
              color: Colors.white,
            ),
            onPressed: onClickSearch ??
                () {
                  _defaultOnClickSearch(context);
                },
          ),
      ],
    );
  }
}
