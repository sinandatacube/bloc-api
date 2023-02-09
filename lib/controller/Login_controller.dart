import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';

class LoginController {
  Future<String?> getImei() async {
    String? deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    return deviceId;
  }
}
