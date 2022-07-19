import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/features/playground_details/playground_details_manager.dart';
import 'package:alsurrah/features/playground_details/playground_details_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaygroundDetailsArgs {
  final int playgroundId;
  final String? playgroundTitle;

  PlaygroundDetailsArgs({required this.playgroundId, this.playgroundTitle});
}

class PlaygroundDetailsPage extends StatefulWidget {
  const PlaygroundDetailsPage({Key? key}) : super(key: key);

  @override
  State<PlaygroundDetailsPage> createState() => _PlaygroundDetailsPageState();
}

class _PlaygroundDetailsPageState extends State<PlaygroundDetailsPage> {
  PlaygroundDetailsArgs? args;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args =
          ModalRoute.of(context)!.settings.arguments as PlaygroundDetailsArgs;
      if (args != null) {
        locator<PlaygroundDetailsManager>()
            .execute(playgroundId: args!.playgroundId);
      }
      // context.use<NewsDetailsManager>().execute(newsId: args!.newsId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final playgroundDetailsManager = context.use<PlaygroundDetailsManager>();

    if (args == null) {
      args =
          ModalRoute.of(context)!.settings.arguments as PlaygroundDetailsArgs;
      locator<PlaygroundDetailsManager>()
          .execute(playgroundId: args!.playgroundId);
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
          title: "${args?.playgroundTitle}",
        ),
        // ),
      ),
      body: Observer<PlaygroundDetailsResponse>(
          stream: playgroundDetailsManager.playgroundDetails$,
          onRetryClicked: () {
            playgroundDetailsManager.execute(playgroundId: args!.playgroundId);
          },
          onSuccess: (context, playgroundDetailsSnapshot) {
            return ListView(
              children: [
                NetworkAppImage(
                  height: 200.h,
                  width: double.infinity,
                  boxFit: BoxFit.fill,
                  imageUrl:
                      '${playgroundDetailsSnapshot.data!.playground!.image}',
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
                        '${playgroundDetailsSnapshot.data!.playground?.name}',
                        style: AppFontStyle.biggerBlueLabel,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'سعر الساعة: ${playgroundDetailsSnapshot.data!.playground?.price}',
                        style: AppFontStyle.biggerBlueLabel.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Html(
                        data:
                            '${playgroundDetailsSnapshot.data!.playground?.desc}',
                      ),
                    ],
                  ),
                ),
                // MainButtonWidget(
                //   horizontalPadding: 25,
                //   title: 'حجز الملعب',
                //   onClick: () {
                //     showModalBottomSheet(
                //       context: context,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       backgroundColor: Colors.white,
                //       builder: (context) {
                //         return DateTimeWidget();
                //       },
                //     );
                //   },
                // )
              ],
            );
          }),
    );
  }
}
