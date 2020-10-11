import 'package:shared_preferences/shared_preferences.dart';

class SPServices {
  Future<bool> getcurrentTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool darkTheme = pref.getBool('DarkTheme');
    return darkTheme;
  }
}
