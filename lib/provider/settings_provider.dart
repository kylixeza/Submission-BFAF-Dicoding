import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:submission_bfaf_v2/data/preference/preference_helper.dart';
import 'package:submission_bfaf_v2/scheduling/background_service.dart';
import 'package:submission_bfaf_v2/scheduling/date_time_helper.dart';

class SettingsProvider extends ChangeNotifier {
  final PreferenceHelper preferenceHelper;

  SettingsProvider({required this.preferenceHelper}) {
    _getDailyRestaurantPreferences();
  }

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  bool _isDailyRestaurantActive = false;
  bool get isDailyRestaurantActive => _isDailyRestaurantActive;

  Future<bool> scheduledDailyRestaurant(bool value) async {
    _isScheduled = value;
    if(_isScheduled) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }

  void _getDailyRestaurantPreferences() async {
    _isDailyRestaurantActive = await preferenceHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDailyRestaurant(bool value) {
    preferenceHelper.setDailyRestaurant(value);
    _getDailyRestaurantPreferences();
  }
}