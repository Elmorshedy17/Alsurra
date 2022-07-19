import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/management/management_repo.dart';
import 'package:alsurrah/features/management/management_response.dart';
import 'package:rxdart/rxdart.dart';

class ManagementManager extends Manager<ManagementResponse> {
  final PublishSubject<ManagementResponse> _subject =
      PublishSubject<ManagementResponse>();
  Stream<ManagementResponse> get management$ => _subject.stream;

  execute() {
    Stream.fromFuture(ManagementRepo.management()).listen((result) {
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
