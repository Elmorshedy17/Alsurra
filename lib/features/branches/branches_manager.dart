import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/branches/branches_repo.dart';
import 'package:alsurrah/features/branches/branches_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class BranchesManager extends Manager<BranchesResponse> {
  final BehaviorSubject<Set<Marker>> markersSubject =
      BehaviorSubject<Set<Marker>>();

  final BehaviorSubject<BranchesResponse> subject =
      BehaviorSubject<BranchesResponse>();
  Stream<BranchesResponse> get branches$ => subject.stream;

  execute() {
    Stream.fromFuture(BranchesRepo.branches()).listen((result) {
      if (result.error == null) {
        subject.sink.add(result);
      } else {
        subject.sink.addError(result.error);
      }
    });
  }

  @override
  void dispose() {}
}
