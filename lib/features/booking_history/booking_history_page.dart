import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/booking_history/booking_history_manager.dart';
import 'package:alsurrah/features/booking_history/booking_history_response.dart';
import 'package:alsurrah/features/faq/faq_manager.dart';
import 'package:alsurrah/features/faq/faq_response.dart';
import 'package:alsurrah/shared/custom_list_tile/custom_list_tile.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:alsurrah/shared/show_zoomable_enum/show_zoomable_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  String selectedImage = '';
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<BookingHistoryManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final faqManager = context.use<FAQManager>();
    final bookingHistoryManager = context.use<BookingHistoryManager>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: const AlsurrahAppBar(
          showNotification: false,
          showBack: true,
          showSearch: true,
          title: "حجوزاتي",
        ),
        // ),
      ),
      body: Observer<BookingHistoryResponse>(
          stream: bookingHistoryManager.bookingHistory$$,
          onRetryClicked: () {
            context.use<BookingHistoryManager>().execute();
          },
          onSuccess: (context, bookingHistorySnapshot) {

            List<TapeType> tapesType = [
              TapeType(
                  id: "All",
                  name: "الكل",
                bookingData: bookingHistorySnapshot.data!.bookings!.all
              ),
              TapeType(
                  id: "Courses",
                  name: "الدورات",
                  bookingData: bookingHistorySnapshot.data!.bookings!.courses
              ),
              TapeType(
                  id: "Activities",
                  name: "النوادي",
                  bookingData: bookingHistorySnapshot.data!.bookings!.activities
              ),
              TapeType(
                  id: "Offers",
                  name: "العروض",
                  bookingData: bookingHistorySnapshot.data!.bookings!.offres
              ),
              TapeType(
                  id: "Discounts",
                  name: "الخصومات",
                  bookingData: bookingHistorySnapshot.data!.bookings!.disounts
              ),
              TapeType(
                  id: "Chalets",
                  name: "الشاليهات",
                  bookingData: bookingHistorySnapshot.data!.bookings!.chalets
              ),
              TapeType(
                  id: "Hotels",
                  name: "الفنادق",
                  bookingData: bookingHistorySnapshot.data!.bookings!.hotels
              ),
              TapeType(
                  id: "PlayGrounds",
                  name: "الملاعب",
                  bookingData: bookingHistorySnapshot.data!.bookings!.playgrounds
              ),
            ];


            return   ValueListenableBuilder<ShowZoomable>(
                valueListenable: bookingHistoryManager.showZoomableNotifier,
                builder: (context, value, _) {
                  return Stack(
                    children: [
                      Container(
                        padding:const EdgeInsets.all(15),
                        child:  StreamBuilder<TapeType>(
                            initialData: tapesType[0],
                            stream: bookingHistoryManager.subject.stream,
                            builder: (context, tapesSubject) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: tapesType.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: (){
                                              bookingHistoryManager.subject.sink.add(tapesType[index]);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 25),
                                              decoration: BoxDecoration(
                                                color: "${tapesType[index].id}" == "${tapesSubject.data!.id}"
                                                    ? AppStyle.darkOrange
                                                    : AppStyle.lightGrey.withOpacity(0.5),
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              margin:
                                              const EdgeInsets.symmetric(horizontal: 3),
                                              child: Center(
                                                child: Text("${tapesType[index].name}",style: TextStyle(color: "${tapesType[index].id}" == "${tapesSubject.data!.id}" ? Colors.white : Colors.blueGrey),),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),

                                  Expanded(
                                    child: AnimatedSwitcher(
                                      duration:const Duration(milliseconds: 500),
                                      child: Container(
                                        key: Key("${tapesSubject.data!.id}"),
                                        child: tapesSubject.data!.bookingData!.isNotEmpty ? ListView.builder(
                                            itemCount: tapesSubject.data!.bookingData!.length,
                                            itemBuilder: (context, index) {
                                              final  data = tapesSubject.data!.bookingData![index];
                                              return InkWell(
                                                onTap: (){
                                                  selectedImage = "${data.qrCode}";
                                                  bookingHistoryManager.showZoomable =
                                                      ShowZoomable.show;
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(15.0),
                                                  margin:const EdgeInsets.only(bottom: 15),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12.0),
                                                      border: Border.all(color: Colors.grey.withOpacity(.4))
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('${data.title}',style: AppFontStyle.biggerBlueLabel.copyWith(fontSize: 14.sp),maxLines: 2,),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text('رقم الحجز : ${data.id}',style: AppFontStyle.descFont,),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text('التاريخ:  ${data.date}',style: AppFontStyle.descFont,),
                                                      if(data.time != "")    Padding(
                                                        padding: const EdgeInsets.only(top: 10),
                                                        child: Text('الوقت:  ${data.time}',style: AppFontStyle.descFont,),
                                                      ),
                                                      if(data.option != "")    Padding(
                                                        padding: const EdgeInsets.only(top: 10),
                                                        child: Text('الاختيار:  ${data.option}',style: AppFontStyle.descFont,),
                                                      ),
                                                      if(data.count != 0)    Padding(
                                                        padding: const EdgeInsets.only(top: 10),
                                                        child: Text('العدد:  ${data.count}',style: AppFontStyle.descFont,),
                                                      ),
                                                      if(data.price != "")    Padding(
                                                        padding: const EdgeInsets.only(top: 10),
                                                        child: Text('السعر:  ${data.price}',style: AppFontStyle.descFont,),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              );
                                            }): NotAvailableComponent(
                                          view:
                                           FaIcon(
                                            FontAwesomeIcons.readme,
                                            color: AppStyle.darkOrange.withOpacity(.6),
                                            size: 100,
                                          ),
                                          title: 'لا توجد حجوزات متاحة',
                                          titleTextStyle: AppFontStyle.biggerBlueLabel.copyWith(
                                              fontSize: 18.sp, fontWeight: FontWeight.w900),
                                          // ('no News'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                        ),
                      ),
                      if (value == ShowZoomable.show)
                        Positioned.fill(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: PhotoView(
                                  backgroundDecoration: const BoxDecoration(
                                      color: Colors.black38),
                                  minScale:
                                  PhotoViewComputedScale.contained * 0.3,
                                  initialScale:
                                  PhotoViewComputedScale.contained * 0.8,
                                  imageProvider:
                                  NetworkImage(selectedImage, scale: 1),
                                ),
                              ),
                              Positioned(
                                bottom: 30,
                                left: 30,
                                child: FloatingActionButton(
                                  // mini: true,
                                  onPressed: () {
                                    bookingHistoryManager.showZoomable =
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

class TapeType {
String? name,id;
List<BookingData>? bookingData;


TapeType({
  this.id,this.name,this.bookingData
});
}


