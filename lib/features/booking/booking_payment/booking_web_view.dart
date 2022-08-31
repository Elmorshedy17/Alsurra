import 'dart:developer';
import 'dart:io';

import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/booking/booking_manager.dart';
import 'package:alsurrah/features/booking/booking_payment/payment_gatway_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookingWebViewArgs {
  final String paymentUrl;

  BookingWebViewArgs({
    required this.paymentUrl,
  });
}

class BookingWebViewPage extends StatefulWidget {
  const BookingWebViewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BookingWebViewPage> createState() => _BookingWebViewPageState();
}

class _BookingWebViewPageState extends State<BookingWebViewPage> {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final BookingWebViewArgs args =
        ModalRoute.of(context)!.settings.arguments as BookingWebViewArgs;
    final bookingManager = context.use<BookingManager>();

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.grey[100],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
        ),
        body:
            // SingleChildScrollView(
            //   child:
            ValueListenableBuilder<bool>(
                valueListenable: isLoading,
                builder: (context, value, __) {
                  if (value) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: SpinKitWave(
                          color: AppStyle.red,
                          itemCount: 5,
                          size: 50.0,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: WebView(
                        onWebViewCreated: (controller) async {
                          // _controller.complete(controller);
                          _controller = controller;
                          log('XXxXX${await _controller.currentUrl()}');
                        },
                        navigationDelegate:
                            (NavigationRequest navigation) async {
                          // print('XXxXX${await _controller.currentUrl()}');
                          NavigationDecision _n = NavigationDecision.navigate;
                          log('XXxXX${navigation.url}');
                          // success
                          // payment_fail

                          return _n;
                        },
                        initialUrl: args.paymentUrl,
                        javascriptMode: JavascriptMode.unrestricted,
                        onPageFinished: (url) async {
                          log('OOoOO $url');
                          if (url.startsWith('https://alsurracoop.net/')) {
                            isLoading.value = true;
                            await PaymentGatWay.paymentResponse(url)
                                .then((result) {
                              if (result.status == 1) {
                                // Navigator.of(context).pushReplacementNamed(
                                //   AppRoutesNames.PaymentStatusPage,
                                //   arguments: PaymentStatusPageArgs(
                                //       isSuccess: true,
                                //       orderId: '${result.data?.id}'),
                                // );
                                // checkoutManager.paymentResult =
                                //     PaymentResult.success;
                                // checkoutManager.inState
                                //     .add(ManagerState.idle);
                                // Navigator.of(context).popUntil(
                                //     ModalRoute.withName(AppRoutesNames
                                //         .makeAppointmentPage));
                              } else {
                                // Navigator.of(context).pushReplacementNamed(
                                //   AppRoutesNames.PaymentStatusPage,
                                //   arguments: PaymentStatusPageArgs(
                                //     isSuccess: false,
                                //   ),
                                // );
                                // checkoutManager.paymentResult =
                                //     PaymentResult.fail;
                                // checkoutManager.inState
                                //     .add(ManagerState.idle);
                                // Navigator.of(context).popUntil(
                                //     ModalRoute.withName(AppRoutesNames
                                //         .makeAppointmentPage));
                              }
                            });
                          }
                        },
                      ),
                    );
                  }
                }),
        // ),
      ),
    );
  }
}
