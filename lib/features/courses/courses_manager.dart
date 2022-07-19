import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/activities/activities_response.dart';
import 'package:alsurrah/features/courses/courses_repo.dart';
import 'package:alsurrah/features/courses/courses_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum PaginationState {
  loading,
  success,
  error,
  idle,
}

class CoursesManager extends Manager<ActivitiesResponse> {
  int currentPageNum = 1;
  int maxPageNum = 5;
  int totalItemsCount = 0;

  List<Courses> courses = [];

  final PublishSubject<CoursesResponse> _coursesResponseSubject =
      PublishSubject<CoursesResponse>();

  Stream<CoursesResponse> get response$ => _coursesResponseSubject.stream;

  final PublishSubject<PaginationState> _paginationStateSubject =
      PublishSubject<PaginationState>();
  Stream<PaginationState> get paginationState$ =>
      _paginationStateSubject.stream;
  Sink<PaginationState> get inPaginationState => _paginationStateSubject.sink;

  ScrollController scrollController = ScrollController();

  CoursesManager() {
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
      await CoursesRepo.courses(pageNum: currentPageNum).then((result) {
        if (result.error == null) {
          // if (result.status == 1) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _coursesResponseSubject.add(result);
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
      await CoursesRepo.courses(pageNum: currentPageNum).then((result) {
        if (result.error == null) {
          // if (result.status == true) {
          currentPageNum = result.data!.info!.currentPage! + 1;
          inPaginationState.add(PaginationState.success);
          // currentPageNum++;
          maxPageNum = result.data!.info!.lastPage ?? 0;
          _coursesResponseSubject.add(result);
          // }
        } else {
          inPaginationState.add(PaginationState.error);
        }
      });
    }
  }

  updateCoursesList({
    required int totalItemsCount,
    required List<Courses> snapshotCourses,
  }) {
    totalItemsCount = totalItemsCount;
    for (var course in snapshotCourses) {
      if (courses.length < totalItemsCount) {
        if (!courses.contains(course)) {
          courses.add(course);
        }
      }
    }
  }

  void reCallManager() {
    Stream.fromFuture(
      CoursesRepo.courses(pageNum: currentPageNum),
    ).listen((result) {
      if (result.error == null) {
        _coursesResponseSubject.add(result);
        currentPageNum = result.data!.info!.currentPage! + 1;
      } else {
        _coursesResponseSubject.addError(result.error);
      }
    });
  }

  void resetManager() {
    currentPageNum = 1;
    maxPageNum = 5;
    totalItemsCount = 0;
    courses.clear();
    _coursesResponseSubject.drain();
  }

  @override
  void dispose() {}
}
