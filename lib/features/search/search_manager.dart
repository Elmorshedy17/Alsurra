import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/search/search_repo.dart';
import 'package:alsurrah/features/search/search_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum PaginationState {
  loading,
  success,
  error,
  idle,
}

class SearchManager extends Manager<SearchResponse> {
  final TextEditingController wordController = TextEditingController();

  int currentPageNum = 1;
  int maxPageNum = 5;
  int totalItemsCount = 0;

  List<Products> searchList = [];

  final PublishSubject<SearchResponse> _searchListResponseSubject =
      PublishSubject<SearchResponse>();

  Stream<SearchResponse> get response$ => _searchListResponseSubject.stream;

  final PublishSubject<PaginationState> _paginationStateSubject =
      PublishSubject<PaginationState>();
  Stream<PaginationState> get paginationState$ =>
      _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  ScrollController scrollController = ScrollController();

  SearchManager() {
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
      await SearchRepo.search(
              pageNum: currentPageNum, word: wordController.text)
          .then((result) {
        if (result.error == null) {
          // if (result.status == 1) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _searchListResponseSubject.add(result);

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
      await SearchRepo.search(
              pageNum: currentPageNum, word: wordController.text)
          .then((result) {
        if (result.error == null) {
          // if (result.status == true) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          // currentPageNum++;
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _searchListResponseSubject.add(result);
          // }
        } else {
          inPaginationState.add(PaginationState.error);
        }
      });
    }
  }

  updateSearchList({
    required int totalItemsCount,
    required List<Products> snapshotSearch,
  }) {
    totalItemsCount = totalItemsCount;
    for (var notification in snapshotSearch) {
      if (searchList.length < totalItemsCount) {
        if (!searchList.contains(notification)) {
          searchList.add(notification);
        }
      }
    }
  }

  void reCallManager() {
    Stream.fromFuture(
      SearchRepo.search(pageNum: currentPageNum, word: wordController.text),
    ).listen((result) {
      if (result.error == null) {
        _searchListResponseSubject.add(result);
        currentPageNum = result.data!.info!.currentPage! + 1;
      } else {
        _searchListResponseSubject.addError(result.error);
      }
    });
  }

  void resetManager() {
    currentPageNum = 1;
    maxPageNum = 5;
    totalItemsCount = 0;
    searchList.clear();
    _searchListResponseSubject.drain();
  }

  void resetManagerWithoutTextController() {
    currentPageNum = 1;
    maxPageNum = 5;
    totalItemsCount = 0;
    searchList.clear();
    _searchListResponseSubject.drain();
  }

  @override
  void dispose() {}
}
