import 'package:alsurrah/features/bottom_navigation/fixed_section/fixed_section.dart';
import 'package:alsurrah/shared/grid_item/grid_item.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        itemCount: FixedSection.eventsSections.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemBuilder: (BuildContext context, int index) {
          return GridItem(
            title: FixedSection.eventsSections[index].title,
            imagePath: FixedSection.eventsSections[index].image,
            itemColor: FixedSection.eventsSections[index].backgroundColor,
            onClick: FixedSection.eventsSections[index].onClick,
          );
        });
  }
}
