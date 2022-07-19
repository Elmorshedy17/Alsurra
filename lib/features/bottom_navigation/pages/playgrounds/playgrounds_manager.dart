import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/bottom_navigation/pages/playgrounds/playgrounds_repo.dart';
import 'package:alsurrah/features/bottom_navigation/pages/playgrounds/playgrounds_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum PaginationState {
  loading,
  success,
  error,
  idle,
}

class PlaygroundsManager extends Manager<PlaygroundsResponse> {
  int currentPageNum = 1;
  int maxPageNum = 5;
  int totalItemsCount = 0;

  List<Playground> playgrounds = [];

  final PublishSubject<PlaygroundsResponse> _playgroundsResponseSubject =
      PublishSubject<PlaygroundsResponse>();

  Stream<PlaygroundsResponse> get response$ =>
      _playgroundsResponseSubject.stream;

  final PublishSubject<PaginationState> _paginationStateSubject =
      PublishSubject<PaginationState>();
  Stream<PaginationState> get paginationState$ =>
      _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  ScrollController scrollController = ScrollController();

  PlaygroundsManager() {
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
      await PlaygroundsRepo.playgrounds(pageNum: currentPageNum).then((result) {
        if (result.error == null) {
          // if (result.status == 1) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _playgroundsResponseSubject.add(result);
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
      await PlaygroundsRepo.playgrounds(pageNum: currentPageNum).then((result) {
        if (result.error == null) {
          // if (result.status == true) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          // currentPageNum++;
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _playgroundsResponseSubject.add(result);
          // }
        } else {
          inPaginationState.add(PaginationState.error);
        }
      });
    }
  }

  updatePlaygroundsList({
    required int totalItemsCount,
    required List<Playground> snapshotPlaygrounds,
  }) {
    totalItemsCount = totalItemsCount;
    for (var playground in snapshotPlaygrounds) {
      if (playgrounds.length < totalItemsCount) {
        if (!playgrounds.contains(playground)) {
          playgrounds.add(playground);
        }
      }
    }
  }

  void reCallManager() {
    Stream.fromFuture(
      PlaygroundsRepo.playgrounds(pageNum: currentPageNum),
    ).listen((result) {
      if (result.error == null) {
        _playgroundsResponseSubject.add(result);
        currentPageNum = result.data!.info!.currentPage! + 1;
      } else {
        _playgroundsResponseSubject.addError(result.error);
      }
    });
  }

  void resetManager() {
    currentPageNum = 1;
    maxPageNum = 5;
    totalItemsCount = 0;
    playgrounds.clear();
    _playgroundsResponseSubject.drain();
  }

  @override
  void dispose() {}
}
