import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/faq/faq_repo.dart';
import 'package:alsurrah/features/faq/faq_response.dart';
import 'package:rxdart/rxdart.dart';

class FAQManager extends Manager<FAQResponse> {
  final BehaviorSubject<FAQResponse> subject = BehaviorSubject<FAQResponse>();
  Stream<FAQResponse> get faq$ => subject.stream;

  execute() {
    Stream.fromFuture(FAQRepo.faq()).listen((result) {
      if (result.error == null) {
        subject.sink.add(result);
      } else {
        subject.sink.addError(result.error);
      }
    });
  }

  @override
  void dispose() {}
}
