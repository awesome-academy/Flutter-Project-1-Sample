class StringUtils {
  static String getBillionNumber(String number) {
    String dotSubString = number.substring(0, number.indexOf('.'));
    return "${dotSubString.substring(0, dotSubString.length - 9)}B\$";
  }
}
