import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/playground_details/playground_details_manager.dart';
import 'package:alsurrah/features/playground_details/playground_details_response.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/custom_list_tile/custom_list_tile.dart';
import 'package:alsurrah/shared/main_button/main_button_widget.dart';
import 'package:alsurrah/shared/network_app_image/network_app_image.dart';
import 'package:alsurrah/shared/show_zoomable_enum/show_zoomable_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

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
  String selectedImage = '';

  PlaygroundDetailsArgs? args;
  @override
  void initState() {
    super.initState();
    locator<PlaygroundDetailsManager>().resetDateTime();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      args =
          ModalRoute.of(context)!.settings.arguments as PlaygroundDetailsArgs;
      if (args != null) {
        locator<PlaygroundDetailsManager>()
            .execute(playgroundId: args!.playgroundId);
      }
      // context.use<NewsDetailsManager>().execute(newsId: args!.newsId);
    });

    locator<PlaygroundDetailsManager>().showZoomable =
        ShowZoomable.hide;
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
            return

              ValueListenableBuilder<ShowZoomable>(
                  valueListenable:
                  playgroundDetailsManager.showZoomableNotifier,
                  builder: (context, value, _) {
                    return Stack(
                      children: [
                        ListView(
                          children: [
                            InkWell(
                              onTap: (){
                                selectedImage = '${playgroundDetailsSnapshot.data!.playground!.image}';
                                playgroundDetailsManager.showZoomable =
                                    ShowZoomable.show;
                              },
                              child: NetworkAppImage(
                                height: 300.h,
                                width: double.infinity,
                                boxFit: BoxFit.fill,
                                imageUrl:
                                '${playgroundDetailsSnapshot.data!.playground!.image}',
                                // imageUrl: '${e}',
                              ),
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
                                  const SizedBox(
                                    height: 15,
                                  ),

                                const  Text("التاريخ"),

                                  const SizedBox(
                                    height: 15,
                                  ),
                                  StreamBuilder<String>(
                                    initialData: "",
                                    stream: playgroundDetailsManager.reservationDate.stream,
                                    builder: (context, reservationDateSnapshot) {
                                      return InkWell(
                                        onTap: () async {
                                          print("XXXXXXX=> playgroundDetailsManager.emptyDays? ${playgroundDetailsManager.emptyDays}");
                                          DateTime? newDateTime = await showRoundedDatePicker(
                                            onTapDay: (DateTime dateTime, bool available) {
                                              if (!available) {
                                                if(!playgroundDetailsManager.emptyDays.contains(dateTime.weekday)){
                                                  showDialog(
                                                      context: context,
                                                      builder: (c) => CupertinoAlertDialog(title: const Text("الوقت المحدد غير متاح"),actions: <Widget>[
                                                        CupertinoDialogAction(child:const Text("حسنا"),onPressed: (){
                                                          Navigator.pop(context);
                                                        },)
                                                      ],));
                                                }

                                              }

                                              if(playgroundDetailsManager.emptyDays.contains(dateTime.weekday)){
                                                showDialog(
                                                    context: context,
                                                    builder: (c) => CupertinoAlertDialog(title: const Text("الوقت المحدد غير متاح"),actions: <Widget>[
                                                      CupertinoDialogAction(child: const Text("حسنا"),onPressed: (){
                                                        Navigator.pop(context);
                                                      },)
                                                    ],));
                                                return !available;
                                              }
                                              playgroundDetailsManager.addDateAndFormat(dateTime: dateTime);
                                              return available;
                                            }, context: context,
                                            // selectableDayPredicate: playgroundDetailsManager.emptyDays ,
                                            theme: ThemeData(primarySwatch: Colors.deepOrange),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now().add(const Duration(days: 60)),);

                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(7),
                                            border: Border.all(color: AppStyle.darkOrange),
                                          ),
                                          child: Container(
                                            padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text( reservationDateSnapshot.data != ""? "${reservationDateSnapshot.data}" :"اختر التاريخ",style: TextStyle(color: AppStyle.darkOrange),),
                                              const Icon(Icons.calendar_today_outlined,color: AppStyle.orange,size: 17,)
                                              ],

                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  ),

                                  const SizedBox(
                                    height: 25,
                                  ),
                                  const  Text("الوقت"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: AppStyle.darkOrange),
                                    ),
                                    child: StreamBuilder<String>(
                                        initialData: "",
                                        stream: playgroundDetailsManager.reservationTime.stream,
                                        builder: (context, reservationTimeSnapshot) {
                                        return CustomAnimatedOpenTile(
                                          headerTxt:
                                          reservationTimeSnapshot.data != "" ? reservationTimeSnapshot.data : "اختر الوقت",
                                          body: StreamBuilder<List<String>>(
                                            initialData: [],
                                            stream: playgroundDetailsManager.availableHoursSubject.stream,
                                            builder: (context, availableHoursSnapshot) {
                                              return ListView.separated(
                                                separatorBuilder: (context, index) {
                                                  return Divider();
                                                },
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount:
                                                availableHoursSnapshot.data!.length,
                                                itemBuilder: (_, index) => Padding(
                                                  padding: const EdgeInsets.only(bottom: 7),
                                                  child: InkWell(
                                                    onTap: (){
                                                      playgroundDetailsManager.reservationTime.sink.add(availableHoursSnapshot.data![index]);
                                                    },
                                                    child: Text(availableHoursSnapshot.data![index],),
                                                  ),
                                                ),
                                              );
                                            }
                                          ),
                                        );
                                      }
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  MainButtonWidget(

                                    horizontalPadding: 25,
                                    title: 'حجز الملعب',
                                    onClick: () {
                                      if(playgroundDetailsManager.reservationTime.value == ""){
                                        locator<ToastTemplate>().show("برجاء تحديد التاريخ والوقت اولا");
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                        if (value == ShowZoomable.show)
                          Positioned.fill(
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: PhotoView(
                                    backgroundDecoration:
                                    const BoxDecoration(
                                        color: Colors.black38),
                                    minScale: PhotoViewComputedScale.contained * 0.3,
                                    initialScale: PhotoViewComputedScale.contained * 0.8,
                                    imageProvider: NetworkImage(
                                        selectedImage,
                                        scale: 1
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 30,
                                  left: 30,
                                  child: FloatingActionButton(
                                    // mini: true,
                                    onPressed: () {
                                      playgroundDetailsManager.showZoomable =
                                          ShowZoomable.hide;
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  });
          }),
    );
  }
}


// Future<void> showData(context,dayOff,) async {
//   final now = DateTime.now();
//   final yesterday = DateTime(now.year, now.month, now.day - 1);
//   // print("dayOffdayOffdayOffdayOff$listDateDisabled");
//   await showRoundedDatePicker(
//       onTapDay: (DateTime dateTime, bool available) {
//
//         // if(!dayOff.contains(dateTime.weekday) && !listDateDisabled.contains(dateTime) && dateTime.isAfter(yesterday)){
//         //   final DateTime now = DateTime.now();
//         //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
//         //   final String formatted = formatter.format(dateTime);
//         //
//         //   checkOutManger.selectedDateSubject.add(formatted.toString());
//         //   toast.show(formatted.toString());
//         // }
//         // if ( dayOff.contains(dateTime.weekday) || listDateDisabled.contains(dateTime) ) {
//           // showDialog(
//           //     context: context,
//           //     builder: (c) => CupertinoAlertDialog(title: Text(AppLocalizations.of(context).translate('This_date_cannot_be_selected_str',)),actions: <Widget>[
//           //       CupertinoDialogAction(child: Text(AppLocalizations.of(context).translate('ok_str',)),onPressed: (){
//           //         Navigator.pop(context);
//           //       },)
//           //     ],));
//         // }
//         return available;
//       },
//       builderDay: (DateTime dateTime, bool isCurrentDay, bool isSelected, TextStyle defaultTextStyle) {
//
//         if(dayOff.contains(dateTime.weekday)){
//           return Container(
//             decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
//             child: Container(
//                 child:  Center(
//                   child: Text(
//                     dateTime.day.toString(),
//                     style: TextStyle(color: Colors.grey.withOpacity(.7)),
//                   ),
//                 )),
//           );
//         }
//         return Container(
//           child: Center(
//             child: Text(
//               dateTime.day.toString(),
//               style: defaultTextStyle,
//             ),
//           ),
//         );
//       },
//       theme: ThemeData.dark(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 60)),
//       // listDateDisabled: listDateDisabled,
//       context: context,
//       background: Colors.white,
//       textPositiveButton: "ok",
//       textNegativeButton: "Cancel_str}"
//   );
// }