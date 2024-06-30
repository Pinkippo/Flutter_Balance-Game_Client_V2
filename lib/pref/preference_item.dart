import 'package:yangjataekil/pref/app_preferences.dart';

/// 앱 정보 설정 - Rx
class PreferenceItem<T> {
  final T defaultValue;
  final String key;

  PreferenceItem(this.key, this.defaultValue);

  void call(T value) {
    AppPreferences.setValue<T>(this, value);
  }

  Future<bool> set(T value) {
    return AppPreferences.setValue<T>(this, value);
  }

  T get() {
    return AppPreferences.getValue<T>(this);
  }

  Future<bool> delete() {
    return AppPreferences.deleteValue<T>(this);
  }
}