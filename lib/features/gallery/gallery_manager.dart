import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/gallery/gallery_repo.dart';
import 'package:alsurrah/features/gallery/gallery_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum PaginationState {
  loading,
  success,
  error,
  idle,
}

class GalleryManager extends Manager<GalleryResponse> {
  int currentPageNum = 1;
  int maxPageNum = 5;
  int totalItemsCount = 0;

  List<Gallery> galleryList = [];

  final PublishSubject<GalleryResponse> _galleryResponseSubject =
      PublishSubject<GalleryResponse>();

  Stream<GalleryResponse> get response$ => _galleryResponseSubject.stream;

  final PublishSubject<PaginationState> _paginationStateSubject =
      PublishSubject<PaginationState>();
  Stream<PaginationState> get paginationState$ =>
      _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  ScrollController scrollController = ScrollController();

  GalleryManager() {
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
      await GalleryRepo.gallery(pageNum: currentPageNum).then((result) {
        if (result.error == null) {
          // if (result.status == 1) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _galleryResponseSubject.add(result);
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
      await GalleryRepo.gallery(pageNum: currentPageNum).then((result) {
        if (result.error == null) {
          // if (result.status == true) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          // currentPageNum++;
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _galleryResponseSubject.add(result);
          // }
        } else {
          inPaginationState.add(PaginationState.error);
        }
      });
    }
  }

  updateGalleryList({
    required int totalItemsCount,
    required List<Gallery> snapshotGallery,
  }) {
    totalItemsCount = totalItemsCount;
    for (var gallery in snapshotGallery) {
      if (galleryList.length < totalItemsCount) {
        if (!galleryList.contains(gallery)) {
          galleryList.add(gallery);
        }
      }
    }
  }

  void reCallManager() {
    Stream.fromFuture(
      GalleryRepo.gallery(pageNum: currentPageNum),
    ).listen((result) {
      if (result.error == null) {
        _galleryResponseSubject.add(result);
        currentPageNum = result.data!.info!.currentPage! + 1;
      } else {
        _galleryResponseSubject.addError(result.error);
      }
    });
  }

  void resetManager() {
    currentPageNum = 1;
    maxPageNum = 5;
    totalItemsCount = 0;
    galleryList.clear();
    _galleryResponseSubject.drain();
  }

  @override
  void dispose() {}
}
