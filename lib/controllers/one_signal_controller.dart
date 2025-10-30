import 'dart:developer';

import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSingleController extends GetxController implements GetxService {
  static const String oneSignalAppId = '9cc2976-3ddf-4b06-9dfd-9f9d86609b86';

  initPlatForm() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(oneSignalAppId);
    bool permissionGranted =
        await OneSignal.Notifications.requestPermission(true);

    log('Notification Permission Granted: $permissionGranted',
        name: 'PermissionStatus');
    if (permissionGranted) {
      OneSignal.User.pushSubscription.optIn();
    }
    await OneSignal.consentRequired(true);
    await OneSignal.consentGiven(true);
    log('${OneSignal.User.pushSubscription.id}', name: 'ID');
    Future.delayed(const Duration(seconds: 10), () async {
      log('${OneSignal.User.pushSubscription.id}', name: 'PushSubscription_ID');
      final deviceId = await getDeviceId();
      log(deviceId, name: 'PushSubscription_ID');
    });

    var state = OneSignal.User.pushSubscription;
    log('Subscribed: ${state.optedIn}, Token: ${state.token}, ID: ${state.id}',
        name: 'PushState');

    OneSignal.Notifications.addForegroundWillDisplayListener(
        (OSNotificationWillDisplayEvent event) {
      event.notification.display();
    });

    OneSignal.Notifications.addClickListener((OSNotificationClickEvent result) {
      log('Notification Clicked: ${result.notification.title}',
          name: 'NotificationClick');
    });
  }

  Future<String> getDeviceId() async {
    return OneSignal.User.pushSubscription.id ?? 'deviceID';
  }
}
