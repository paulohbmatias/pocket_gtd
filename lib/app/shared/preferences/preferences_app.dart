import 'package:shared_preferences/shared_preferences.dart';

class PreferencesApp{
  static String _firstTimeKey = "first_time";

  static Future<bool> isTheFirstTime() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = prefs.getBool(_firstTimeKey);
    if(result != null){
      return result;
    }else{
      return true;
    }
  }

  static Future<void> setIsTheFirstTime(bool firstTime) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_firstTimeKey, firstTime);
  }

}