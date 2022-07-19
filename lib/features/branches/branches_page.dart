import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_font_styles/app_font_styles.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/app_core/services/url_launcher/url_launcher.dart';
import 'package:alsurrah/features/branches/branches_manager.dart';
import 'package:alsurrah/features/branches/branches_response.dart';
import 'package:alsurrah/features/branches/widgets/add_marker.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:alsurrah/shared/not_available_widget/not_available_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BranchesPage extends StatefulWidget {
  const BranchesPage({Key? key}) : super(key: key);

  @override
  State<BranchesPage> createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  @override
  void initState() {
    super.initState();
    locator<BranchesManager>().execute();
  }

  @override
  Widget build(BuildContext context) {
    final branchesManager = context.use<BranchesManager>();

    // Set<Marker> markers = {};

    // locator<BranchesManager>().execute(newsId: args!.newsId);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      // backgroundColor: Colors.red,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: const AlsurrahAppBar(
          showNotification: false,
          showBack: true,
          showSearch: true,
          title: "الفروع",
        ),
        // ),
      ),
      body: Observer<BranchesResponse>(
          stream: branchesManager.branches$,
          onRetryClicked: () {
            branchesManager.execute();
          },
          onSuccess: (context, managementSnapshot) {
            final List<Branches> branches = managementSnapshot.data!.branches!;

            addMarker(branches: branches, context: context);

            return Container(
              child: managementSnapshot.data!.branches!.isNotEmpty
                  ? ListView(
                      children: [
                        SizedBox(
                          height: 180.h,
                          child: StreamBuilder<Set<Marker>>(
                              stream: branchesManager.markersSubject.stream,
                              initialData: const {},
                              builder: (context, markersSnapshot) {
                              return  GoogleMap(
                                  // initialCameraPosition: _initialCameraPosition,
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          double.parse(
                                              "${managementSnapshot.data!.branches![0].lat}"),
                                          double.parse(
                                              "${managementSnapshot.data!.branches![0].lng}")),
                                      zoom: 9),
                                  myLocationButtonEnabled: false,
                                  zoomControlsEnabled: true,
                                  gestureRecognizers: Set()..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
                                  markers: markersSnapshot.data!,
                                );
                              }),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(
                                top: 24, bottom: 15, right: 15, left: 15),
                            itemCount:
                                managementSnapshot.data!.branches!.length,
                            itemBuilder: (_, index) {
                              Branches branch =
                                  managementSnapshot.data!.branches![index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppStyle.lightGrey),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${branch.name}",
                                      style: AppFontStyle.blueLabel
                                          .copyWith(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "العنوان : ${branch.address}",
                                            style: AppFontStyle.darkGreyLabel
                                                .copyWith(fontSize: 14),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            MapUtils.openMap(
                                                double.parse("${branch.lat}"),
                                                double.parse("${branch.lng}"));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: AppStyle.darkOrange,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: const [
                                                FaIcon(
                                                  FontAwesomeIcons.locationDot,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "الموقع",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          if (branch.phone != null ||
                                              branch.phone != "" ||
                                              branch.phone != "null") {
                                            openURL("tel://${branch.phone}");
                                          }
                                        },
                                        child: Text(
                                          "تليفون : ${branch.phone}",
                                          style: AppFontStyle.darkGreyLabel
                                              .copyWith(fontSize: 14),
                                        )),
                                  ],
                                ),
                              );
                            })
                      ],
                    )
                  : NotAvailableComponent(
                      view: const FaIcon(
                        FontAwesomeIcons.mapLocationDot,
                        color: AppStyle.darkOrange,
                        size: 100,
                      ),
                      title: 'لا توجد فروع متاحة',
                      titleTextStyle: AppFontStyle.biggerBlueLabel.copyWith(
                          fontSize: 18.sp, fontWeight: FontWeight.w900),
                      // ('no News'),
                    ),
            );
          }),
    );
  }
}
