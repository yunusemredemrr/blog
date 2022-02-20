// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'dart:io';

import 'package:blog/src/constants/constants.dart';
import 'package:blog/src/presentation/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomButtomSheet extends StatelessWidget {
  XFile? photo;
  final Function removeButtonPressed, selectButtonPressed;
  CustomButtomSheet({
    this.photo,
    required this.selectButtonPressed,
    required this.removeButtonPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      height: (_size.height * 2 / 3) - 91,
      width: _size.width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kBackGroundColor,
        boxShadow: [
          BoxShadow(
            color: kGrey,
            blurRadius: 15,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 362,
              height: 340,
              child: _showPhoto(),
            ),
            SizedBox(height: 11),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DefaultButton(
                  buttonPressed: () {
                    selectButtonPressed();
                  },
                  buttonText: "Select",
                  width: 174,
                  height: 56,
                  textColor: kWhite,
                  icon: Icon(
                    Icons.logout,
                    color: kBackGroundColor,
                  ),
                ),
                DefaultButton(
                  buttonPressed: () {
                    removeButtonPressed();
                  },
                  buttonText: "Remove",
                  width: 177,
                  height: 57,
                  butonColor: kBackGroundColor,
                  icon: Icon(
                    Icons.logout,
                  ),
                ),
              ],
            ),
            SizedBox(height: 9),
          ],
        ),
      ),
    );
  }

  _showPhoto() {
    return photo != null
        ? Image.file(File(photo!.path))
        : Image.asset("assets/images/no_profile.png");
  }
}
