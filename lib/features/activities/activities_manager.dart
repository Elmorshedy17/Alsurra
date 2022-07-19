import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/activities/activities_repo.dart';
import 'package:alsurrah/features/activities/activities_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum PaginationState {
  loading,
  success,
  error,
  idle,
}

class ActivitiesManager extends Manager<ActivitiesResponse> {
  int currentPageNum = 1;
  int maxPageNum = 5;
  int totalItemsCount = 0;

  List<Activity> activities = [];

  final PublishSubject<ActivitiesResponse> _activitiesResponseSubject =
      PublishSubject<ActivitiesResponse>();

  Stream<ActivitiesResponse> get response$ => _activitiesResponseSubject.stream;

  final PublishSubject<PaginationState> _paginationStateSubject =
      PublishSubject<PaginationState>();
  Stream<PaginationState> get paginationState$ =>
      _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  ScrollController scrollController = ScrollController();

  ActivitiesManager() {
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
      await ActivitiesRepo.activities(pageNum: currentPageNum).then((result) {
        if (result.error == null) {
          // if (result.status == 1) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _activitiesResponseSubject.add(result);
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
      await ActivitiesRepo.activities(pageNum: currentPageNum).then((result) {
        if (result.error == null) {
          // if (result.status == true) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          // currentPageNum++;
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _activitiesResponseSubject.add(result);
          // }
        } else {
          inPaginationState.add(PaginationState.error);
        }
      });
    }
  }

  updateActivitiesList({
    required int totalItemsCount,
    required List<Activity> snapshotActivities,
  }) {
    totalItemsCount = totalItemsCount;
    for (var activity in snapshotActivities) {
      if (activities.length < totalItemsCount) {
        if (!activities.contains(activity)) {
          activities.add(activity);
        }
      }
    }
  }

  void reCallManager() {
    Stream.fromFuture(
      ActivitiesRepo.activities(pageNum: currentPageNum),
    ).listen((result) {
      if (result.error == null) {
        _activitiesResponseSubject.add(result);
        currentPageNum = result.data!.info!.currentPage! + 1;
      } else {
        _activitiesResponseSubject.addError(result.error);
      }
    });
  }

  void resetManager() {
    currentPageNum = 1;
    maxPageNum = 5;
    totalItemsCount = 0;
    activities.clear();
    _activitiesResponseSubject.drain();
  }

  @override
  void dispose() {}
}
