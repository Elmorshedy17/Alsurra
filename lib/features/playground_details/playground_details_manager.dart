import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/playground_details/playground_details_repo.dart';
import 'package:alsurrah/features/playground_details/playground_details_response.dart';
import 'package:alsurrah/shared/show_zoomable_enum/show_zoomable_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class PlaygroundDetailsManager extends Manager<PlaygroundDetailsResponse> {





  final BehaviorSubject<PlaygroundDetailsResponse> _subject =
      BehaviorSubject<PlaygroundDetailsResponse>();

List <String> availableHours = [];
  final BehaviorSubject <List<String>> availableHoursSubject =
  BehaviorSubject<List<String>>.seeded([]);


  final BehaviorSubject<String> reservationDate =
  BehaviorSubject<String>.seeded("");
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  void addDateAndFormat({required DateTime dateTime}){
    availableHours.clear();
    availableHoursSubject.sink.add([]);
    final String formatted = formatter.format(dateTime);
    reservationDate.sink.add(formatted);
    reservationTime.sink.add("");
    if(_subject.hasValue){
      if(dateTime.weekday == 1){
        availableHours = List.from(_subject.value!.data!.playground!.mon!);
      }else
      if(dateTime.weekday == 2){
        availableHours = List.from(_subject.value!.data!.playground!.tue!);
      }else
      if(dateTime.weekday == 3){
        availableHours = List.from(_subject.value!.data!.playground!.wed!);
      }else
      if(dateTime.weekday == 4){
        availableHours = List.from(_subject.value!.data!.playground!.thu!);
      }else
      if(dateTime.weekday == 5){
        availableHours = List.from(_subject.value!.data!.playground!.fri!);
      }else
      if(dateTime.weekday == 6){
        availableHours = List.from(_subject.value!.data!.playground!.sat!);
      }else
      if(dateTime.weekday == 7){
        availableHours = List.from(_subject.value!.data!.playground!.sun!);
      }
      availableHoursSubject.sink.add(availableHours);
    }
  }



  final BehaviorSubject<String> reservationTime =
  BehaviorSubject<String>.seeded("");

  resetDateTime(){
    reservationTime.sink.add("");
    reservationDate.sink.add("");
    availableHoursSubject.sink.add([]);
    availableHours.clear();
  }

  Stream<PlaygroundDetailsResponse> get playgroundDetails$ => _subject.stream;

  List<int> emptyDays = [];

  execute({required int playgroundId}) {
    Stream.fromFuture(
            PlaygroundDetailsRepo.playgroundDetails(playgroundId: playgroundId))
        .listen((result) {
      emptyDays.clear();
      if (result.error == null) {
        if(result.data!.playground!.mon!.isEmpty){
          emptyDays.add(1);
        }
        if(result.data!.playground!.tue!.isEmpty){
          emptyDays.add(2);
        }
        if(result.data!.playground!.wed!.isEmpty){
          emptyDays.add(3);
        }
        if(result.data!.playground!.thu!.isEmpty){
          emptyDays.add(4);
        }
        if(result.data!.playground!.fri!.isEmpty){
          emptyDays.add(5);
        }
        if(result.data!.playground!.sat!.isEmpty){
          emptyDays.add(6);
        }
        if(result.data!.playground!.sun!.isEmpty){
          emptyDays.add(7);
        }


        _subject.sink.add(result);


      } else {
        _subject.sink.addError(result.error);
      }
    });
  }

  @override
  void dispose() {}


// ********************************************************


  final ValueNotifier<ShowZoomable> _showZoomableNotifier =
  ValueNotifier<ShowZoomable>(ShowZoomable.hide);
  ValueNotifier<ShowZoomable> get showZoomableNotifier => _showZoomableNotifier;
  ShowZoomable get showZoomable => _showZoomableNotifier.value;
  set showZoomable(ShowZoomable val) => _showZoomableNotifier.value = val;
//****************************************************************************

}
