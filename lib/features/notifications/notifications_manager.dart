import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/notifications/notifications_repo.dart';
import 'package:alsurrah/features/notifications/notifications_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum PaginationState {
  loading,
  success,
  error,
  idle,
}

class NotificationsManager extends Manager<NotificationsResponse> {
  int currentPageNum = 1;
  int maxPageNum = 5;
  int totalItemsCount = 0;

  List<Notifications> notificationsList = [];

  final PublishSubject<NotificationsResponse>
      _notificationsListResponseSubject =
      PublishSubject<NotificationsResponse>();

  Stream<NotificationsResponse> get response$ =>
      _notificationsListResponseSubject.stream;

  final PublishSubject<PaginationState> _paginationStateSubject =
      PublishSubject<PaginationState>();
  Stream<PaginationState> get paginationState$ =>
      _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  ScrollController scrollController = ScrollController();

  NotificationsManager() {
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
      await NotificationsRepo.notifications(pageNum: currentPageNum)
          .then((result) {
        if (result.error == null) {
          // if (result.status == 1) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _notificationsListResponseSubject.add(result);
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
      await NotificationsRepo.notifications(pageNum: currentPageNum)
          .then((result) {
        if (result.error == null) {
          // if (result.status == true) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          // currentPageNum++;
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _notificationsListResponseSubject.add(result);
          // }
        } else {
          inPaginationState.add(PaginationState.error);
        }
      });
    }
  }

  updateNotificationsList({
    required int totalItemsCount,
    required List<Notifications> snapshotNotifications,
  }) {
    totalItemsCount = totalItemsCount;
    for (var notification in snapshotNotifications) {
      if (notificationsList.length < totalItemsCount) {
        if (!notificationsList.contains(notification)) {
          notificationsList.add(notification);
        }
      }
    }
  }

  void reCallManager() {
    Stream.fromFuture(
      NotificationsRepo.notifications(pageNum: currentPageNum),
    ).listen((result) {
      if (result.error == null) {
        _notificationsListResponseSubject.add(result);
        currentPageNum = result.data!.info!.currentPage! + 1;
      } else {
        _notificationsListResponseSubject.addError(result.error);
      }
    });
  }

  void resetManager() {
    currentPageNum = 1;
    maxPageNum = 5;
    totalItemsCount = 0;
    notificationsList.clear();
    _notificationsListResponseSubject.drain();
  }

  @override
  void dispose() {}
}
