import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/offer_or_discount/offer_or_discount_repo.dart';
import 'package:alsurrah/features/offer_or_discount/offer_or_discount_response.dart';
import 'package:alsurrah/shared/show_zoomable_enum/show_zoomable_enum.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OfferOrDiscountManager extends Manager<OfferOrDiscountResponse> {

  final BehaviorSubject<int> counterSubject = BehaviorSubject<int>.seeded(0);

  final BehaviorSubject<int> maxSubject = BehaviorSubject<int>.seeded(0);

  Stream<int> get selectedCount$ => counterSubject.stream;

  set inSelectedCount(int selected) => counterSubject.sink.add(selected);

  get selectedCountValue => counterSubject.value;

  final PublishSubject<OfferOrDiscountResponse> _subject =
      PublishSubject<OfferOrDiscountResponse>();
  Stream<OfferOrDiscountResponse> get offerOrDiscountDetails$ =>
      _subject.stream;

  execute({required int offerOrDiscountId}) {
    Stream.fromFuture(OfferOrDiscountRepo.offerOrDiscount(
            offerOrDiscountId: offerOrDiscountId))
        .listen((result) {
      if (result.error == null) {
        _subject.sink.add(result);
      } else {
        _subject.sink.addError(result.error);
      }
    });
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
