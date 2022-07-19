import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/hotels_and_chalets/hotels_and_chalets_repo.dart';
import 'package:alsurrah/features/hotels_and_chalets/hotels_and_chalets_response.dart';
import 'package:alsurrah/features/news/news_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum PaginationState {
  loading,
  success,
  error,
  idle,
}

enum TypeHotelChalet {
  hotel,
  chalet,
}

class HotelAndChaletsManager extends Manager<NewsResponse> {
  int currentPageNum = 1;
  int maxPageNum = 5;
  int totalItemsCount = 0;

  String type = '';

  List<Hotels> hotelAndChaletsList = [];

  final PublishSubject<HotelAndChaletsResponse>
      _hotelAndChaletsResponseSubject =
      PublishSubject<HotelAndChaletsResponse>();

  Stream<HotelAndChaletsResponse> get response$ =>
      _hotelAndChaletsResponseSubject.stream;

  final PublishSubject<PaginationState> _paginationStateSubject =
      PublishSubject<PaginationState>();
  Stream<PaginationState> get paginationState$ =>
      _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  ScrollController scrollController = ScrollController();

  HotelAndChaletsManager() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await loadMore(type: type);
      }
    });
  }

  Future<void> loadMore({required String type}) async {
    if (maxPageNum >= currentPageNum) {
      inPaginationState.add(PaginationState.loading);
      await HotelAndChaletsRepo.hotelAndChalets(
              pageNum: currentPageNum, type: type)
          .then((result) {
        if (result.error == null) {
          // if (result.status == 1) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _hotelAndChaletsResponseSubject.add(result);
          // }
        } else {
          inPaginationState.add(PaginationState.error);
        }
      });
    }
  }

  Future<void> onErrorLoadMore({required String type}) async {
    if (maxPageNum >= currentPageNum) {
      inPaginationState.add(PaginationState.loading);
      await HotelAndChaletsRepo.hotelAndChalets(
              pageNum: currentPageNum, type: type)
          .then((result) {
        if (result.error == null) {
          // if (result.status == true) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          // currentPageNum++;
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _hotelAndChaletsResponseSubject.add(result);
          // }
        } else {
          inPaginationState.add(PaginationState.error);
        }
      });
    }
  }

  updateHotelAndChaletsList({
    required int totalItemsCount,
    required List<Hotels> snapshotHotelAndChalets,
  }) {
    totalItemsCount = totalItemsCount;
    for (var notification in snapshotHotelAndChalets) {
      if (hotelAndChaletsList.length < totalItemsCount) {
        if (!hotelAndChaletsList.contains(notification)) {
          hotelAndChaletsList.add(notification);
        }
      }
    }
  }

  void reCallManager({required String type}) {
    Stream.fromFuture(
      HotelAndChaletsRepo.hotelAndChalets(pageNum: currentPageNum, type: type),
    ).listen((result) {
      if (result.error == null) {
        _hotelAndChaletsResponseSubject.add(result);
        currentPageNum = result.data!.info!.currentPage! + 1;
      } else {
        _hotelAndChaletsResponseSubject.addError(result.error);
      }
    });
  }

  void resetManager() {
    currentPageNum = 1;
    maxPageNum = 5;
    totalItemsCount = 0;
    hotelAndChaletsList.clear();
    _hotelAndChaletsResponseSubject.drain();
  }

  @override
  void dispose() {}
}
