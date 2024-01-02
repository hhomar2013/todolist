import 'package:shared_preferences/shared_preferences.dart';
//   shared_preferences: ^2.2.2
class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async { // starting point
    sharedPreferences = await SharedPreferences.getInstance(); // create file
  }
  static Future<bool> putData({  // saving
    required String key ,
    required bool value ,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }
  static bool? getData({ // getting data
    required String key ,
  }){
    return sharedPreferences!.getBool(key);
    }
}