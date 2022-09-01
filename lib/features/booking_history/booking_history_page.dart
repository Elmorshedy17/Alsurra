import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/booking_history/booking_history_manager.dart';
import 'package:alsurrah/features/faq/faq_manager.dart';
import 'package:alsurrah/features/faq/faq_response.dart';
import 'package:alsurrah/shared/custom_list_tile/custom_list_tile.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.use<FAQManager>().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final faqManager = context.use<FAQManager>();
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
      body: Observer<FAQResponse>(
          stream: faqManager.faq$,
          onRetryClicked: () {
            context.use<FAQManager>().execute();
          },
          onSuccess: (context, festivalDetailsSnapshot) {
            // return Container(
            //   margin: const EdgeInsets.all(15),
            //   child: festivalDetailsSnapshot.data!.faq!.isNotEmpty
            //       ? ListView.builder(
            //       itemCount: festivalDetailsSnapshot.data!.faq!.length,
            //       // itemCount: festivalDetailsSnapshot.data!.faq!.length,
            //       itemBuilder: (_, index) {
            //         return Container(
            //           margin: const EdgeInsets.only(bottom: 15),
            //           padding: const EdgeInsets.all(12),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             border: Border.all(color: AppStyle.darkOrange),
            //           ),
            //           child: CustomAnimatedOpenTile(
            //             headerTxt:
            //             festivalDetailsSnapshot.data!.faq![index].name,
            //             body: Text(
            //               "${festivalDetailsSnapshot.data!.faq![index].desc}",
            //               style: AppFontStyle.descFont,
            //             ),
            //           ),
            //         );
            //       })
            //       : NotAvailableComponent(
            //     view: const FaIcon(
            //       FontAwesomeIcons.question,
            //       color: AppStyle.darkOrange,
            //       size: 100,
            //     ),
            //     title: 'لا توجد اسئلة شائعة متاحة',
            //     titleTextStyle: AppFontStyle.biggerBlueLabel.copyWith(
            //         fontSize: 18.sp, fontWeight: FontWeight.w900),
            //     // ('no News'),
            //   ),
            // );
            return Container(
              padding:const EdgeInsets.all(15),
              child: ListView(
                children: [

                  StreamBuilder<TapeType>(
                    initialData: TapeType(
                        id: "All",
                        name: "الكل"
                    ),
                    stream: bookingHistoryManager.subject.stream,
                    builder: (context, tapesSubject) {
                      return SizedBox(
                        height: 50,
                        child: ListView.builder(
                            shrinkWrap: true,
                            // itemCount: widget.sliderList!.length,
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
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 3),
                                  child: Center(
                                    child: Text("${tapesType[index].name}",style: TextStyle(color: "${tapesType[index].id}" == "${tapesSubject.data!.id}" ? Colors.white : Colors.blueGrey),),
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  StreamBuilder<TapeType>(
                      initialData: TapeType(
                          id: "All",
                          name: "الكل"
                      ),
                      stream: bookingHistoryManager.subject.stream,
                      builder: (context, tapesSubject) {
                        return ListView.builder(
                          shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bookingTypes.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(color: Colors.grey.withOpacity(.4))
                                ),
                                child: Text('My Awesome Border'),
                              );
                            });
                      }
                  ),
                ],
              ),
            );
          }),
    );
  }
}


class BookingType {
  String? id,title,date,time,option,count,price,qrCode;
  BookingType({
    this.id,
    this.count,
    this.title,
    this.time,
    this.date,
    this.price,
    this.option,
    this.qrCode
});

}

List <BookingType> bookingTypes = [
  BookingType(
    id: "1",
    title: "dedw",
    price: "dwedw",
    option: "Dwedwe",
    time: "dwedwe",
    date: "dwedwe",
    qrCode: "Dwedwe",
    count: "dewdwdew"
  )
];


class TapeType {
String? name,id;
TapeType({
  this.id,this.name
});
}

List<TapeType> tapesType = [
  TapeType(
    id: "All",
    name: "الكل"
  ),
  TapeType(
    id: "Courses",
    name: "الدورات"
  ),
  TapeType(
    id: "Activities",
    name: "النوادي"
  ),
  TapeType(
    id: "Offers",
    name: "العروض"
  ),
  TapeType(
    id: "Discounts",
    name: "الخصومات"
  ),
  TapeType(
    id: "Chalets",
    name: "الشاليهات"
  ),
  TapeType(
    id: "Hotels",
    name: "الفنادق"
  ),
  TapeType(
    id: "PlayGrounds",
    name: "الملاعب"
  ),
];

