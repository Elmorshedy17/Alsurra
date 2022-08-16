import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:alsurrah/app_core/app_core.dart';
import 'package:alsurrah/features/branches/branches_repo.dart';
import 'package:alsurrah/features/branches/branches_response.dart';
import 'package:alsurrah/features/branches/widgets/add_marker.dart';

class CheckBoxManager extends Manager{

  final BehaviorSubject<bool> _checkBoxSubject =
  BehaviorSubject<bool>.seeded(false);

  Sink<bool> get inCheckBox => _checkBoxSubject.sink;
  Stream<bool> get checkBox$ => _checkBoxSubject.stream;
  bool get currentCheckBox => _checkBoxSubject.value;


  void switchStatus(){
    currentCheckBox? inCheckBox.add(false):inCheckBox.add(true);
  }

  @override
  void dispose() {}
}
