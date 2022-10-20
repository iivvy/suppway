import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MainRepository {
  static List<Cookie> cookies = [];
  static String authorization = "";
  static String userAgent = '';
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  Map<String, String> get getBaseHeaders {
    return {
      'Accept': 'application/json',
      // 'Accept-Encoding': 'gzip, deflate',
      "User-Agent": getUserAgent,
    };
  }

  Map<String, String> get getHeadersWithAuthorization {
    Map<String, String> headers = getBaseHeaders;
    headers["Authorization"] = authorization;
    return headers;
  }

  String get getUserAgent {
    return userAgent;
  }

  ///  save Token
  void setAuthorization(String token) {
    authorization = "Bearer $token";
  }

  /// save UserAgent
  Future setUserAgent() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      userAgent =
          "$appName/$version build/$buildNumber Android ${info.version.release};  ${info.product},${info.brand}";
    } else if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfoPlugin.iosInfo;
      userAgent =
          "$appName/$version build/$buildNumber ${info.systemName},${info.identifierForVendor} iOS/${info.systemVersion};  ${info.name},${info.model} ";
    } else {
      userAgent = '$appName/$version build/$buildNumber';
    }
  }
}
