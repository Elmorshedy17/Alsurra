import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/festivals/festivals_repo.dart';
import 'package:alsurrah/features/festivals/festivals_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum PaginationState {
  loading,
  success,
  error,
  idle,
}

class FestivalsManager extends Manager<FestivalsResponse> {
  int currentPageNum = 1;
  int maxPageNum = 5;
  int totalItemsCount = 0;

  List<Offers> festivalsList = [];

  final PublishSubject<FestivalsResponse> _festivalsResponseSubject =
      PublishSubject<FestivalsResponse>();

  Stream<FestivalsResponse> get response$ => _festivalsResponseSubject.stream;

  final PublishSubject<PaginationState> _paginationStateSubject =
      PublishSubject<PaginationState>();
  Stream<PaginationState> get paginationState$ =>
      _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  ScrollController scrollController = ScrollController();

  FestivalsManager() {
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
      await FestivalsRepo.festivals(pageNum: currentPageNum).then((result) {
        if (result.error == null) {
          // if (result.status == 1) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _festivalsResponseSubject.add(result);
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
      await FestivalsRepo.festivals(pageNum: currentPageNum).then((result) {
        if (result.error == null) {
          // if (result.status == true) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          // currentPageNum++;
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _festivalsResponseSubject.add(result);
          // }
        } else {
          inPaginationState.add(PaginationState.error);
        }
      });
    }
  }

  updateFestivalsList({
    required int totalItemsCount,
    required List<Offers> snapshotFestivals,
  }) {
    totalItemsCount = totalItemsCount;
    for (var notification in snapshotFestivals) {
      if (festivalsList.length < totalItemsCount) {
        if (!festivalsList.contains(notification)) {
          festivalsList.add(notification);
        }
      }
    }
  }

  void reCallManager() {
    Stream.fromFuture(
      FestivalsRepo.festivals(pageNum: currentPageNum),
    ).listen((result) {
      if (result.error == null) {
        _festivalsResponseSubject.add(result);
        currentPageNum = result.data!.info!.currentPage! + 1;
      } else {
        _festivalsResponseSubject.addError(result.error);
      }
    });
  }

  void resetManager() {
    currentPageNum = 1;
    maxPageNum = 5;
    totalItemsCount = 0;
    festivalsList.clear();
    _festivalsResponseSubject.drain();
  }

  @override
  void dispose() {}
}
