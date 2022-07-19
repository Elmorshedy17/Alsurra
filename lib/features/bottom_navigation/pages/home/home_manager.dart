import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/bottom_navigation/pages/home/home_repo.dart';
import 'package:alsurrah/features/bottom_navigation/pages/home/home_response.dart';
import 'package:rxdart/rxdart.dart';

class HomeManager implements Manager<HomeResponse> {
  final BehaviorSubject<HomeResponse> _subject =
      BehaviorSubject<HomeResponse>();

  Stream<HomeResponse> get home$ => _subject.stream;

  execute() {
    Stream.fromFuture(HomeRepo.home()).listen((result) {
      if (result.error == null) {
        _subject.add(result);
      } else {
        _subject.addError(result.error);
      }
    });
    // return _subject.stream;
  }

  @override
  void dispose() {}
}
