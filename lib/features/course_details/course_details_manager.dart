import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/course_details/course_details_repo.dart';
import 'package:alsurrah/features/course_details/course_details_response.dart';
import 'package:rxdart/rxdart.dart';

class CourseDetailsManager extends Manager<CourseDetailsResponse> {
  final PublishSubject<CourseDetailsResponse> _subject =
      PublishSubject<CourseDetailsResponse>();

  Stream<CourseDetailsResponse> get courseDetails$ => _subject.stream;

  final BehaviorSubject<int> counterSubject = BehaviorSubject<int>.seeded(1);

  Stream<int> get selectedCount$ => counterSubject.stream;

  set inSelectedCount(int selected) => counterSubject.sink.add(selected);

  get selectedCountValue => counterSubject.value;

  execute({required int courseId}) {
    Stream.fromFuture(CourseDetailsRepo.courseDetails(CourseId: courseId))
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
