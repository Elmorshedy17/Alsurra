import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/app_core/resources/app_style/app_style.dart';
import 'package:alsurrah/features/hotel_or_chalet/hotel_or_chalet_repo.dart';
import 'package:alsurrah/features/hotel_or_chalet/hotel_or_chalet_response.dart';
import 'package:alsurrah/shared/show_zoomable_enum/show_zoomable_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class HotelOrChaletManager extends Manager<HotelOrChaletResponse> {

  final BehaviorSubject<int> counterSubject = BehaviorSubject<int>.seeded(0);

  final BehaviorSubject<int> maxSubject = BehaviorSubject<int>.seeded(0);

  Stream<int> get selectedCount$ => counterSubject.stream;

  set inSelectedCount(int selected) => counterSubject.sink.add(selected);

  get selectedCountValue => counterSubject.value;

  final PublishSubject<HotelOrChaletResponse> _subject =
  PublishSubject<HotelOrChaletResponse>();
  Stream<HotelOrChaletResponse> get hotelOrChaletDetails$ => _subject.stream;

  execute({required int hotelOrChaletId}) {
    Stream.fromFuture(
        HotelOrChaletRepo.hotelOrChalet(hotelOrChaletId: hotelOrChaletId))
        .listen((result) {
      if (result.error == null) {
        _subject.sink.add(result);
      } else {
        _subject.sink.addError(result.error);
      }
    });
  }

  /// 1. Select Option .
  static final ValueNotifier<int> _optionNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> get optionNotifier => _optionNotifier;
  static int get selectedOption => _optionNotifier.value;
  set _selectedOption(int newDate) => _optionNotifier.value = newDate;

  static DateTime now = DateTime.now();
  static DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);

  /// 2. Select Date.
  static final ValueNotifier<DateTime> _dateNotifier =
  ValueNotifier<DateTime>(tomorrow);
  ValueNotifier<DateTime> get dateNotifier => _dateNotifier;
  DateTime get selectedDate => _dateNotifier.value;
  set _selectedDate(DateTime newDate) => _dateNotifier.value = newDate;

  resetDate() {
    _selectedDate = tomorrow;
    _selectedOption = 0;
  }

  selectDate({
    required BuildContext context,
  }) async {
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
            colorScheme:
            const ColorScheme.light(primary: AppStyle.darkOrange)
                .copyWith(secondary: AppStyle.darkOrange),
            // colorScheme: const ColorScheme.light(primary: Color(0xFF8CE7F1))
            //     .copyWith(secondary: const Color(0xFF8CE7F1)),
          ),
          child: child!,
        );
      },
    ) ??
        _prevDate;
  }

  static getFormattedDate(DateTime dateTime) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(dateTime.toString());
    // var outputFormat = DateFormat('dd/MM/yyyy');
    var outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(inputDate);
  }

  //****************************************************************************
  final ValueNotifier<ShowZoomable> _showZoomableNotifier =
  ValueNotifier<ShowZoomable>(ShowZoomable.hide);
  ValueNotifier<ShowZoomable> get showZoomableNotifier => _showZoomableNotifier;
  ShowZoomable get showZoomable => _showZoomableNotifier.value;
  set showZoomable(ShowZoomable val) => _showZoomableNotifier.value = val;
  //****************************************************************************

  @override
  void dispose() {}
}
