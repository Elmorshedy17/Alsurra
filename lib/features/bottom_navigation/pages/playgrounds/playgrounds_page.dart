import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_routes_names/app_routes_names.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/bottom_navigation/pages/playgrounds/playgrounds_manager.dart';
import 'package:alsurrah/features/bottom_navigation/pages/playgrounds/playgrounds_response.dart';
import 'package:alsurrah/features/playground_details/playground_details_page.dart';
import 'package:alsurrah/shared/image_title__withborder_widget/image_title_widget_withborder.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlaygroundsPage extends StatefulWidget {
  const PlaygroundsPage({Key? key}) : super(key: key);

  @override
  State<PlaygroundsPage> createState() => _PlaygroundsPageState();
}

class _PlaygroundsPageState extends State<PlaygroundsPage> {
  late final PlaygroundsManager playgroundsManager;

  bool hasInitialDependencies = false;

  @override
  void didChangeDependencies() {
    if (!hasInitialDependencies) {
      hasInitialDependencies = true;
      playgroundsManager = context.use<PlaygroundsManager>();
      playgroundsManager.resetManager();
      playgroundsManager.reCallManager();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Observer<PlaygroundsResponse>(
          onRetryClicked: playgroundsManager.reCallManager,
          stream: playgroundsManager.response$,
          onSuccess: (context, playgroundsSnapshot) {
            playgroundsManager.updatePlaygroundsList(
                totalItemsCount: playgroundsSnapshot.data?.info?.total ?? 0,
                snapshotPlaygrounds:
                    playgroundsSnapshot.data?.playgrounds ?? []);
            return ListView(
              controller: playgroundsManager.scrollController,
              children: [
                playgroundsManager.playgrounds.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                            top: 24, bottom: 15, right: 15, left: 15),
                        itemCount: playgroundsManager.playgrounds.length,
                        itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: ImageTitleBorder(
                            imageUrl:
                                playgroundsManager.playgrounds[index].image!,
                            title: playgroundsManager.playgrounds[index].name!,
                            desc: playgroundsManager.playgrounds[index].desc!,
                            price:
                                'سعر الساعة: ${playgroundsManager.playgrounds[index].price!}',
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutesNames.playgroundDetailsPage,
                                arguments: PlaygroundDetailsArgs(
                                    playgroundId: playgroundsManager
                                        .playgrounds[index].id!,
                                    playgroundTitle: playgroundsManager
                                        .playgrounds[index].name),
                              );
                            },
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 150.h,
                          ),
                          NotAvailableComponent(
                            view: const FaIcon(
                              FontAwesomeIcons.squarePollHorizontal,
                              color: AppStyle.darkOrange,
                              size: 100,
                            ),
                            title: 'لا توجد ملاعب متاحة',
                            titleTextStyle: AppFontStyle.biggerBlueLabel
                                .copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w900),
                            // ('no News'),
                          ),
                        ],
                      ),
                StreamBuilder<PaginationState>(
                    initialData: PaginationState.idle,
                    stream: playgroundsManager.paginationState$,
                    builder: (context, paginationStateSnapshot) {
                      if (paginationStateSnapshot.data ==
                          PaginationState.loading) {
                        return const ListTile(
                            title: Center(
                          child: SpinKitWave(
                            color: AppStyle.darkOrange,
                            itemCount: 5,
                            size: 30.0,
                          ),
                        ));
                      }
                      if (paginationStateSnapshot.data ==
                          PaginationState.error) {
                        return ListTile(
                          leading: const Icon(Icons.error),
                          title: Text(
                            locator<PrefsService>().appLanguage == 'en'
                                ? 'Something Went Wrong Try Again Later'
                                : 'حدث خطأ ما حاول مرة أخرى لاحقاً',
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () async {
                              await playgroundsManager.onErrorLoadMore();
                            },
                            child: Text(
                                locator<PrefsService>().appLanguage == 'en'
                                    ? 'Retry'
                                    : 'أعد المحاولة'),
                          ),
                        );
                      }
                      return const SizedBox(
                        width: 0,
                        height: 0,
                      );
                    }),
              ],
            );
          }),
    );
  }
}
