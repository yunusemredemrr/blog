// ignore_for_file: body_might_complete_normally_nullable

import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatformResponsiveWidget extends StatelessWidget {
  const PlatformResponsiveWidget({Key? key}) : super(key: key);

  Widget? buildAndroidWidget(BuildContext context) {}
  Widget? buildIosWidget(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildIosWidget(context)!;
    } else {
      return buildAndroidWidget(context)!;
    }
  }
}
