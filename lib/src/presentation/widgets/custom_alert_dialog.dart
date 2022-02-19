// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'dart:io';
import 'package:blog/src/constants/constants.dart';
import 'package:blog/src/presentation/widgets/default_button.dart';
import 'package:blog/src/presentation/widgets/platform_responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomAlertDialog extends PlatformResponsiveWidget {
  final String title;
  final String cameraButtonText, galleryButtonText;
  final Function cameraButtonOnTap, galleryButtonOnTap;
  final Color? titleColor;

  CustomAlertDialog({
    required this.cameraButtonOnTap,
    required this.galleryButtonOnTap,
    required this.title,
    this.titleColor,
    required this.cameraButtonText,
    required this.galleryButtonText,
  });

  Future<bool?> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context, builder: (context) => this)
        : await showDialog<bool>(
            context: context,
            builder: (context) => this,
            barrierDismissible: false);
  }

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 19,
          ),
        ),
      ),
      actions: _actions(context),
    );
  }

  @override
  Widget buildIosWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 19,
          ),
        ),
      ),
      actions: _actions(context),
    );
  }

  List<Widget> _actions(BuildContext context) {
    return [
      Column(
        children: [
          DefaultButton(
            buttonText: cameraButtonText,
            buttonPressed: () {
              cameraButtonOnTap();
            },
            width: 270,
            height: 56,
            icon: Icon(Icons.camera_alt, color: kGrey),
            textColor: kBackGroundColor,
          ),
          SizedBox(height: 5),
          DefaultButton(
            buttonText: galleryButtonText,
            buttonPressed: () {
              galleryButtonOnTap();
            },
            width: 270,
            height: 56,
            icon: Image.asset("assets/icons/gallery.png"),
            iconColor: kButtonColor,
            butonColor: kBackGroundColor,
          ),
        ],
      )
    ];
  }
}
