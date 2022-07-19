import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/offer_or_discount/offer_or_discount_repo.dart';
import 'package:alsurrah/features/offer_or_discount/offer_or_discount_response.dart';
import 'package:rxdart/rxdart.dart';

class OfferOrDiscountManager extends Manager<OfferOrDiscountResponse> {
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

  @override
  void dispose() {}
}
