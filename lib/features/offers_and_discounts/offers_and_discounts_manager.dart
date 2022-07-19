import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/news/news_response.dart';
import 'package:alsurrah/features/offers_and_discounts/offers_and_discounts_repo.dart';
import 'package:alsurrah/features/offers_and_discounts/offers_and_discounts_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum PaginationState {
  loading,
  success,
  error,
  idle,
}

enum Type {
  offer,
  discount,
}

class OffersAndDiscountsManager extends Manager<NewsResponse> {
  int currentPageNum = 1;
  int maxPageNum = 5;
  int totalItemsCount = 0;

  String type = '';

  List<Discounts> offersAndDiscountsList = [];

  final PublishSubject<OffersAndDiscountsResponse>
      _offersAndDiscountsResponseSubject =
      PublishSubject<OffersAndDiscountsResponse>();

  Stream<OffersAndDiscountsResponse> get response$ =>
      _offersAndDiscountsResponseSubject.stream;

  final PublishSubject<PaginationState> _paginationStateSubject =
      PublishSubject<PaginationState>();
  Stream<PaginationState> get paginationState$ =>
      _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  ScrollController scrollController = ScrollController();

  OffersAndDiscountsManager() {
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
      await OffersAndDiscountsRepo.offersAndDiscounts(
              pageNum: currentPageNum, type: type)
          .then((result) {
        if (result.error == null) {
          // if (result.status == 1) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _offersAndDiscountsResponseSubject.add(result);
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
      await OffersAndDiscountsRepo.offersAndDiscounts(
              pageNum: currentPageNum, type: type)
          .then((result) {
        if (result.error == null) {
          // if (result.status == true) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          // currentPageNum++;
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _offersAndDiscountsResponseSubject.add(result);
          // }
        } else {
          inPaginationState.add(PaginationState.error);
        }
      });
    }
  }

  updateOffersAndDiscountsList({
    required int totalItemsCount,
    required List<Discounts> snapshotOffersAndDiscounts,
  }) {
    totalItemsCount = totalItemsCount;
    for (var notification in snapshotOffersAndDiscounts) {
      if (offersAndDiscountsList.length < totalItemsCount) {
        if (!offersAndDiscountsList.contains(notification)) {
          offersAndDiscountsList.add(notification);
        }
      }
    }
  }

  void reCallManager({required String type}) {
    Stream.fromFuture(
      OffersAndDiscountsRepo.offersAndDiscounts(
          pageNum: currentPageNum, type: type),
    ).listen((result) {
      if (result.error == null) {
        _offersAndDiscountsResponseSubject.add(result);
        currentPageNum = result.data!.info!.currentPage! + 1;
      } else {
        _offersAndDiscountsResponseSubject.addError(result.error);
      }
    });
  }

  void resetManager() {
    currentPageNum = 1;
    maxPageNum = 5;
    totalItemsCount = 0;
    offersAndDiscountsList.clear();
    _offersAndDiscountsResponseSubject.drain();
  }

  @override
  void dispose() {}
}
