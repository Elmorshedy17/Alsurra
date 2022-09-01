import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/activities_details/activities_details_repo.dart';
import 'package:alsurrah/features/activities_details/activities_details_response.dart';
import 'package:alsurrah/features/booking_history/booking_history_page.dart';
import 'package:alsurrah/features/booking_history/booking_history_repo.dart';
import 'package:alsurrah/features/booking_history/booking_history_response.dart';
import 'package:alsurrah/shared/show_zoomable_enum/show_zoomable_enum.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BookingHistoryManager extends Manager<BookingHistoryResponse> {
  final PublishSubject<TapeType> subject = PublishSubject<TapeType>();

  final PublishSubject<BookingHistoryResponse> _subject =
      PublishSubject<BookingHistoryResponse>();

  Stream<BookingHistoryResponse> get bookingHistory$$ => _subject.stream;

  execute() async {
    await BookingHistoryRepo.bookingHistory().then((result) {
      if (result.error == null) {
        _subject.sink.add(result);
      } else {
        _subject.sink.addError(result.error);
      }
    });
  }
  //
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
