import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static late SharedPreferences sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic putData({
    required String key,
    required bool value,
})async
  {
    await sharedPreferences.setBool(key,value );
  }

 static dynamic  getData({
    required String key,
})
  {
     sharedPreferences.getBool(key);
  }
}