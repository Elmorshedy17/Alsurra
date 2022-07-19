import 'package:alsurrah/features/bottom_navigation/fixed_section/fixed_section.dart';
import 'package:alsurrah/features/bottom_navigation/pages/home/widgets/home_slider.dart';
import 'package:alsurrah/shared/grid_item/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          HomeSlider(
            sliderHeight: 150.h,
            hasUrl: false,
            isCard: false,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15,left: 15),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                itemCount: FixedSection.homeSections.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (BuildContext context, int index) {
                  return GridItem(
                    title: FixedSection.homeSections[index].title,
                    imagePath: FixedSection.homeSections[index].image,
                    itemColor: Colors.white,
                    // itemColor: FixedSection.homeSections[index].backgroundColor,
                    onClick: FixedSection.homeSections[index].onClick,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
