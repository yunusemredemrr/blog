import 'package:blog/src/constants/constants.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  final Widget? leadingIcon;
  final Widget? actionIcon;
  final Function leadingOnPressed;
  final Function actionOnPressed;
  final Color backgroundColor;
  final Color titleColor;
  final String title;

  const DefaultAppBar({
    Key? key,
    this.leadingIcon,
    this.actionIcon,
    required this.leadingOnPressed,
    required this.actionOnPressed,
    required this.backgroundColor,
    required this.titleColor,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 91,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: kGrey,
            offset: Offset(0, 1),
            blurRadius: 4,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.resolveWith((_) => Colors.transparent),
              padding: MaterialStateProperty.resolveWith(
                (_) => EdgeInsets.zero,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 12),
              child: leadingIcon ?? const SizedBox.shrink(),
            ),
            onPressed: () {
              leadingOnPressed();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 12),
            child: Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.resolveWith((_) => Colors.transparent),
              padding: MaterialStateProperty.resolveWith(
                (_) => EdgeInsets.zero,
              ),
            ),
            child: actionIcon ?? const SizedBox.shrink(),
            onPressed: () {
              actionOnPressed();
            },
          ),
        ],
      ),
    );
  }
}
