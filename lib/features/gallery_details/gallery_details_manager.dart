import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/gallery_details/gallery_details_repo.dart';
import 'package:alsurrah/features/gallery_details/gallery_details_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum ShowZoomable {
  show,
  hide,
}

class GalleryDetailsManager extends Manager<GalleryDetailsResponse> {
  final PublishSubject<GalleryDetailsResponse> _subject =
      PublishSubject<GalleryDetailsResponse>();

  Stream<GalleryDetailsResponse> get galleryDetails$ => _subject.stream;

  execute({required int galleryId}) {
    Stream.fromFuture(GalleryDetailsRepo.galleryDetails(galleryId: galleryId))
        .listen((result) {
      if (result.error == null) {
        _subject.sink.add(result);
      } else {
        _subject.sink.addError(result.error);
      }
    });
  }

  //****************************************************************************
  final ValueNotifier<ShowZoomable> _showZoomableNotifier =
      ValueNotifier<ShowZoomable>(ShowZoomable.hide);
  ValueNotifier<ShowZoomable> get showZoomableNotifier => _showZoomableNotifier;
  ShowZoomable get showZoomable => _showZoomableNotifier.value;
  set showZoomable(ShowZoomable val) => _showZoomableNotifier.value = val;
  //****************************************************************************

  @override
  void dispose() {}
}
