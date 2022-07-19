import 'package:alsurrah/app_core/resources/app_assets/app_assets.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/bottom_navigation/pages/events/events_page.dart';
import 'package:alsurrah/features/bottom_navigation/pages/family_card/family_card_page.dart';
import 'package:alsurrah/features/bottom_navigation/pages/home/home_page.dart';
import 'package:alsurrah/features/bottom_navigation/pages/playgrounds/playgrounds_page.dart';
import 'package:alsurrah/features/bottom_navigation/pages/profile/profile_page.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MainTabsWidget extends StatefulWidget {
  const MainTabsWidget({Key? key}) : super(key: key);

  /// To Call any method from outside
  static _MainTabsWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainTabsWidgetState>();

  @override
  State<MainTabsWidget> createState() => _MainTabsWidgetState();
}

class _MainTabsWidgetState extends State<MainTabsWidget> {
  int currentIndex = 0;
  Widget currentWidget = const HomePage();
  Widget currentAppBarWidget = const AlsurrahAppBar(
    showNotification: true,
    showSearch: true,
  );

  void selectTap(
      int tabIndex,
      ) {
    currentIndex = tabIndex;
    switch (tabIndex) {
      case 0:
        currentAppBarWidget = const AlsurrahAppBar(
          showNotification: true,
          showSearch: true,
        );
        currentWidget = const HomePage();
        break;
      case 1:
        currentAppBarWidget = AlsurrahAppBar(
          showBack: true, showSearch: true,
          title: 'بطاقة العائلة',
          // title: '${context.translate(AppStrings.cart)}',
          onClickBack: () {
            selectTap(0);
          },
        );
        currentWidget = const FamilyCardPage();
        break;
      case 2:
        currentAppBarWidget = AlsurrahAppBar(
          showBack: true, showSearch: true,
          title: 'الفاعليات',
          // title: '${context.translate(AppStrings.cart)}',
          onClickBack: () {
            selectTap(0);
          },
        );
        currentWidget = const EventsPage();
        break;

      case 3:
        currentAppBarWidget = AlsurrahAppBar(
          showBack: true, showSearch: true,
          title: 'الملاعب',
          // title: '${context.translate(AppStrings.cart)}',
          onClickBack: () {
            selectTap(0);
          },
        );
        currentWidget = const PlaygroundsPage();
        break;
      case 4:
        currentAppBarWidget = AlsurrahAppBar(
          showBack: true, showSearch: true,
          title: 'حسابي',
          // title: '${context.translate(AppStrings.cart)}',
          onClickBack: () {
            selectTap(0);
          },
        );
        currentWidget = const ProfilePage();
        break;
      default:
        currentAppBarWidget = const AlsurrahAppBar();
        currentWidget = const HomePage();
        break;
    }
    setState(() {});
    // locator<MainTabsManager>().isFromAds = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 0) {
          return true;
        } else {
          selectTap(0);
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: AppStyle.mainAppColor,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          // child: SafeArea(
          child: currentAppBarWidget,
          // ),
        ),
        body: Container(color: AppStyle.mainAppColor, child: currentWidget),

        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.white,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: AppStyle.darkOrange,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: const TextStyle(color: Colors.yellow))),
          child: Container(
            // height: 70.h,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.8), //(x,y)
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                // topLeft: Radius.circular(12.0),
                // topRight: Radius.circular(12.0),
              ),
              child: BottomNavigationBar(
                selectedFontSize: 11.sp,
                unselectedFontSize: 10.sp,
                onTap: (index) {
                  selectTap(index);
                },
                currentIndex: currentIndex,
                selectedItemColor: AppStyle.darkOrange,
                // selectedItemColor: Colors.red,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                elevation: 5,
                unselectedItemColor: AppStyle.darkOrange.withOpacity(0.5),
                iconSize: 50,
                items: List.generate(5, (index) {
                  // var _selectedItemColor = AppStyle.beige;
                  var _selectedItemColor = AppStyle.darkOrange;
                  String _tooltip = '';
                  String _icon = '';
                  switch (index) {
                    case 0:
                      _icon = AppAssets.home;
                      // _tooltip = '${context.translate(AppStrings.home)}';
                      _tooltip = 'الرئيسية';
                      break;
                    case 1:
                      _icon = AppAssets.familyCard;
                      // _tooltip = '${context.translate(AppStrings.appointment)}';
                      _tooltip = 'بطاقة العائلة';
                      break;
                    case 2:
                      _icon = AppAssets.events;
                      // _tooltip = '${context.translate(AppStrings.appointment)}';
                      _tooltip = 'الفعاليات';
                      break;
                    case 3:
                      _icon = AppAssets.playgrounds;
                      // _tooltip = '${context.translate(AppStrings.profile)}';
                      _tooltip = 'حجز ملاعب';
                      break;
                    case 4:
                      _icon = AppAssets.profile;
                      // _tooltip = '${context.translate(AppStrings.profile)}';
                      _tooltip = 'حسابي';
                      break;

                    default:
                  }

                  return BottomNavigationBarItem(
                    icon: Container(
                      height: 35.h,
                      decoration: BoxDecoration(
                        // color: currentIndex == index
                        //     ? AppStyle.blue
                        //     : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(9),
                      child: SvgPicture.asset(
                        _icon,
                        // height: currentIndex == index ? null : 14.sp,
                        color: currentIndex == index
                            ? _selectedItemColor
                            : _selectedItemColor.withOpacity(0.5),
                      ),
                    ),
                    label: _tooltip,
                    // title: Text(
                    //   '$_tooltip',
                    //   style: TextStyle(height: 1.2),
                    // ),
                    tooltip: _tooltip,
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
