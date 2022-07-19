import 'package:alsurrah/app_core/app_core.dart';
import 'package:flutter/material.dart';

class SettingsManager extends Manager {
  ValueNotifier<bool> notificationsSwitch =
      ValueNotifier(locator<PrefsService>().notificationFlag);
  void switchNotifications(bool newValue) {
    notificationsSwitch.value = newValue;
  }

  bool get notificationsStatus => notificationsSwitch.value;

  @override
  void dispose() {}

  void clearSubject() {}
}
