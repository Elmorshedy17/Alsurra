import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/features/news_details/news_details_manager.dart';
import 'package:alsurrah/features/news_details/news_details_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsDetailsArgs {
  final int newsId;
  final String? newsTitle;

  NewsDetailsArgs({required this.newsId, this.newsTitle});
}

class NewsDetailsPage extends StatefulWidget {
  const NewsDetailsPage({Key? key}) : super(key: key);

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  NewsDetailsArgs? args;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as NewsDetailsArgs;
      if (args != null) {
        locator<NewsDetailsManager>().execute(newsId: args!.newsId);
      }
      // context.use<NewsDetailsManager>().execute(newsId: args!.newsId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsDetailsManager = context.use<NewsDetailsManager>();

    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments as NewsDetailsArgs;
      locator<NewsDetailsManager>().execute(newsId: args!.newsId);
    }

    return Scaffold(
      // extendBodyBehindAppBar: true,
      // backgroundColor: Colors.red,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: AlsurrahAppBar(
          showNotification: false,
          showBack: true,
          showSearch: true,
          title: "${args?.newsTitle}",
        ),
        // ),
      ),
      body: Observer<NewsDetailsResponse>(
          stream: newsDetailsManager.newsDetails$,
          onRetryClicked: () {
            newsDetailsManager.execute(newsId: args!.newsId);
          },
          onSuccess: (context, newsDetailsSnapshot) {
            return ListView(
              children: [
                NetworkAppImage(
                  height: 200.h,
                  width: double.infinity,
                  boxFit: BoxFit.fill,
                  imageUrl: '${newsDetailsSnapshot.data!.news!.image}',
                  // imageUrl: '${e}',
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        '${newsDetailsSnapshot.data!.news?.name}',
                        style: AppFontStyle.biggerBlueLabel,
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      Html(
                        data: '${newsDetailsSnapshot.data!.news?.desc}',
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
