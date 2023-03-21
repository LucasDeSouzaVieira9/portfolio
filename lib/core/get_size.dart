import 'package:flutter/cupertino.dart';

class GetSize {
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double heightPorc(BuildContext context, double porcentagem) =>
      porcentagem / 100 * MediaQuery.of(context).size.height;

  static double widthPorc(BuildContext context, double porcentagem) =>
      porcentagem / 100 * MediaQuery.of(context).size.width;

  static bool web(BuildContext context) =>
      MediaQuery.of(context).size.width > 763 ||
      MediaQuery.of(context).size.height < 480;

  static bool getNavBar(BuildContext context) =>
      MediaQuery.of(context).size.width > 768 &&
      MediaQuery.of(context).size.height > 480;
}
