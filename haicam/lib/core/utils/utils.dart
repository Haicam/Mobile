
import 'constants.dart';

class Utils {

  static bool isEmpty(String str) {
    if (str == null || str.length == 0 || str.contains("null")) {
      return true;
    }
    return false;
  }

  static bool StringEqualIgnoreCase(String str1, String str2){
    if(str1.toLowerCase().compareTo(str2.toLowerCase()) == 0){
      return true;
    }
    return false;
  }

  static void sendBroadcast(String event){
    Constants.eventBus!.fire(event);
  }

}
