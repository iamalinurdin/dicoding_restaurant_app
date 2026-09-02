import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService;

  NotificationProvider(this._notificationService);

  final int _dailyReminderNotificationId = 0;
  bool? _permission = false;

  bool? get permission => _permission;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  static const String _dailyReminderKey = 'dailyReminder';

  bool _dailyReminder = false;
  bool get dailyReminder => _dailyReminder;

  String _message = '';
  String get message => _message;

  void scheduledDaily11AMNotification() {
    _notificationService.scheduleDaily11AMNotification(
      id: _dailyReminderNotificationId,
    );
  }

  Future<void> requestPermission() async {
    _permission = await _notificationService.requestPermission();
    notifyListeners();
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests = await _notificationService
        .pendingNotificationRequests();

    debugPrint('pending: ${pendingNotificationRequests.length}');

    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    await _notificationService.cancelNotification(id);
  }

  Future<void> toggleDailyReminder(bool value) async {
    debugPrint('value: $value');
    try {
      final prefs = await SharedPreferences.getInstance();

      if (value) {
        // when reminder on
        final permissionGranted = await _notificationService
            .requestPermission();

        _permission = permissionGranted;

        if (permissionGranted != true) {
          _dailyReminder = false;
          prefs.setBool(_dailyReminderKey, false);
          _message = 'notifikasi permission ditolak';
          notifyListeners();

          return;
        }

        await _notificationService.scheduleDaily11AMNotification(
          id: _dailyReminderNotificationId,
        );
        _dailyReminder = true;

        _message = 'daily reminder aktif';
      } else {
        // when reminder off
        await _notificationService.cancelNotification(
          _dailyReminderNotificationId,
        );
        _dailyReminder = false;
        _message = 'daily reminder dimatikan';
      }

      prefs.setBool(_dailyReminderKey, _dailyReminder);
      notifyListeners();
    } catch (e) {
      _message = 'error: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> getDailyReminder() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      _dailyReminder = prefs.getBool(_dailyReminderKey) ?? false;
    } catch (e) {
      _message = 'error: ${e.toString()}';
    }

    notifyListeners();
  }
}
