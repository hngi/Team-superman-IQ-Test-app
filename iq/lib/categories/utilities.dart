import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPreferences preferences;

  //Setting the Category Key
  Future<void> setCategory(String category) async {
    final preferences = await SharedPreferences.getInstance();
    final key = 'categories';
    final valueStored = category;

    preferences.setString(key, valueStored);
  }

  //Setting the Timing Key
  Future<void> setIsTimed(bool isTimed) async {
    final preferences = await SharedPreferences.getInstance();
    final key = 'isTimed';
    final valueStored = isTimed;

    preferences.setBool(key, valueStored);
  }

  //Retrieving the category key
  Future<String> getCategory() async {
    final preferences = await SharedPreferences.getInstance();
    final key = 'categories';
    final valueStored = preferences.getString(key) ?? '0';

    return valueStored;
  }

  //Retrieving the Timing Key
  Future<bool> getIsTimed() async {
    final preferences = await SharedPreferences.getInstance();
    final key = 'isTimed';
    final valueStored = preferences.getBool(key) ?? false;

    return valueStored;
  }
}