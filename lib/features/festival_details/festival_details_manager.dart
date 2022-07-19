import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/festival_details/festival_details_repo.dart';
import 'package:alsurrah/features/festival_details/festival_details_response.dart';
import 'package:rxdart/rxdart.dart';

class FestivalDetailsManager extends Manager<FestivalDetailsResponse> {
  final PublishSubject<FestivalDetailsResponse> _subject =
      PublishSubject<FestivalDetailsResponse>();
  Stream<FestivalDetailsResponse> get festivalDetails$ => _subject.stream;

  execute({required int festivalId}) {
    Stream.fromFuture(
            FestivalDetailsRepo.festivalDetails(festivalId: festivalId))
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
