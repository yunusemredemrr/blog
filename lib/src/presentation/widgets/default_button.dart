import 'package:blog/src/constants/constants.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Function buttonPressed;
  final String buttonText;
  final double? height;
  final double? width;
  final Color? butonColor;
  final Color? textColor;
  final Color? iconColor;
  final Widget? icon;

  const DefaultButton({
    Key? key,
    required this.buttonPressed,
    required this.buttonText,
    this.height,
    this.width,
    this.butonColor = kButtonColor,
    this.textColor = kButtonColor,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        buttonPressed();
      },
      child: Container(
        decoration: BoxDecoration(
            color: butonColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: kButtonColor,
            )),
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 19.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    icon ?? const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
