import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/news/news_repo.dart';
import 'package:alsurrah/features/news/news_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum PaginationState {
  loading,
  success,
  error,
  idle,
}

class NewsManager extends Manager<NewsResponse> {
  int currentPageNum = 1;
  int maxPageNum = 5;
  int totalItemsCount = 0;

  List<News> newsList = [];

  final PublishSubject<NewsResponse> _newsResponseSubject =
      PublishSubject<NewsResponse>();

  Stream<NewsResponse> get response$ => _newsResponseSubject.stream;

  final PublishSubject<PaginationState> _paginationStateSubject =
      PublishSubject<PaginationState>();
  Stream<PaginationState> get paginationState$ =>
      _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  ScrollController scrollController = ScrollController();

  NewsManager() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await loadMore();
      }
    });
  }

  Future<void> loadMore() async {
    if (maxPageNum >= currentPageNum) {
      inPaginationState.add(PaginationState.loading);
      await NewsRepo.news(pageNum: currentPageNum).then((result) {
        if (result.error == null) {
          // if (result.status == 1) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _newsResponseSubject.add(result);
          // }
        } else {
          inPaginationState.add(PaginationState.error);
        }
      });
    }
  }

  Future<void> onErrorLoadMore() async {
    if (maxPageNum >= currentPageNum) {
      inPaginationState.add(PaginationState.loading);
      await NewsRepo.news(pageNum: currentPageNum).then((result) {
        if (result.error == null) {
          // if (result.status == true) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          // currentPageNum++;
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _newsResponseSubject.add(result);
          // }
        } else {
          inPaginationState.add(PaginationState.error);
        }
      });
    }
  }

  updateNewsList({
    required int totalItemsCount,
    required List<News> snapshotNews,
  }) {
    totalItemsCount = totalItemsCount;
    for (var notification in snapshotNews) {
      if (newsList.length < totalItemsCount) {
        if (!newsList.contains(notification)) {
          newsList.add(notification);
        }
      }
    }
  }

  void reCallManager() {
    Stream.fromFuture(
      NewsRepo.news(pageNum: currentPageNum),
    ).listen((result) {
      if (result.error == null) {
        _newsResponseSubject.add(result);
        currentPageNum = result.data!.info!.currentPage! + 1;
      } else {
        _newsResponseSubject.addError(result.error);
      }
    });
  }

  void resetManager() {
    currentPageNum = 1;
    maxPageNum = 5;
    totalItemsCount = 0;
    newsList.clear();
    _newsResponseSubject.drain();
  }

  @override
  void dispose() {}
}
