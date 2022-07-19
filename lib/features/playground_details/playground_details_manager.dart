import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/playground_details/playground_details_repo.dart';
import 'package:alsurrah/features/playground_details/playground_details_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class PlaygroundDetailsManager extends Manager<PlaygroundDetailsResponse> {
  final PublishSubject<PlaygroundDetailsResponse> _subject =
      PublishSubject<PlaygroundDetailsResponse>();
  Stream<PlaygroundDetailsResponse> get playgroundDetails$ => _subject.stream;

  List<StartAndEndTimes> _times = [];

  execute({required int playgroundId}) {
    Stream.fromFuture(
            PlaygroundDetailsRepo.playgroundDetails(playgroundId: playgroundId))
        .listen((result) {
      if (result.error == null) {
        _subject.sink.add(result);
        _times
          ..add(result.data!.playground!.mon!)
          ..add(result.data!.playground!.tue!)
          ..add(result.data!.playground!.wed!)
          ..add(result.data!.playground!.thu!)
          ..add(result.data!.playground!.fri!)
          ..add(result.data!.playground!.sat!)
          ..add(result.data!.playground!.sun!);
      } else {
        _subject.sink.addError(result.error);
      }
    });
  }

  @override
  void dispose() {}
  //****************************************************************************
  static DateTime now = DateTime.now();
  static DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);

  /// 1. Select Date.
  static final ValueNotifier<DateTime> _dateNotifier =
      ValueNotifier<DateTime>(tomorrow);
  ValueNotifier<DateTime> get dateNotifier => _dateNotifier;
  static DateTime get selectedDate => _dateNotifier.value;
  set _selectedDate(DateTime newDate) => _dateNotifier.value = newDate;

  resetDate() {
    _selectedDate = tomorrow;
  }

  selectDate({required BuildContext context, required String serviceId}) async {
    DateTime _prevDate = selectedDate;
    _selectedDate = await showDatePicker(
          context: context,
          initialDate: tomorrow,
          firstDate: tomorrow,
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: const Color(0xFF8CE7F1),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                colorScheme: const ColorScheme.light(primary: AppStyle.darkOrange)
                    .copyWith(secondary: AppStyle.darkOrange),
                // colorScheme: const ColorScheme.light(primary: Color(0xFF8CE7F1))
                //     .copyWith(secondary: const Color(0xFF8CE7F1)),
              ),
              child: child!,
            );
          },
        ) ??
        _prevDate;

    // if (selectedDate.year != _prevDate.year ||
    //     selectedDate.month != _prevDate.month ||
    //     selectedDate.day != _prevDate.day) {
    //   resetTime();
    //   context.use<TimesManager>().execute(
    //     request: TimesRequest(
    //         date: MakeAppointmentManager.getFormattedDate(
    //             MakeAppointmentManager.selectedDate),
    //         serviceId: serviceId),
    //   );
    // }
  }

  static getFormattedDate(DateTime dateTime) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(dateTime.toString());
    // var outputFormat = DateFormat('dd/MM/yyyy');
    var outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(inputDate);
  }

//****************************************************************************//
  /// 2. Select Time.
  final ValueNotifier<int> _timeNotifier = ValueNotifier<int>(-1);
  ValueNotifier<int> get timeNotifier => _timeNotifier;
  int get selectedTime => _timeNotifier.value;
  set selectedTime(int newTime) => _timeNotifier.value = newTime;

  resetTime() {
    selectedTime = -1;
  }

  selectTime(DateTime selectedDate) {
    late StartAndEndTimes selectedTime;
    switch (selectedDate.weekday) {
      case 1:
        selectedTime = _times[0];
        break;
      case 2:
        selectedTime = _times[1];
        break;
      case 3:
        selectedTime = _times[2];
        break;
      case 4:
        selectedTime = _times[3];
        break;
      case 5:
        selectedTime = _times[4];
        break;
      case 6:
        selectedTime = _times[5];
        break;
      case 7:
        selectedTime = _times[6];
        break;
    }

    String start = selectedTime.start!;
    String end = selectedTime.end!;

    var startTime = DateFormat.jm().parse(start);
    var endTime = DateFormat.jm().parse(end);

    // final times = getTimeSlots(startTime, endTime, interval)
    //     .toList();

    //   List<String> dayTimes = [];
    //
    //   var startTime = DateFormat.jm().parse(start);
    //   var endTime = DateFormat.jm().parse(end);
    //
    //   for (var i = startTime.hour; i < endTime.hour; i++) {
    //     dayTimes.add('${startTime-1}')
    //   }
  }

  Iterable<TimeOfDay> getTimeSlots(
      TimeOfDay startTime, TimeOfDay endTime, Duration interval) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += interval.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }
//****************************************************************************//
}
