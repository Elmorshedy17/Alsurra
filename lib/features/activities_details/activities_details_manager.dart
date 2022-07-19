import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/activities_details/activities_details_repo.dart';
import 'package:alsurrah/features/activities_details/activities_details_response.dart';
import 'package:rxdart/rxdart.dart';

class ActivityDetailsManager extends Manager<ActivityDetailsResponse> {
  final PublishSubject<ActivityDetailsResponse> _subject =
      PublishSubject<ActivityDetailsResponse>();

  Stream<ActivityDetailsResponse> get activityDetails$ => _subject.stream;

  final BehaviorSubject<int> counterSubject = BehaviorSubject<int>.seeded(1);

  Stream<int> get selectedCount$ => counterSubject.stream;

  set inSelectedCount(int selected) => counterSubject.sink.add(selected);

  get selectedCountValue => counterSubject.value;

  execute({required int activityId}) {
    Stream.fromFuture(
            ActivityDetailsRepo.activityDetails(activityId: activityId))
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
