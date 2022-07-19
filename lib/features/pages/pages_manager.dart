import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/pages/pages_repo.dart';
import 'package:alsurrah/features/pages/pages_response.dart';
import 'package:rxdart/rxdart.dart';

class PagesManager extends Manager<PagesResponse> {
  final BehaviorSubject<PagesResponse> subject =
      BehaviorSubject<PagesResponse>();
  Stream<PagesResponse> get pages$ => subject.stream;

  execute() {
    Stream.fromFuture(PagesRepo.pages()).listen((result) {
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
