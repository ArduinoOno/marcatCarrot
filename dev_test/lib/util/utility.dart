import 'package:intl/intl.dart';

class DataUtility{
  static final oCcy = new NumberFormat("# ###","ko_KR");
  static String calcStringToWon(String price) {
    // 가격정보 정수형 체크
    // null 이면 문자열
    // null 이아니면 형변환을 했을때 정수로 형변환이 가능한
    // 문자열
    if(int.tryParse(price) != null)
    {
      return "${oCcy.format(int.parse(price))}원";
    }
    else
    {
      return price;
    }
  }
}