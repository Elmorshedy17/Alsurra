import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/barcode/barcode_request.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'barcode_manager.dart';

class BarcodePage extends StatefulWidget {
  const BarcodePage({Key? key}) : super(key: key);

  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  String? scanResult;
  Future scanBarcode() async {
    String result;
    result = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'إلغاء', true, ScanMode.BARCODE);

    if (!mounted) return;
    // setState(() => scanResult = result);
    locator<BarcodeManager>()
        .barcode(request: BarcodeRequest(code: result))
        .then((value) {
      if (value == ManagerState.success) {
        scanResult = locator<BarcodeManager>().message;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final barcodeManager = context.use<BarcodeManager>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: const AlsurrahAppBar(
          showBack: true,
          showSearch: true,
          title: 'قارئ الباركود',
        ),
      ),
      body: StreamBuilder<ManagerState>(
          initialData: ManagerState.idle,
          stream: barcodeManager.state$,
          builder: (context, AsyncSnapshot<ManagerState> stateSnapshot) {
            return FormsStateHandling(
              managerState: stateSnapshot.data,
              errorMsg: barcodeManager.errorDescription,
              onClickCloseErrorBtn: () {
                barcodeManager.inState.add(ManagerState.idle);
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      label: Text('ابدأ المسح'),
                      icon: Icon(Icons.camera_alt_outlined),
                      onPressed: scanBarcode,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(scanResult ?? 'إقرأ الكود')
                  ],
                ),
              ),
            );
          }),
    );
  }
}
