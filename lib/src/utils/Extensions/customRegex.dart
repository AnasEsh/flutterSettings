extension CustomRegexes on RegExp {
  static final MOBILE = RegExp(
      r"^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$",
      caseSensitive: false);
  static final EMAIL =
      RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$", caseSensitive: false);
}
