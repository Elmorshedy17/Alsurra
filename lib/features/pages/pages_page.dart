import 'package:alsurrah/app_core/resources/app_assets/app_assets.dart';
import 'package:alsurrah/shared/alsurrah_app_bar/alsurrah_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PagesArgs {
  final String? title, body;

  PagesArgs({this.title, this.body});
}

class PagesPage extends StatefulWidget {
  const PagesPage({Key? key}) : super(key: key);

  @override
  State<PagesPage> createState() => _PagesPageState();
}

class _PagesPageState extends State<PagesPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PagesArgs;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        // child: SafeArea(
        child: AlsurrahAppBar(
          showNotification: false,
          showBack: true,
          showSearch: true,
          title: "${args.title}",
        ),
        // ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Image.asset(
              AppAssets.bigLogo,
              fit: BoxFit.fill,
              height: 115.h,
            )),
            const SizedBox(
              height: 20,
            ),
            Html(
              data: '${args.body}',
            ),
          ],
        ),
      ),
    );
  }
}
