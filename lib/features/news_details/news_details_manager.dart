import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/news_details/news_details_repo.dart';
import 'package:alsurrah/features/news_details/news_details_response.dart';
import 'package:rxdart/rxdart.dart';

class NewsDetailsManager extends Manager<NewsDetailsResponse> {
  final PublishSubject<NewsDetailsResponse> _subject =
      PublishSubject<NewsDetailsResponse>();
  Stream<NewsDetailsResponse> get newsDetails$ => _subject.stream;

  execute({required int newsId}) {
    Stream.fromFuture(NewsDetailsRepo.newsDetails(newsId: newsId))
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
