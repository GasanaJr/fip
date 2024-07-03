import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String _hasSeenOnboardingKey = 'hasSeenOnboarding';

  static Future<void> setHasSeenOnboarding(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenOnboardingKey, value);
  }

  static Future<bool> getHasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSeenOnboardingKey) ?? false;
  }
}