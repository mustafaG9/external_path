import 'dart:async';
import 'package:flutter/services.dart';

class ExternalPath {
  static const _channel = MethodChannel('external_path');

  // Using const instead of final for truly constant values
  static const String DIRECTORY_MUSIC = "Music";
  static const String DIRECTORY_PODCASTS = "Podcasts";
  static const String DIRECTORY_RINGTONES = "Ringtones";
  static const String DIRECTORY_ALARMS = "Alarms";
  static const String DIRECTORY_NOTIFICATIONS = "Notifications";
  static const String DIRECTORY_PICTURES = "Pictures";
  static const String DIRECTORY_MOVIES = "Movies";
  static const String DIRECTORY_DOWNLOADS = "Download";
  static const String DIRECTORY_DCIM = "DCIM";
  static const String DIRECTORY_DOCUMENTS = "Documents";
  static const String DIRECTORY_SCREENSHOTS = "Screenshots";
  static const String DIRECTORY_AUDIOBOOKS = "Audiobooks";

  /// Returns a list of external storage directory paths
  static Future<List<String>> getExternalStorageDirectories() async {
    final List storageInfo =
        await _channel.invokeMethod('getExternalStorageDirectories');

    // More efficient approach that does the same operation
    return storageInfo.map<String>((dir) => _getRootDir(dir)).toList();
  }

  /// Returns the path to a public external storage directory of the given type
  static Future<String> getExternalStoragePublicDirectory(String type) async {
    return await _channel
        .invokeMethod('getExternalStoragePublicDirectory', {'type': type});
  }

  // Move helper method inside the class for better encapsulation
  // Made private as it's an implementation detail
  static String _getRootDir(String path) {
    final parts = path.split("/");
    return parts.sublist(0, parts.length - 4).join("/");
  }
}
