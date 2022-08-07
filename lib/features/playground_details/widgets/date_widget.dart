// import 'dart:developer';
//
// import 'package:alsurrah/app_core/app_core.dart';
// import 'package:alsurrah/features/playground_details/playground_details_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class DateTimeWidget extends StatelessWidget {
//   // final List<AvailableTime> times;
//   // final String serviceId;
//   // const DateTimeWidget({Key? key, required this.times, required this.serviceId})
//   const DateTimeWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final playgroundDetailsManager = context.use<PlaygroundDetailsManager>();
//     return Card(
//       elevation: 3,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('اختر التاريخ والوقت'),
//             const SizedBox(
//               height: 15,
//             ),
//             ValueListenableBuilder<DateTime>(
//                 valueListenable: playgroundDetailsManager.dateNotifier,
//                 builder: (context, value, _) {
//                   return InkWell(
//                     onTap: () {
//                       playgroundDetailsManager.selectDate(
//                           context: context, serviceId: '1');
//                       log('${value.weekday}');
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: Colors.grey[200]!,
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'اختر التاريخ',
//                             style: const TextStyle(
//                                 color: Colors.grey, fontSize: 9),
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                     '${value.day}/${value.month}/${value.year}'),
//                                 // '10/09/2022'),
//                               ),
//                               const Icon(
//                                 Icons.keyboard_arrow_down_outlined,
//                                 color: Colors.grey,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//             const SizedBox(
//               height: 15,
//             ),
//             ValueListenableBuilder<int>(
//                 valueListenable: playgroundDetailsManager.timeNotifier,
//                 builder: (context, value, _) {
//                   return Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: Colors.grey[200]!,
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'اختر الوقت',
//                                 style: const TextStyle(
//                                     color: Colors.grey, fontSize: 9),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               DropdownButton<String>(
//                                 isDense: true,
//                                 underline: const SizedBox.shrink(),
//                                 icon: const Icon(
//                                   Icons.keyboard_arrow_down_outlined,
//                                   color: Colors.grey,
//                                 ),
//                                 hint: Text(
//                                   // value == -1
//                                   //     ?
//                                   'اختر الوقت'
//                                   // : '${times[value].name}',
//                                   ,
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize:
//                                           // value == -1 ? 11.sp : 9.sp),
//                                           11.sp),
//                                 ),
//                                 items: ['1', '2'].map((String time) {
//                                   return DropdownMenuItem<String>(
//                                     value: time,
//                                     child: Text(
//                                       '${time}',
//                                       style: TextStyle(fontSize: 10.sp),
//                                     ),
//                                   );
//                                 }).toList(),
//                                 // value: _selectedLocation,
//                                 // isDense: true,
//                                 isExpanded: true,
//                                 onChanged: (newVal) {
//                                   // setState(() {
//                                   //   _selectedProductTyp = newVal!;
//                                   // });
//                                   // makeAppointmentManager.selectedTime =
//                                   //     times.indexOf(newVal!);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         // InkWell(
//                         //   onTap: () {
//                         //     makeAppointmentManager.selectTime(context);
//                         //   },
//                         //   child: const Icon(
//                         //     Icons.keyboard_arrow_down_outlined,
//                         //     color: Colors.grey,
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }
