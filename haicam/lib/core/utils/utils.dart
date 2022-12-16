
import 'constants.dart';

class Utils {

  static List<String> monthAaryy = getMonthArray();

  static List<String> getMonthArray(){
    List<String>  list = [];
    list.add("Jan");
    list.add("Feb");
    list.add("Mar");
    list.add("Apr");
    list.add("May");
    list.add("Jun");
    list.add("Jul");
    list.add("Aug");
    list.add("Sep");
    list.add("Oct");
    list.add("Nov");
    list.add("Dec");

    return list;
  }
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
