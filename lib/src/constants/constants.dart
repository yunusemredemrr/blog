// ignore_for_file: prefer_const_constructors

import 'package:blog/src/domain/types/enums/banner_type.dart';
import 'package:blog/src/presentation/widgets/default_notification_banner.dart';
import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF28429A);
const Color kBlueColor = Color.fromARGB(255, 2, 17, 74);
const Color kWhite = Color(0xffffffff);
const Color kBackGroundColor = Color(0xffF8F8F8);
const Color kBlack = Color(0xff000000);
const kGrey = Color(0xffBBBCC7);
const kButtonColor = Color(0xff292f3b);
const Color kErrorTextColor = Colors.red;
const Color kSuccessColor = Color(0xff5cb85c);

bool isMiniMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < 355;
}

Size mSize(context) {
  return MediaQuery.of(context).size;
}

EdgeInsets mPadding(context) {
  return MediaQuery.of(context).padding;
}

TextStyle kLargeTitleStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );
}

TextStyle kTitleStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
}

TextStyle kContentStyleBold(Color color) {
  return TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}

TextStyle kContentStyleThin(Color color) {
  return TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}

TextStyle kHintTextStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}

TextStyle kLoginButtonTextStyle(Color color) {
  return TextStyle(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
}

void kShowBanner(BannerType bannerType, String text, BuildContext context) {
  switch (bannerType) {
    case BannerType.INFO:
      return DefaultNotificationBanner(
        context: context,
        icon: Icon(Icons.info),
        text: text,
        color: Colors.yellow.shade700,
      ).show();

    case BannerType.ERROR:
      return DefaultNotificationBanner(
        context: context,
        icon: Icon(Icons.error),
        text: text,
        color: kErrorTextColor,
      ).show();

    case BannerType.SUCCESS:
      return DefaultNotificationBanner(
        context: context,
        icon: Icon(Icons.check),
        text: text,
        color: kSuccessColor,
      ).show();
  }
}
